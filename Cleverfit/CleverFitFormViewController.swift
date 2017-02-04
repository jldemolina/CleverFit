//
//  BaseViewController.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 13/9/16.
//  Copyright © 2016 Jose Luis Molina. All rights reserved.
//

import UIKit
import XLForm

class CleverFitFormViewController: XLFormViewController {
    
    override open func viewDidLoad() {
        super.viewDidLoad();
        
        self.configureNavigationBar()
    }
    
    func configureNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menú", style: .plain, target: self, action: #selector(SSASideMenu.presentLeftMenuViewController))
    }
    
}
