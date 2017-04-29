//
//  TrainViewController.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 14/9/16.
//

import UIKit
import UICircularProgressRing
import SwiftyTimer

class TrainViewController: CleverFitViewController {
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var doNotLikeButton: UIButton!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var circularProgressView: UICircularProgressRingView!
    @IBOutlet weak var ExerciseImageView: UIImageView!
    
    private var workoutExerciseTimer: WorkoutExerciseTimer?
    public var workoutRoutine: WorkoutRoutine? {
        didSet {
            if workoutRoutine != nil {
                self.workoutExerciseTimer = WorkoutExerciseTimer(delegate: self, workoutRoutine: workoutRoutine!)
            }
        }
    }
    
    @IBAction func stopWorkoutAction(_ sender: AnyObject) {
        workoutExerciseTimer?.stop()
        CloseViewCommand(currentNavigationController: navigationController!).execute()
    }

    @IBAction func playOrPauseWorkoutAction(_ sender: AnyObject) {
        workoutExerciseTimer?.toggleStatus()
    }

    @IBAction func skipWorkoutAction(_ sender: AnyObject) {
        guard workoutExerciseTimer != nil else { return }

        if workoutExerciseTimer!.changeExerciseIfPossible() {
            workoutExerciseTimer!.pause()
        }
    }

    @IBAction func doNotLikeWorkoutAction(_ sender: AnyObject) {
        // TODO
    }
    
    convenience init?(coder aDecoder: NSCoder, with workoutRoutine: WorkoutRoutine) {
        self.init(coder: aDecoder)
        self.workoutExerciseTimer = WorkoutExerciseTimer(delegate: self, workoutRoutine: workoutRoutine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
        circularProgressView.animationStyle = kCAMediaTimingFunctionLinear
        circularProgressView.outerRingColor = UIColor.black
        circularProgressView.innerRingColor = UIColor.cyan
        circularProgressView.shouldShowValueText = false
        circularProgressView.value = 30
        circularProgressView.maxValue = 30
        
        hideNavigationBar()
        
    }

}


extension TrainViewController: WorkoutExerciseTimerDelegate {
    func timeUpdated(currentTimeValue: Int) {
        circularProgressView.value = CGFloat(currentTimeValue)
    }
    
    func workoutStarted() {
        // TODO - ¿?
    }
    
    func workoutFinished() {
        OpenTrainResumeCommand(currentNavigationController: navigationController!).execute()
    }
    
    func exerciseChanged(workoutExercise: WorkoutExercise) {
        circularProgressView.maxValue = CGFloat(workoutExercise.durationInSeconds)
        circularProgressView.value = CGFloat(workoutExercise.durationInSeconds)
        if let exercise = workoutExercise.exercise {
            exerciseNameLabel.text = exercise.name.uppercased()
            ExerciseImageView.image = UIImage(named: exercise.id)
        }
    }
}

