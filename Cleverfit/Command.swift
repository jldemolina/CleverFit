//
//  Command.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 18/3/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import Foundation
import UIKit

protocol FeedbackCommand {

    func execute()-> Bool?
    
}

protocol NoFeedbackCommand {
    
    func execute()
    
}
