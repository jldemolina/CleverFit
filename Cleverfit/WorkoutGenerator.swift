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
    private let user: User
    private let exercises: [Exercise]

    init(forUser: User, andExercises: [Exercise]) {
        user = forUser
        exercises = andExercises
    }

    // TODO CALCULATE EXERCISE INTENSITY
    func generateRoutine() -> WorkoutRoutine {
        let workoutRoutine = WorkoutRoutine()
        
        let cleverExerciseList = CleverExerciseList(exercises: exercises, for: user)
        let generatedExercises = cleverExerciseList.generateRecomendedExerciseList()
        
        for exercise in generatedExercises {
            let workoutExercise = WorkoutExercise()
            workoutExercise.durationInSeconds = 30 // TODO CALCULATE
            workoutExercise.exercise = exercise
            workoutRoutine.workoutExercises.append(workoutExercise)
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
    
    
    init(exercises: [Exercise], for user: User) {
        self.exerciseNodes = [CleverExerciseListItem]()
        self.user = user
        fillList(with: exercises)
    }
    
    public func generateRecomendedExerciseList()-> [Exercise] {
        guard !exerciseNodes.isEmpty else { return [Exercise]() }
        var generatedList = [Exercise]()
        let exercisesNumber = 20 // TODO GENERATE THIS
        for index in 1...exercisesNumber {
            var highestItem = exerciseNodes[0]
            for item in exerciseNodes {
                if (index != 0) {
                    item.previousExercises = generatedList
                }
                if item.heuristicValue > highestItem.heuristicValue {
                    highestItem = item
                }
            }
            generatedList.append(highestItem.value)
        }
        return generatedList
    }
    
    private func fillList(with data: [Exercise]) {
        for index in 0...data.count - 1 {
            exerciseNodes.append(CleverExerciseListItem(value: data[index], for: user))
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
    var heuristicValue: Int {
        get {
            return calculateHeuristicValueForNode()
        }
    }

    
    init(value: Exercise, for user: User, with previousExercises: [Exercise]?) {
        self.value = value
        self.user = user
        self.previousExercises = previousExercises
    }
    
    convenience init(value: Exercise, for user: User) {
        self.init(value: value, for: user, with: nil)
    }
    
    private func calculateHeuristicValueForNode()-> Int {
        return calculateExperienceValue() + calculateValueForRepetitiveExercise() - numberOfTimesTrainedInParent()
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
            if previousExercise.id == value.id {
                repetitions += 1
            }
        }
        
        return repetitions
    }
    
}
