//
//  RegisterCommand.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 1/4/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import Foundation
import UIKit

final class RegisterCommand: FeedbackCommand {
    
    let currentNavigationController: UINavigationController
    let user: User
    
    init(currentNavigationController: UINavigationController, user: User) {
        self.currentNavigationController = currentNavigationController
        self.user = user
    }
    
    func execute()-> Bool? {
        if (insertUserIntoDatabase()) {
            return openViewController()
        }
        return false
    }
    
    // TODO Fix units conversion
    private func insertUserIntoDatabase()-> Bool {
        if DatabaseManager.sharedInstance.add(user: user) {
            return DatabaseManager.sharedInstance.addProgressEntry(height: Double(user.height), weight: Double(user.weight))
        }
        return false;
    }
    
    private func openViewController()-> Bool {
        if let meViewController = currentNavigationController.storyboard?.instantiateViewController(withIdentifier: CleverFitParams.ViewController.meViewController.rawValue) as? MeViewController {
            currentNavigationController.pushViewController(meViewController, animated: true)
            currentNavigationController.navigationItem.hidesBackButton = true
            return true
        }
        return false
    }
}
