//
//  FirstViewController.swift
//  SSASideMenuExample
//
//  Created by Jose Luis Molina on 20/10/14.
//  Copyright (c) 2015 Jose Luis Molina. All rights reserved.
//

import UIKit

class MeViewController: CleverFitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalizedString.MeView.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showNavigationBar()
    }

}
