//
//  User.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 4/2/17.
//  Copyright © 2017 SebastianAndersen. All rights reserved.
//

import RealmSwift
import Foundation

class User: Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var weight = 0
    dynamic var height = 0
    dynamic var maxRoutineDurationInSeconds = 0
    dynamic var birthDate = NSDate();
    private dynamic var objective = UserObjective.slimDown.rawValue
    private dynamic var experience = UserExperience.low.rawValue
    private dynamic var alertsPreference = UserAlertsPreference.notifyMe.rawValue
    var objectiveFeedback: UserObjective {
        get {
            return UserObjective(rawValue: objective)!
        }
        set {
            objective = newValue.rawValue
        }
    }
    var userExperience: UserExperience {
        get {
            return UserExperience(rawValue: experience)!
        }
        set {
            experience = newValue.rawValue
        }
    }
    var userAlertsPreference: UserAlertsPreference {
        get {
            return UserAlertsPreference(rawValue: alertsPreference)!
        }
        set {
            alertsPreference = newValue.rawValue
        }
    }
}

enum UserObjective: String {
    case slimDown
    case loseWeight
}

enum UserExperience: String {
    case low
    case half
    case high
}

enum UserAlertsPreference: String {
    case doNotNotifyMe
    case notifyMe
}
