//
//  WorkoutRoutine.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 3/2/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import Foundation

class WorkoutRoutine {
    var workoutExercises: [WorkoutExercise]
    let startDate: Date
    let endDate: Date
    
    init(workoutExercises: [WorkoutExercise], startDate: Date, endDate: Date) {
        self.workoutExercises = workoutExercises
        self.startDate = startDate
        self.endDate = endDate
    }
    
}
