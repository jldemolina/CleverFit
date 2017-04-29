//
//  CleverFitPreferences.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 5/3/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import Foundation

class CleverFitPreferences {
    private let databaseManager: DatabaseManager
    var userLoginIn: Bool {
        get {
            let user: User? = databaseManager.load()
            return user != nil
        }

    }

    init() {
        self.databaseManager = DatabaseManager.sharedInstance
    }

}
