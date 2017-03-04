//
//  Exercise.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 3/2/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import RealmSwift
import Foundation

final class Exercise: Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var information = ""
    private dynamic var difficulty = ExerciseDifficulty.medium.rawValue
    var exerciseDifficulty: ExerciseDifficulty {
        get {
            return ExerciseDifficulty(rawValue: difficulty)!
        }
        set {
            difficulty = newValue.rawValue
        }
    }
    let affectedMuscles = List<Muscle>()
}

enum ExerciseDifficulty: String {
    case low = "EXERCISE_DIFFICULTY_LOW"
    case medium = "EXERCISE_DIFFICULTY_HALF"
    case hard = "EXERCISE_DIFFICULTY_HIGH"
    
    static func from(difficultyName: String) ->ExerciseDifficulty {
        switch difficultyName {
        case ExerciseDifficulty.hard.rawValue:
            return .hard
        case ExerciseDifficulty.medium.rawValue:
            return .medium
        default:
            return .low
        }
    }

}
