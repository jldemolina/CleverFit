//
//  CloseViewCommand.swift
//  Cleverfit
//
//  Created by Jose Luis Molina on 29/4/17.
//  Copyright © 2017 SebastianAndersen. All rights reserved.
//

import UIKit

class CloseViewCommand: NoFeedbackCommand {
    
    private let currentNavigationController: UINavigationController
    
    func execute() {
        currentNavigationController.popToRootViewController(animated: true)
    }
    
    init(currentNavigationController: UINavigationController) {
        self.currentNavigationController = currentNavigationController
    }
    
}

class CloseFullViewCommand: NoFeedbackCommand {
    
    private let currentNavigationController: UINavigationController
    
    func execute() {
        currentNavigationController.popViewController(animated: true)
    }
    
    init(currentNavigationController: UINavigationController) {
        self.currentNavigationController = currentNavigationController
    }
    
}
