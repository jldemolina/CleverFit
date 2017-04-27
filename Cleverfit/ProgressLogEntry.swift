//
//  ProgressLogEntry.swift
//  Cleverfit
//
//  Created by Jose Luis Molina on 22/4/17.
//  Copyright © 2017 SebastianAndersen. All rights reserved.
//

import RealmSwift
import Foundation

class ProgressLogEntry: Object {
    dynamic var date = NSDate()
    dynamic var weight = 0.0
    dynamic var height = 0.0
    
}
