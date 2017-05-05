//
//  SecondViewController.swift
//  SSASideMenuExample
//
//  Created by Jose Luis Molina on 20/10/14.
//  Copyright (c) 2015 Jose Luis Molina. All rights reserved.
//

import UIKit
import SCLAlertView

class CurrentPlanViewController: CleverFitViewController {
    
    @IBOutlet weak var exercisesTableView: UITableView!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var trainButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    public var workoutRoutine: WorkoutRoutine
    
    
    @IBAction func startworkoutAction(_ sender: Any) {
        OpenTrainViewCommand(currentNavigationController: navigationController!, workoutToOpen: workoutRoutine).execute()
    }
    
    @IBAction func generateNewRoutine(_ sender: Any) {
        GenerateRoutineCommand(with: self).execute()
    }
    
    convenience init?(coder aDecoder: NSCoder, with workoutRoutine: WorkoutRoutine) {
        self.init(coder: aDecoder)
        self.workoutRoutine = workoutRoutine
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.workoutRoutine = WorkoutRoutine()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureTitle()
        showNavigationBar()
        if loadExercisesIfNeeded() && currentRoutineHasFinished() {
            showGenerateNewRoutineModal()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        workoutRoutine = WorkoutRoutine()
    }
    
    private func configureTitle() {
        if workoutRoutine.workoutExercises.isEmpty {
            self.title = LocalizedString.CurrentPlanView.title
        } else {
            self.title = workoutRoutine.startDate.description
        }
    }
    
    private func loadExercisesIfNeeded()-> Bool {
        if workoutRoutine.workoutExercises.isEmpty {
            loadExercises()
            return true
        }
        return false
    }
    
    private func currentRoutineHasFinished()-> Bool {
        return Date() >= workoutRoutine.endDate as Date
    }
    
    private func loadExercises() {
        let routines: [WorkoutRoutine]? = DatabaseManager.sharedInstance.load()
        if (routines != nil) {
            if let workoutExercises = routines?.last?.workoutExercises {
                fillWorkoutRoutine(with: Array(workoutExercises))
            }
        }
    }
    
    private func fillWorkoutRoutine(with exercises: [WorkoutExercise]) {
        for workoutExercise in exercises {
            workoutRoutine.workoutExercises.append(workoutExercise)
        }
    }
    
    // TODO - DATE FROM 1975...
    private func showGenerateNewRoutineModal() {
        let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton(LocalizedString.CurrentPlanView.generateRoutineDialogButton) {
            GenerateRoutineCommand(with: self).execute()
        }
        alertView.addButton(LocalizedString.CurrentPlanView.updateDataDialogButton) {
            OpenSettingsViewCommand(currentNavigationController: self.navigationController!).execute()
        }
        alertView.addButton(LocalizedString.CurrentPlanView.CloseDialogButton) {
            alertView.dismiss(animated: true, completion: nil)
        }
        alertView.showSuccess(LocalizedString.CurrentPlanView.generateRoutineDialogtitle, subTitle: LocalizedString.CurrentPlanView.generateRoutineDialogBody)
    }
    
}

extension CurrentPlanViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if workoutRoutine.workoutExercises.isEmpty {
            return 1
        }
        return workoutRoutine.workoutExercises.count
    }

    // TODO REFACTOR AND STORE IDS, CREATE CELLS
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (workoutRoutine.workoutExercises.isEmpty) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "currentPlanDoNotExistsCell") as! CurrentPlanDoNotExists
            cell.delegates.append(self)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "currentPlanExerciseCell") as! CurrentPlanExerciseCell
            cell.initView(with: workoutRoutine.workoutExercises[indexPath.row], number: indexPath.row + 1)
            return cell
        }

    }

    func tableView(_ tableView: UIKit.UITableView, heightForRowAt indexPath: Foundation.IndexPath) -> CoreGraphics.CGFloat {
        if (workoutRoutine.workoutExercises.isEmpty) {
            return CGFloat(CleverFitParams.CellHeights.currentPlanNotExistsCell.rawValue)
        }
        return CGFloat(CleverFitParams.CellHeights.currentPlanExerciseCell.rawValue)
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        OpenExerciseViewCommand(currentNavigationController: self.navigationController!, exerciseToOpen: workoutRoutine.workoutExercises[indexPath.row]).execute()
    }

}

extension CurrentPlanViewController: GenerateRoutineCommandDelegate {
    
    func generationStarted() {
        print(LocalizedString.CurrentPlanView.generationStarted)
    }
    
    func generationFinished(workoutRoutine: WorkoutRoutine) {
        print(LocalizedString.CurrentPlanView.generationFinished)
        
        if saveExercises(workoutRoutine: workoutRoutine) {
            self.workoutRoutine = workoutRoutine
            self.tableView.reloadData()
        }
    }
    
    private func saveExercises(workoutRoutine: WorkoutRoutine)-> Bool {
        return DatabaseManager.sharedInstance.add(routine: workoutRoutine)
    }
    
}
