//
//  Command.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 18/3/17.
//  Copyright © 2017 SebastianAndersen. All rights reserved.
//

import Foundation
import UIKit

protocol FeedbackCommand {

    func execute()-> Bool?
    
}

protocol NoFeedbackCommand {
    
    func execute()
    
}
