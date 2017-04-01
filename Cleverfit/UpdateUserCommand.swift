//
//  UpdateUserCommand.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 1/4/17.
//  Copyright © 2017 SebastianAndersen. All rights reserved.
//

import Foundation
import UIKit

final class UpdateUserCommand: FeedbackCommand {
    
    let currentNavigationController: UINavigationController
    let user: User
    
    init(currentNavigationController: UINavigationController, user: User) {
        self.currentNavigationController = currentNavigationController
        self.user = user
    }
    
    func execute()-> Bool? {
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
