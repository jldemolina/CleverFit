//
//  Date.swift
//  Cleverfit
//
//  Created by Jose Luis Molina on 22/4/17.
//  Copyright © 2017 SebastianAndersen. All rights reserved.
//

import UIKit

extension NSDate {
    
    func add(minutes: Int) -> NSDate {
        return Calendar(identifier: .gregorian).date(byAdding: .minute, value: minutes, to: self as Date)! as NSDate
    }
    
    func add(seconds: Int) -> NSDate {
        return Calendar(identifier: .gregorian).date(byAdding: .second, value: seconds, to: self as Date)! as NSDate
    }
    
    func add(hours: Int) -> NSDate {
        return Calendar(identifier: .gregorian).date(byAdding: .hour, value: hours, to: self as Date)! as NSDate
    }
    
    func add(days: Int) -> NSDate {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self as Date)! as NSDate
    }
}
