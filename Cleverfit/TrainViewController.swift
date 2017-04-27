//
//  TrainViewController.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 14/9/16.
//

import UIKit
import UICircularProgressRing

class TrainViewController: UIViewController {
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var doNotLikeButton: UIButton!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var circularProgressView: UICircularProgressRingView!

    @IBAction func stopWorkoutAction(_ sender: AnyObject) {

    }

    @IBAction func pauseWorkoutAction(_ sender: AnyObject) {

    }

    @IBAction func skipWorkoutAction(_ sender: AnyObject) {

    }

    @IBAction func doNotLikeWorkoutAction(_ sender: AnyObject) {

    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
        circularProgressView.animationStyle = kCAMediaTimingFunctionLinear
        circularProgressView.outerRingColor = UIColor.black
        circularProgressView.innerRingColor = UIColor.cyan
        circularProgressView.shouldShowValueText = false
        circularProgressView.value = 30
        circularProgressView.maxValue = 30
    }

}
