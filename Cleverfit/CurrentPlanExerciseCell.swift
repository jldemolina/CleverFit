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
    @IBOutlet weak var exerciseImageView: UIImageView!
    
    func initView(with workoutExercise: WorkoutExercise, number: Int) {
        if let exercise = workoutExercise.exercise {
            self.exerciseNameLabel.text = exercise.name
            self.exerciseTimeLabel.text = "\(workoutExercise.durationInSeconds) \(LocalizedString.CurrentPlanView.seconds)"
            self.exerciseIndexLabel.text = "\(number)"
            self.exerciseImageView.image = UIImage(named: exercise.id)
        }
    }
}
