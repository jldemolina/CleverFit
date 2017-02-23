//
//  MainNavigationController.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 16/2/17.
//  Copyright © 2017 SebastianAndersen. All rights reserved.
//

import Foundation
import UIKit

final class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ : User = DatabaseManager.sharedInstance.load() {
            pushMeViewController()
        } else {
            pushRegisterViewController()
        }
    }
    
    func pushMeViewController() {
        pushCleverFitViewController(viewControllerToOpen: CleverFitParams.ViewController.meViewController)
    }
    
    func pushRegisterViewController() {
        pushCleverFitViewController(viewControllerToOpen: CleverFitParams.ViewController.registerUserViewController)
    }
}

extension MainNavigationController {
    func pushCleverFitViewController(viewControllerToOpen: CleverFitParams.ViewController) {
        let storyboard = UIStoryboard(name: CleverFitParams.storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: viewControllerToOpen.rawValue)
        self.pushViewController(controller, animated: true)
    }
}
