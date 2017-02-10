//
//  WorkoutGenerator.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 4/2/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import Foundation

class WorkoutGenerator {
    private let user: User
    private let userRoutines: [WorkoutRoutine]
    private let exercises: [Exercise]
    
    init(currentUserRoutines: [WorkoutRoutine]?, forUser: User, andExercises: [Exercise]) {
        user = forUser
        exercises = andExercises
        if currentUserRoutines != nil {
            userRoutines = currentUserRoutines!
        } else {
            userRoutines = [WorkoutRoutine]()
        }
    }
    
    func generateRoutine() -> WorkoutRoutine {
        let currentRoutine = WorkoutRoutine()
        if userRoutines.isEmpty {
            return generateRoutineForUserWithoutHistory(currentRoutine: currentRoutine)
        } else {
            return generateRoutineForUser(currentRoutine: currentRoutine)
        }
    }
    
    private func generateRoutineForUserWithoutHistory(currentRoutine: WorkoutRoutine) -> WorkoutRoutine {
        var currentExercisesInRoutine = 0;
        while (currentExercisesInRoutine != totalNumberOfExercises()) {
            
        }
        return currentRoutine
    }
    
    private func generateRoutineForUser(currentRoutine: WorkoutRoutine) -> WorkoutRoutine {
        var currentExercisesInRoutine = 0;
        while (currentExercisesInRoutine != totalNumberOfExercises()) {
            
        }
        return currentRoutine
    }
    
    private func lowPriorityExercises() -> [Exercise] {
        var exercises = [Exercise]()
        for routine in userRoutines {
            for workoutExercise in Array(routine.workoutExercises) {
                if workoutExercise.workoutExerciseFeedback == WorkoutExerciseFeedback.bad {
                    if workoutExercise.exercise != nil {
                        exercises.append(workoutExercise.exercise!)
                    }
                }
            }
        }
        return exercises
    }
    
    private func filterExercises(forList: [Exercise], withMuscleWithName: MuscleName) -> [Exercise] {
        var searchExercises = [Exercise]()
        
        for exercise in forList {
            for muscle in exercise.affectedMuscles {
                if muscle.name == withMuscleWithName {
                    searchExercises.append(exercise)
                    break;
                }
            }
        }
        
        return searchExercises
    }
    
    private func filterExercisesWithDifficulty(forList: [Exercise], withDifficulty: ExerciseDifficulty) -> [Exercise] {
        var searchExercises = [Exercise]()
        
        for exercise in forList {
            if exercise.exerciseDifficulty == withDifficulty {
                searchExercises.append(exercise)
            }
        }
        
        return searchExercises
    }
    
    private func totalNumberOfExercises() -> Int {
        return (user.objectiveFeedback == UserObjective.loseWeight) ? 20 : 0
    }
    
}
