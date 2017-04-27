//
//  UICircleImageView.swift
//  Cleverfit
//
//  Created by Jose Luis Molina on 23/4/17.
//  Copyright © 2017 SebastianAndersen. All rights reserved.
//

import UIKit

class UICircleImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.masksToBounds = true
        layer.cornerRadius = min(self.frame.width / 2, self.frame.height / 2)
        clipsToBounds = true
    }

}
