//
//  ExerciseViewController.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 16/9/16.
//  Copyright © 2016 Jose Luis Molina. All rights reserved.
//

import UIKit

class ExerciseViewController: CleverFitViewController {
    @IBOutlet weak var exerciseDescriptionLabel: UILabel!
    @IBOutlet weak var exerciseImage: UIImageView!
    var workoutExercise: WorkoutExercise

    convenience init?(coder aDecoder: NSCoder, workoutExercise: WorkoutExercise) {
        self.init(coder: aDecoder)
        self.workoutExercise = workoutExercise
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.workoutExercise = WorkoutExercise()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = workoutExercise.exercise?.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureView()
    }
    
    private func configureView() {
        if let currentExercise = workoutExercise.exercise {
            exerciseDescriptionLabel.text = currentExercise.information
            exerciseDescriptionLabel.numberOfLines = 0
            exerciseDescriptionLabel.sizeToFit()
            
            exerciseImage.image = UIImage(named: currentExercise.id)
        }
    }

}
