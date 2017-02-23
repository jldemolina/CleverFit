//
//  Command.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 18/2/17.
//  Copyright © 2017 SebastianAndersen. All rights reserved.
//

import Foundation

fileprivate protocol Command {
    func execute()-> Bool
}

final class RegisterUserCommand: Command {
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func execute()-> Bool {
        return DatabaseManager.sharedInstance.add(user: user)
    }
    
}
