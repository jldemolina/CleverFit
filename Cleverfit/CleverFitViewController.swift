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
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func hideBackButton(animated: Bool) {
        navigationItem.setHidesBackButton(false, animated: animated)
    }

    func showBackButton(animated: Bool) {
        navigationItem.setHidesBackButton(true, animated: animated)
    }
    
}
