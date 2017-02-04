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
    let workoutExercises = List<WorkoutExercise>()
    dynamic var startDate = NSDate()
    dynamic var endDate = NSDate();
}
