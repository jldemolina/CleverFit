//
//  Command.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 18/3/17.
//  Copyright © 2017 SebastianAndersen. All rights reserved.
//

import Foundation
import UIKit

fileprivate protocol Command {

    func execute()-> Bool
    
}


final class RegisterCommand: Command {
    
    let currentNavigationController: UINavigationController
    let user: User
    
    init(currentNavigationController: UINavigationController, user: User) {
        self.currentNavigationController = currentNavigationController
        self.user = user
    }
    
    func execute()-> Bool {
        if (insertUserIntoDatabase()) {
            return openViewController()
        }
        return false
    }
    
    private func insertUserIntoDatabase()-> Bool {
        return DatabaseManager.sharedInstance.add(user: user)
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

