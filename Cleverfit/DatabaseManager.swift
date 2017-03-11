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
    private let csvManager = CSVManager()
    static let sharedInstance = DatabaseManager()

    func load() -> User? {
        return realm.objects(User.self).first as User?
    }

    func load() -> [WorkoutRoutine]? {
        let storedRoutines = realm.objects(WorkoutRoutine.self)
        return Array(storedRoutines)
    }

    func load() -> [Exercise] {
        return csvManager.loadExercises()
    }

    func add(user: User) -> Bool {
        var added = false
        try! realm.write {
            realm.add(user)
            added = true
        }
        return added
    }

    func add(routine: WorkoutRoutine) -> Bool {
        var added = false
        try! realm.write {
            realm.add(routine)
            added = true
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

fileprivate class CSVManager {

    func loadExercises() -> [Exercise] {
        var exercises = [Exercise]()
        let parser = CSVParser(with: CleverFitParams.ExerciseStorage.path.rawValue, separator: CleverFitParams.ExerciseStorage.paramsSeparator.rawValue, headers: CleverFitParams.ExerciseStorage.headerParams)

        for row in parser.rows {
            let exercise = Exercise()
            exercise.id = row[0]
            exercise.name = row[1]
            exercise.information = row[2]
            exercise.exerciseDifficulty = ExerciseDifficulty.from(difficultyName: row[3])
            exercise.affectedMuscles = affectedMuscles(affectedMuscles: row[4])
            exercises.append(Exercise())
        }

        return exercises
    }

    private func affectedMuscles(affectedMuscles: String)-> List<Muscle> {
        let muscles = List<Muscle>()
        let stringList = affectedMuscles.components(separatedBy: CleverFitParams.ExerciseStorage.paramListSeparator.rawValue)

        for string in stringList {
            let muscle = Muscle()
            muscle.name = MuscleName(rawValue: string)!
            muscles.append(muscle)
        }

        return muscles
    }

}
