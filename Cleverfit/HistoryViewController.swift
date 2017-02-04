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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Historial"
        self.workoutsTableView.delegate = self
        self.workoutsTableView.dataSource = self
    }
    
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyWorkoutCell") as! HistoryWorkoutCell
        cell.workoutNameLabel.text = "ENTRENAMIENTO DE EJEMPLO 1".uppercased()
        cell.workoutDateLabel.text = "02/02/16";
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "WebSegue", sender: indexPath)
        //tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
