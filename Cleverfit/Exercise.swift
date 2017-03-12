//
//  Exercise.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 3/2/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import RealmSwift
import Foundation

func ==(lhs: Exercise, rhs: Exercise) -> Bool {
    return lhs.id == rhs.id
}

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
    var affectedMuscles = List<Muscle>()
    
    public func isEasy()-> Bool {
        return exerciseDifficulty == ExerciseDifficulty.low
    }
    
    public func isNormal()-> Bool {
        return exerciseDifficulty == ExerciseDifficulty.medium
    }
    
    public func isHard()-> Bool {
        return exerciseDifficulty == ExerciseDifficulty.hard

    }

}

enum ExerciseDifficulty: String {
    case low = "EXERCISE_DIFFICULTY_LOW"
    case medium = "EXERCISE_DIFFICULTY_HALF"
    case hard = "EXERCISE_DIFFICULTY_HARD"

    static func from(difficultyName: String) -> ExerciseDifficulty {
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
