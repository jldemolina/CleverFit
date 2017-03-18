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
    }

    enum CellHeights: Int {
        case currentPlanNotExistsCell = 253
        case currentPlanExerciseCell = 79
    }

    enum ExerciseStorage: String {
        static let headerParams = ["id", "name", "information", "difficulty", "affectedMuscles"]
        static let headerMuscleListParams = ["name"]
        static var path : String {
            if let filePath = Bundle.main.path(forResource: "Exercises", ofType: "csv", inDirectory: "Data") {
                if FileManager().fileExists(atPath: filePath) {
                    return filePath
                }
            }
            return ""
        }
        case paramsSeparator = ";"
        case paramListSeparator = ","
    }

}
