//
//  CurrentPlanExerciseCell.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 15/9/16.
//  Copyright © 2016 Jose Luis Molina. All rights reserved.
//

import UIKit

class CurrentPlanExerciseCell: UITableViewCell {
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseIndexLabel: UILabel!
    @IBOutlet weak var exerciseTimeLabel: UILabel!

    // TODO STORE STRINGS
    func initView(with workoutExercise: WorkoutExercise, number: Int) {
        self.exerciseNameLabel.text = workoutExercise.exercise!.name
        self.exerciseTimeLabel.text = "\(workoutExercise.durationInSeconds) segundos"
        self.exerciseIndexLabel.text = "\(number)"
    }
}
