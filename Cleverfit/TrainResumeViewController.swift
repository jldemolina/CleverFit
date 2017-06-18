//
//  TrainResumeViewController.swift
//  Cleverfit
//
//  Created by Jose Luis Molina on 28/4/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import UIKit

class TrainResumeViewController: CleverFitViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var finishButton: UIButtonCorner!
    
    
    @IBAction func actionFinishWorkout(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideNavigationBar()
    }
    
}
