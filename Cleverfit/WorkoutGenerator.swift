//
//  WorkoutGenerator.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 4/2/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import Foundation
import RealmSwift

class WorkoutGenerator {
    
    fileprivate static let maximunRestTime = 60
    fileprivate static let mediumRestTime = 40
    fileprivate static let minorRestTime = 30
    
    fileprivate static let maximunExerciseTime = 60
    fileprivate static let mediumExerciseTime = 40
    fileprivate static let minorExerciseTime = 20
    
    fileprivate static let maximunAddedTime = 15
    fileprivate static let mediumAddedTime = 5
    fileprivate static let minorAddedTime = 0
    
    private let user: User
    private let exercises: [Exercise]
    
    init(forUser: User, andExercises: [Exercise]) {
        user = forUser
        exercises = andExercises
    }
    
    func generateRoutine(history: [WorkoutRoutine]) -> WorkoutRoutine {
        let workoutRoutine = WorkoutRoutine()
        
        let cleverExerciseList = CleverExerciseList(exercises: exercises, for: user, previousWorkouts: history)
        
        let generatedExercises = cleverExerciseList.generateRecomendedExerciseList()
        
        for exercise in generatedExercises {
            workoutRoutine.workoutExercises.append(exercise)
        }
        
        return workoutRoutine
    }
    
    
    private func totalNumberOfExercises()-> Int {
        return (user.objectiveFeedback == UserObjective.loseWeight) ? 20 : 20
    }
    
}

fileprivate class CleverExerciseList {
    private var exerciseNodes: [CleverExerciseListItem]
    private let user: User
    private let exercises: [Exercise]
    var previousWorkouts: [WorkoutRoutine]
    
    init(exercises: [Exercise], for user: User, previousWorkouts: [WorkoutRoutine]) {
        self.exerciseNodes = [CleverExerciseListItem]()
        self.user = user
        self.previousWorkouts = previousWorkouts
        self.exercises = exercises
    }
    
    public func generateRecomendedExerciseList()-> [WorkoutExercise] {
        fillList(with: exercises)
        guard !exerciseNodes.isEmpty else { return [WorkoutExercise]() }
        var generatedList = [WorkoutExercise]()
        var timeSpent = 0

        while timeSpent < user.maxRoutineDurationInSeconds {
            var highestItem = exerciseNodes[0]
            for index in 0..<exerciseNodes.count {
                exerciseNodes[index].previousExercises = getExerciseList(from: generatedList)
                
                if exerciseNodes[index].heuristicValue > highestItem.heuristicValue {
                    highestItem = exerciseNodes[index]
                }
            }
            
            let workoutExercise = WorkoutExercise()
            
            workoutExercise.exercise = highestItem.value
            workoutExercise.restInSeconds =  calculateExerciseDuration(exercise: highestItem.value, timeSpent: timeSpent, totalTime: user.maxRoutineDurationInSeconds)
            workoutExercise.durationInSeconds = calculateExerciseRestDuration(exercise: highestItem.value, timeSpent: timeSpent, totalTime: user.maxRoutineDurationInSeconds)
            
            timeSpent += workoutExercise.restInSeconds + workoutExercise.durationInSeconds
            
            generatedList.append(workoutExercise)
            
        }
        
        return generatedList
    }
    
    private func getExerciseList(from workoutExerciseList: [WorkoutExercise])-> [Exercise] {
        var exercises = [Exercise]()
        for workoutExercise in workoutExerciseList {
            if let exercise = workoutExercise.exercise {
                exercises.append(exercise)
            }
        }
        return exercises
    }
    
    private func calculateExerciseDuration(exercise: Exercise, timeSpent: Int, totalTime: Int)-> Int {
        var exerciseDuration = 0
        switch exercise.exerciseDifficulty {
        case ExerciseDifficulty.hard:
            exerciseDuration += WorkoutGenerator.maximunRestTime
        case ExerciseDifficulty.medium:
            exerciseDuration += WorkoutGenerator.mediumRestTime
        default:
            exerciseDuration += WorkoutGenerator.minorRestTime
        }
        
        switch user.userExperience {
        case UserExperience.hard:
            exerciseDuration += WorkoutGenerator.maximunAddedTime
        case UserExperience.half:
            exerciseDuration += WorkoutGenerator.mediumAddedTime
        default:
            exerciseDuration += WorkoutGenerator.minorAddedTime
        }
        
        return exerciseDuration
    }
    
    private func calculateExerciseRestDuration(exercise: Exercise, timeSpent: Int, totalTime: Int)-> Int {
        switch exercise.exerciseDifficulty {
        case ExerciseDifficulty.hard:
            return WorkoutGenerator.minorRestTime
        case ExerciseDifficulty.medium:
            return WorkoutGenerator.mediumRestTime
        default:
            return WorkoutGenerator.minorRestTime
        }
    }
    
    private func fillList(with data: [Exercise]) {
        for index in 0...data.count - 1 {
            exerciseNodes.append(CleverExerciseListItem(value: data[index], for: user, previousWorkouts: previousWorkouts))
        }
    }
    
    private func cut(list: [Exercise], to position: Int)-> [Exercise] {
        guard position > 0 else { return [Exercise]() }
        var cuttedExercises = [Exercise]()
        
        for index in 0...position {
            cuttedExercises.append(list[index])
        }
        
        return cuttedExercises
    }
    
}

