//
//  HistoryWorkoutCell.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 15/9/16.
//  Copyright © 2016 Jose Luis Molina. All rights reserved.
//

import UIKit

// TODO NAME?
class HistoryWorkoutCell: UITableViewCell {
    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var workoutDateLabel: UILabel!
    
    func initView(with workoutRoutine: WorkoutRoutine) {
        workoutDateLabel.text = workoutRoutine.startDate.description
        workoutNameLabel.text = "Rutina"
    }

    
}
