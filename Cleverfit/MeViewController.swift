//
//  FirstViewController.swift
//  SSASideMenuExample
//
//  Created by Jose Luis Molina on 20/10/14.
//  Copyright (c) 2015 Jose Luis Molina. All rights reserved.
//

import UIKit

class MeViewController: CleverFitViewController {
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightProgressView: KDCircularProgress!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var minutesProgressView: KDCircularProgress!
    @IBOutlet weak var muscularMassLabel: UILabel!
    @IBOutlet weak var muscularMassProgressView: KDCircularProgress!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Yo"
    }
    
}

