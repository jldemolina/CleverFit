//
//  HistoryViewController.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 13/9/16.
//  Copyright © 2016 Jose Luis Molina. All rights reserved.
//

import UIKit

class HistoryViewController: CleverFitViewController {
    @IBOutlet weak var workoutsTableView: UITableView!
    fileprivate var workouts = [WorkoutRoutine]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HISTORY_VIEW_TITLE".localized
        self.workoutsTableView.delegate = self
        self.workoutsTableView.dataSource = self
        loadWorkoutRoutines()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showNavigationBar()
    }
    
    func loadWorkoutRoutines() {
        let routines: [WorkoutRoutine]? = DatabaseManager.sharedInstance.load()
        if (routines != nil) {
            workouts.append(contentsOf: routines!)
        }
    }

}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if workouts.isEmpty {
            return 1
        }
        return workouts.count
    }
    
    // TODO REFACTOR AND STORE IDS, CREATE CELLS
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if (workouts.isEmpty) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "currentPlanDoNotExistsCell") as! CurrentPlanDoNotExists
            cell.delegates.append(self)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "historyWorkoutCell") as! HistoryWorkoutCell
            cell.initView(with: workouts[indexPath.row])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UIKit.UITableView, heightForRowAt indexPath: Foundation.IndexPath) -> CoreGraphics.CGFloat {
        if (workouts.isEmpty) {
            return CGFloat(CleverFitParams.CellHeights.currentPlanNotExistsCell.rawValue)
        }
        return CGFloat(CleverFitParams.CellHeights.historyCell.rawValue)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (!workouts.isEmpty) {
            OpenPlanViewCommand(currentNavigationController: navigationController!, workoutToOpen: workouts[indexPath.row]).execute()
        }
    }
    
}

extension HistoryViewController: GenerateRoutineCommandDelegate {
    
    func generationStarted() {
        print("GENERATION STARTED")
    }
    
    func generationFinished(workoutRoutine: WorkoutRoutine) {
        print("GENERATION FINISHED")
        if saveRoutine(workoutRoutine: workoutRoutine) {
            self.workouts.append(workoutRoutine)
            self.workoutsTableView.reloadData()
        }
    }
    
    private func saveRoutine(workoutRoutine: WorkoutRoutine)-> Bool {
        return DatabaseManager.sharedInstance.add(routine: workoutRoutine)
    }
    
}
