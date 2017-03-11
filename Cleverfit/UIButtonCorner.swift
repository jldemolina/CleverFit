//
//  UIButtonCorner.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 25/2/17.
//  Copyright © 2017 SebastianAndersen. All rights reserved.
//

import Foundation
import UIKit

class UIButtonCorner: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }

}
