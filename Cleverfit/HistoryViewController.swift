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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        /*if exercises.isEmpty {
            return 1
        }*/
        return workouts.count
    }
    
    // TODO REFACTOR AND STORE IDS, CREATE CELLS
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       /* if (exercises.isEmpty) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "currentPlanDoNotExistsCell") as! CurrentPlanDoNotExists
            cell.delegates.append(self)
            return cell
        } else { */
            let cell = tableView.dequeueReusableCell(withIdentifier: "historyWorkoutCell") as! HistoryWorkoutCell
            cell.initView(with: workouts[indexPath.row])
            return cell
        //}
        
    }
    
    /*
    func tableView(_ tableView: UIKit.UITableView, heightForRowAt indexPath: Foundation.IndexPath) -> CoreGraphics.CGFloat {
        if (exercises.isEmpty) {
            return CGFloat(CleverFitParams.CellHeights.currentPlanNotExistsCell.rawValue)
        }
        return CGFloat(CleverFitParams.CellHeights.currentPlanExerciseCell.rawValue)
    }
    */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "WebSegue", sender: indexPath)
        //tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    

}
