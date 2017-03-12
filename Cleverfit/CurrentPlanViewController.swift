//
//  SecondViewController.swift
//  SSASideMenuExample
//
//  Created by Jose Luis Molina on 20/10/14.
//  Copyright (c) 2015 Jose Luis Molina. All rights reserved.
//

import UIKit

class CurrentPlanViewController: CleverFitViewController {
    @IBOutlet weak var exercisesTableView: UITableView!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var trainButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    fileprivate var exercises = [WorkoutExercise]()

    @IBAction func startWorkoutAction(_ sender: AnyObject) {

    }

    @IBAction func generateWorkoutAction(_ sender: AnyObject) {

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CURRENT_PLAN_VIEW_TITLE".localized
        self.exercisesTableView.delegate = self
        self.exercisesTableView.dataSource = self
        self.loadExercises()
    }
    
    private func loadExercises() {
        let routines: [WorkoutRoutine]? = DatabaseManager.sharedInstance.load()
        if (routines != nil) {
            if let workoutExercises = routines?.last?.workoutExercises {
                exercises.append(contentsOf: workoutExercises)
            }
        }
    }

}

extension CurrentPlanViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if exercises.isEmpty {
            return 1
        }
        return exercises.count
    }

    // TODO REFACTOR AND STORE IDS, CREATE CELLS
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (exercises.isEmpty) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "currentPlanDoNotExistsCell") as! CurrentPlanDoNotExists
            cell.delegates.append(self)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "currentPlanExerciseCell") as! CurrentPlanExerciseCell
            cell.initView(with: exercises[indexPath.row], number: indexPath.row + 1)
            return cell
        }

    }

    func tableView(_ tableView: UIKit.UITableView, heightForRowAt indexPath: Foundation.IndexPath) -> CoreGraphics.CGFloat {
        if (exercises.isEmpty) {
            return CGFloat(CleverFitParams.CellHeights.currentPlanNotExistsCell.rawValue)
        }
        return CGFloat(CleverFitParams.CellHeights.currentPlanExerciseCell.rawValue)
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "WebSegue", sender: indexPath)
        //tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}

extension CurrentPlanViewController: CurrentPlanDoNotExistDelegate {

    func generationStarted() {
        print("GENERATION STARTED")
    }

    func generationFinished(workoutRoutine: WorkoutRoutine) {
        print("GENERATION FINISHED")
        self.exercises = Array(workoutRoutine.workoutExercises)
        self.tableView.reloadData()
    }


}
