//
//  TrainViewController.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 14/9/16.
//

import UIKit

class ResumeViewController: UIViewController {
    @IBOutlet weak var exercisesTableView: UITableView!

    override func viewDidLoad() {
        self.exercisesTableView.delegate = self
        self.exercisesTableView.dataSource = self
    }

}

extension ResumeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resumeExerciseCell") as! ResumeExerciseCell
        cell.exerciseNameLabel.text = "FLEXIONES A UNA MANO".uppercased()
        cell.exerciseTimeLabel.text = "0 segundos"
        cell.exerciseIndexLabel.text = "\(indexPath.row + 1)"
        return cell
    }

}
