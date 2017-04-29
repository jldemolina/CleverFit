//
//  Strings.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 10/2/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    var isEmptyOrWhitespace: Bool {
        return isEmpty || trimmingCharacters(in: .whitespaces) == ""
    }

    var isNotEmptyOrWhitespace: Bool {
        return !isEmptyOrWhitespace
    }
}
