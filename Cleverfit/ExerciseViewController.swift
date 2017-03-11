//
//  ExerciseViewController.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 16/9/16.
//  Copyright © 2016 Jose Luis Molina. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseDescriptionLabel: UILabel!

    @IBAction func closeModal(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {})
    }

}
