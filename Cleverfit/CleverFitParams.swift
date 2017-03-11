//
//  CleverFitParams.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 16/2/17.
//  Copyright © 2017 SebastianAndersen. All rights reserved.
//

import Foundation

final class CleverFitParams {

    static let storyboardName = "Main"

    enum ViewController: String {
        case historyViewController
        case exerciseViewController
        case meViewController
        case currentPlanViewController
        case trainViewController
        case resumeViewController
        case generateWorkoutViewController
        case registerUserViewController
        case settingsViewController
        case mainTabbarController
        case mainNavigationController
        case registerNavigationController
    }

    enum ExerciseStorage: String {
        static let headerParams = ["id", "name", "information", "difficulty", "affectedMuscles"]
        case path = "./Data/Exercises.csv"
        case paramsSeparator = ";"
        case paramListSeparator = ","
    }

}
