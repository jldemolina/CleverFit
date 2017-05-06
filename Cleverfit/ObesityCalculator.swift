//
//  ObesityCalculator.swift
//  Cleverfit
//
//  Created by Jose Luis Molina on 6/5/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import Foundation

public class ObesityCalculator {
    
    class func calculateBodyMassIndex(height : Double, weight  : Double)-> Double {
        return weight / (height * height)
    }
    
    class func calculateBasalMetabolism(height : Int, weight : Double, age: Int, gender : UserGender)-> Double {
        if (gender == UserGender.man) {
            return (66.4730 + ((13.751 * weight) + (5.0033 * Double(height)) - ((6.715 * (Double(age))))))
        }
        return (665 + (9.56 * weight) + (1.85 * Double(height)) - (6.78 * Double(age)))
    }
    
}
