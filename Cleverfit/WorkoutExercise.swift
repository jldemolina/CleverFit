//
//  WorkoutExercise.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 3/2/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import Foundation

class WorkoutExercise {
    let exercise: Exercise
    let durationInSeconds: Int
    var feedback: WorkoutExerciseFeedback = WorkoutExerciseFeedback.normal
    
    init(exercise: Exercise, withDuration: Int) {
        self.exercise = exercise
        self.durationInSeconds = withDuration
    }
}

enum WorkoutExerciseFeedback {
    case bad
    case normal
    case good
}
