//
//  CurrentPlanExerciseCell.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 15/9/16.
//  Copyright © 2016 Jose Luis Molina. All rights reserved.
//

import UIKit

class CurrentPlanDoNotExists: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var generateRoutineButton: UIButtonCorner!
    var delegates = [GenerateRoutineCommandDelegate]()

    @IBAction func generateNewRoutineAction(_ sender: UIButton) {
        GenerateRoutineCommand(with: delegates).execute()
    }
    
}
