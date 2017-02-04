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
    case biceps
    case triceps
    case forearm
    case back
    case chest
    case abdominals
    case quadriceps
}
