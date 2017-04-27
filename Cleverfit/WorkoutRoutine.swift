//
//  WorkoutRoutine.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 3/2/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import RealmSwift
import Foundation

class WorkoutRoutine: Object {
    dynamic var id = ""
    dynamic var startDate = NSDate()
    dynamic var endDate = NSDate().add(days: 30)
    let workoutExercises = List<WorkoutExercise>()
}
