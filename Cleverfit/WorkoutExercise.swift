//
//  WorkoutExercise.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 3/2/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import RealmSwift
import Foundation

class WorkoutExercise: Object {
    dynamic var id = ""
    dynamic var exercise: Exercise? = nil
    dynamic var durationInSeconds = 0
    private dynamic var feedback = WorkoutExerciseFeedback.normal.rawValue
    var workoutExerciseFeedback: WorkoutExerciseFeedback {
        get {
            return WorkoutExerciseFeedback(rawValue: feedback)!
        }
        set {
            feedback = newValue.rawValue
        }
    }
}

enum WorkoutExerciseFeedback: String {
    case bad
    case normal
    case good
}
