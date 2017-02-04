//
//  DatabaseManager.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 4/2/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import RealmSwift

class DatabaseManager {
    private let realm = try! Realm()
    static let sharedInstance = DatabaseManager()

    func load() -> User? {
        return realm.objects(User.self).first as User?
    }
    
    func load() -> [WorkoutRoutine]? {
        let storedRoutines = realm.objects(WorkoutRoutine.self)
        return Array(storedRoutines)
    }
    
    func add(user: User) -> Bool {
        var added = false
        try! realm.write {
            realm.add(user)
            added = true;
        }
        return added
    }
    
    func add(routine: WorkoutRoutine) -> Bool {
        var added = false
        try! realm.write {
            realm.add(routine)
            added = true;
        }
        return added
    }
    
    func update(user: User) -> Bool {
        var updated = false
        let storedUser = realm.objects(User.self).first
        try! realm.write {
            storedUser!.birthDate = user.birthDate
            storedUser!.height = user.height
            storedUser!.name = user.name
            storedUser!.objectiveFeedback = user.objectiveFeedback
            storedUser!.userAlertsPreference = user.userAlertsPreference
            storedUser!.userExperience = user.userExperience
            storedUser!.weight = user.weight
            storedUser!.maxRoutineDurationInSeconds = user.maxRoutineDurationInSeconds
            updated = true
        }
        return updated
    }
    
    func update(routine: WorkoutRoutine) -> Bool {
        var updated = false
        let storedRoutine = realm.objects(WorkoutRoutine.self).filter("id = \(routine.id)").first
        try! realm.write {
            storedRoutine!.startDate = routine.startDate
            storedRoutine!.endDate = routine.endDate
            storedRoutine!.workoutExercises.removeAll()
            storedRoutine!.workoutExercises.append(objectsIn: routine.workoutExercises)
            updated = true
        }
        return updated
    }
    
    func delete(routine: WorkoutRoutine) -> Bool {
        var updated = false
        let storedRoutine = realm.objects(WorkoutRoutine.self).filter("id = \(routine.id)").first
        try! realm.write {
            realm.delete(storedRoutine!)
            updated = true
        }
        return updated
    }
    
}
