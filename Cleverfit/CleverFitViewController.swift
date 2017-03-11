//
//  BaseViewController.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 13/9/16.
//  Copyright © 2016 Jose Luis Molina. All rights reserved.
//

import UIKit

class CleverFitViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBarForRootView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configureNavigationBarForRootView() {
        navigationItem.setHidesBackButton(true, animated: false)
    }

}
