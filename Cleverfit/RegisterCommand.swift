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
    
    private func insertUserIntoDatabase()-> Bool {
        if DatabaseManager.sharedInstance.add(user: user) {
            return DatabaseManager.sharedInstance.addProgressEntry(height: Double(user.height), weight: Double(user.weight))
        }
        return false;
    }
    
    private func openViewController()-> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let navigationController = UIStoryboard(name: CleverFitParams.storyboardName, bundle: nil).instantiateViewController(withIdentifier: CleverFitParams.ViewController.mainNavigationController.rawValue) as? MainNavigationController
        
        if let viewControllerToOpen = navigationController?.storyboard?.instantiateViewController(withIdentifier: CleverFitParams.ViewController.meViewController.rawValue) {
            navigationController?.pushViewController(viewControllerToOpen, animated: true)
            
            appDelegate.window?.rootViewController = navigationController
            return true

        }
        
        return false
    }
}
