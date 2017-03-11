//
//  Muscle.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 3/2/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import RealmSwift
import Foundation

final class Muscle: Object {
    dynamic var id = ""
    private dynamic var muscleName = MuscleName.biceps.rawValue
    var name: MuscleName {
        get {
            return MuscleName(rawValue: muscleName)!
        }
        set {
            muscleName = newValue.rawValue
        }
    }
}

enum MuscleName: String {
    case biceps = "MUSCLE_BICEPS"
    case triceps = "MUSCLE_TRICEPS"
    case forearm = "MUSCLE_FOREARMS"
    case back = "MUSCLE_BACK"
    case chest = "MUSCLE_CHEST"
    case abdominals = "MUSCLE_ABDOMINALS"
    case quadriceps = "MUSCLE_QUADRICEPS"

    static func from(muscleName: String) -> MuscleName {
        switch muscleName {
        case MuscleName.biceps.rawValue:
            return .biceps
        case MuscleName.triceps.rawValue:
            return .triceps
        case MuscleName.forearm.rawValue:
            return .forearm
        case MuscleName.back.rawValue:
            return .back
        case MuscleName.chest.rawValue:
            return .chest
        case MuscleName.abdominals.rawValue:
            return .abdominals
        default:
            return .quadriceps
        }
    }
}
