//
//  Exercise.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 3/2/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import Foundation

final class Exercise {
    let name: String
    let description: String
    let affectedMuscles: [Muscle]
    let difficulty: ExerciseDifficulty
    
    init(name: String, description: String,
         affectedMuscles: [Muscle], difficulty: ExerciseDifficulty) {
        self.name = name
        self.description = description
        self.affectedMuscles = affectedMuscles
        self.difficulty = difficulty
    }
}

enum ExerciseDifficulty {
    case low
    case medium
    case hard
}
