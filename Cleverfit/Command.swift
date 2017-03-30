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

final class UpdateUserCommand: Command {
    
    let currentNavigationController: UINavigationController
    let user: User
    
    init(currentNavigationController: UINavigationController, user: User) {
        self.currentNavigationController = currentNavigationController
        self.user = user
    }
    
    func execute()-> Bool {
        if (updateUserInDatabase()) {
            return openViewController()
        }
        return false
    }
    
    private func updateUserInDatabase()-> Bool {
        return DatabaseManager.sharedInstance.update(user: user)
    }
    
    private func openViewController()-> Bool {
        currentNavigationController.popViewController(animated: true)
        return true

    }
}

class OpenViewCommand: Command {
    
    private let currentNavigationController: UINavigationController
    private let currentViewControllerTopOpen: CleverFitParams.ViewController
    
    func execute()-> Bool {
        return openViewController()
    }
    
    init(currentNavigationController: UINavigationController, currentViewControllerTopOpen: CleverFitParams.ViewController) {
        self.currentNavigationController = currentNavigationController
        self.currentViewControllerTopOpen = currentViewControllerTopOpen
    }
    
    private func openViewController()-> Bool {
        if let viewController = currentNavigationController.storyboard?.instantiateViewController(withIdentifier: currentViewControllerTopOpen.rawValue) {
            currentNavigationController.pushViewController(viewController, animated: true)
            return true
        }
        return false
    }
}
