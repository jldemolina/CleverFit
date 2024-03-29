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
    private dynamic var objective = UserObjective.loseWeight.rawValue
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
    case loseWeight = "USER_OBJECTIVE_LOSE_WEIGHT"
    case maintenanceWeight = "USER_OBJECTIVE_MAINTENANCE"
    
    static func from(userObjectiveName: String) ->UserObjective {
        switch userObjectiveName {
        case UserObjective.loseWeight.rawValue:
            return .loseWeight
        default:
            return .maintenanceWeight
        }
    }
}

enum UserExperience: String {
    case low = "USER_EXPERIENCE_NEW"
    case half = "USER_EXPERIENCE_HALF"
    case hard = "USER_EXPERIENCE_HIGH"
    
    static func from(userExperience: String) ->UserExperience {
        switch userExperience {
        case UserExperience.low.rawValue:
            return .low
        case UserExperience.half.rawValue:
            return .half
        default:
            return .hard
        }
    }
}

enum UserAlertsPreference: String {
    case doNotNotifyMe = "USER_ALERT_NOT_NOTIFY"
    case notifyMe = "USER_ALERT_NOTIFY"
    
    static func from(userAlertsPreference: String) ->UserAlertsPreference {
        switch userAlertsPreference {
        case UserAlertsPreference.doNotNotifyMe.rawValue:
            return .doNotNotifyMe
        default:
            return .notifyMe
        }
    }
}
