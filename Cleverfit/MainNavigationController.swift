//
//  MainNavigationController.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 16/2/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import Foundation
import UIKit

final class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }

    private func configureNavigationBar() {
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
    }

    private func pushCleverFitViewController(viewControllerToOpen: CleverFitParams.ViewController) {
        let storyboard = UIStoryboard(name: CleverFitParams.storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: viewControllerToOpen.rawValue)
        self.present(controller, animated: true)
    }

}
