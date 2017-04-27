//
//  OpenViewCommand.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 1/4/17.
//  Copyright © 2017 SebastianAndersen. All rights reserved.
//

import Foundation
import UIKit

class OpenViewCommand: FeedbackCommand {
    
    private let currentNavigationController: UINavigationController
    private let viewControllerToOpen: UIViewController
    
    func execute()-> Bool? {
        return openViewController()
    }
    
    init(currentNavigationController: UINavigationController, viewControllerToOpen: UIViewController) {
        self.currentNavigationController = currentNavigationController
        self.viewControllerToOpen = viewControllerToOpen
    }
    
    private func openViewController()-> Bool {
        currentNavigationController.pushViewController(viewControllerToOpen, animated: true)
        return true
    }
}

final class OpenPlanViewCommand: OpenViewCommand {
    
    required init(currentNavigationController: UINavigationController, workoutToOpen: WorkoutRoutine) {
        let viewControllerToOpen : CurrentPlanViewController = UIStoryboard(name: CleverFitParams.storyboardName, bundle: nil).instantiateViewController(withIdentifier: CleverFitParams.ViewController.currentPlanViewController.rawValue) as! CurrentPlanViewController
        viewControllerToOpen.workoutRoutine = workoutToOpen
        
        super.init(currentNavigationController: currentNavigationController, viewControllerToOpen: viewControllerToOpen)
    }
    
}

final class OpenSettingsViewCommand: OpenViewCommand {
    
    required init(currentNavigationController: UINavigationController) {
        let viewControllerToOpen = UIStoryboard(name: CleverFitParams.storyboardName, bundle: nil).instantiateViewController(withIdentifier: CleverFitParams.ViewController.settingsViewController.rawValue)
        
        super.init(currentNavigationController: currentNavigationController, viewControllerToOpen: viewControllerToOpen)
    }
    
}

final class OpenExerciseViewCommand: OpenViewCommand {
    
    required init(currentNavigationController: UINavigationController, exerciseToOpen: WorkoutExercise) {
        let viewControllerToOpen : ExerciseViewController = UIStoryboard(name: CleverFitParams.storyboardName, bundle: nil).instantiateViewController(withIdentifier: CleverFitParams.ViewController.exerciseViewController.rawValue) as! ExerciseViewController
        viewControllerToOpen.workoutExercise = exerciseToOpen
        
        super.init(currentNavigationController: currentNavigationController, viewControllerToOpen: viewControllerToOpen)
    }
    
}

