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
    
    
    @IBAction func startWorkoutAction(_ sender: AnyObject) {
        
    }
    
    @IBAction func generateWorkoutAction(_ sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CURRENT_PLAN_VIEW_TITLE".localized
        self.exercisesTableView.delegate = self
        self.exercisesTableView.dataSource = self
    }
    
}

extension CurrentPlanViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currentPlanExerciseCell") as! CurrentPlanExerciseCell
        cell.exerciseNameLabel.text = "FLEXIONES A UNA MANO".uppercased()
        cell.exerciseTimeLabel.text = "0 segundos"
        cell.exerciseIndexLabel.text = "\(indexPath.row + 1)"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "WebSegue", sender: indexPath)
        //tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