fileprivate class CleverExerciseListItem {
    var value: Exercise
    var user: User
    var previousExercises: [Exercise]?
    var previousWorkouts: [WorkoutRoutine]
    var heuristicValue: Int {
        get {
            return calculateHeuristicValueForNode()
        }
    }
    
    init(value: Exercise, for user: User, previousWorkouts: [WorkoutRoutine]) {
        self.value = value
        self.user = user
        self.previousWorkouts = previousWorkouts
    }
    
    private func calculateHeuristicValueForNode()-> Int {
        return calculateExperienceValue() + calculateExperienceValue() * 2 - numberOfTimesTrainedInParent()  - previousMuscularGroupTrainerIntensity() + calculateExistInPreviousRoutinesValue()
    }
    
    private func calculateExperienceValue()-> Int {
        if user.isNotExperimented() && value.isEasy() {
            return 3
        } else if user.isNotExperimented() && value.isNormal() {
            return 2
        }
        
        if user.isModeratelyExperimented() && value.isNormal() {
            return 3
        } else if user.isNotExperimented() && value.isEasy() {
            return 2
        }
        
        if (user.isExperimented() && value.isHard()) {
            return 3
        } else if user.isNotExperimented() && value.isNormal() {
            return 2
        }
        
        return 0
    }
    
    private func previousMuscularGroupTrainerIntensity()-> Int {
        var repetitions = 0

        if previousExercises == nil {
            return repetitions
        }
        
        for previousExercise in previousExercises! {
            for index in 0..<value.affectedMuscles.count {
                if previousExercise.affectedMuscles.contains(value.affectedMuscles[index]) {
                    repetitions += 1 * value.affectedMuscles.count - index
                }
            }
        }
        
        return repetitions
    }
    
    private func calculateValueForRepetitiveExercise()-> Int {
        if exerciseExistsInParent() {
            return 0
        }
        return 3
    }


    private func exerciseExistsInParent()-> Bool {
        if previousExercises == nil {
            return false
        }
        
        for previousExercise in previousExercises! {
            if previousExercise.id == value.id {
                return true
            }
        }
        
        return false
    }
    
    private func numberOfTimesTrainedInParent()-> Int {
        if previousExercises == nil {
            return 0
        }
        
        var repetitions = 0
        
        for previousExercise in previousExercises! {
            if previousExercise.name.lowercased() == value.name.lowercased() {
                repetitions += 1
            }
        }
        
        return repetitions
    }
    
    private func calculateExistInPreviousRoutinesValue()-> Int {
        guard !previousWorkouts.isEmpty else { return 0 }
        
        var repetitions = 0

        for index in 0..<previousWorkouts.count {
            for workoutExercise in previousWorkouts[index].workoutExercises {
                if let exercise = workoutExercise.exercise {
                    if exercise.name.lowercased() == value.name.lowercased() {
                        repetitions -= 1
                        if index == previousWorkouts.count - 1 {
                            repetitions -= index
                        }
                    }
                }
            }
        }
        
        return repetitions
    }
    
}




