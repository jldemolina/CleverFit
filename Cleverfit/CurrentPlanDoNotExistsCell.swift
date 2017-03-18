//
//  CurrentPlanExerciseCell.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 15/9/16.
//  Copyright © 2016 Jose Luis Molina. All rights reserved.
//

import UIKit

// TODO REFACTOR
class CurrentPlanDoNotExists: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var generateRoutineButton: UIButtonCorner!
    var delegates = [CurrentPlanDoNotExistDelegate]()

    // TODO ASYNC METHOD
    @IBAction func generateNewRoutineAction(_ sender: UIButton) {
        let user: User? = DatabaseManager.sharedInstance.load()
        let exercises: [Exercise] = DatabaseManager.sharedInstance.load()
        notifyGenerationStarted()
        if (user != nil && !exercises.isEmpty) {
            let workoutGenerator = WorkoutGenerator(forUser: user!, andExercises: exercises)
            let workoutRoutine = workoutGenerator.generateRoutine()
            notifyGenerationFinished(workoutRoutine: workoutRoutine)
        }
    }

    private func notifyGenerationStarted() {
        for delegate in delegates {
            delegate.generationStarted()
        }
    }

    private func notifyGenerationFinished(workoutRoutine: WorkoutRoutine) {
        for delegate in delegates {
            delegate.generationFinished(workoutRoutine: workoutRoutine)
        }
    }
}

protocol CurrentPlanDoNotExistDelegate {
    func generationStarted();
    func generationFinished(workoutRoutine: WorkoutRoutine);
}
