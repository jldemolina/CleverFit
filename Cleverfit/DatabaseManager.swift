//
//  DatabaseManager.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 4/2/17.
//  Copyright © 2017 SebastianAndersen. All rights reserved.
//

import RealmSwift

class TableManager {
    let realm = try! Realm()

    func load() -> User {
        return User()
    }
    
    func save(workoutRoutine: User) -> Bool {
        return false
    }
    
    func load() -> WorkoutExercise {
        return WorkoutExercise()
    }
    
    func save(workoutRoutine: WorkoutExercise) -> Bool {
        return false
    }
    
    func load() -> [WorkoutExercise] {
        return [WorkoutExercise]()
    }
    
    func save(workoutRoutine: [WorkoutExercise]) -> Bool {
        return false
    }
    
}
