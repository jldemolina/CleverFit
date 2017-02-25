//
//  BaseViewController.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 13/9/16.
//  Copyright © 2016 Jose Luis Molina. All rights reserved.
//

import UIKit
import XLForm

class CleverFitFormViewController: XLFormViewController {
    
    override open func viewDidLoad() {
        super.viewDidLoad();
    }
    
    func addDescriptor(to section: XLFormSectionDescriptor,
                       with tag: FormTag,
                       title: String,
                       descriptorType: String,
                       required: Bool) {
        addDescriptor(to: section, with: tag, title: title, descriptorType: descriptorType, options: [XLFormOptionObject]() as! [XLFormOptionsObject], required: required)
    }
    
    func addDescriptor(to section: XLFormSectionDescriptor,
                       with tag: FormTag,
                       title: String,
                       descriptorType: String,
                       options: [XLFormOptionsObject],
                       required: Bool) {
        var row : XLFormRowDescriptor
        row = XLFormRowDescriptor(tag: tag.rawValue, rowType: descriptorType, title: title)
        row.isRequired = required
        if (!options.isEmpty){
            row.selectorOptions = options
            row.value = options[0]
        }
        section.addFormRow(row)
    }
    
    func showFormErrors() {
        let array = formValidationErrors()
        for errorItem in array! {
            let error = errorItem as! NSError
            let validationStatus : XLFormValidationStatus = error.userInfo[XLValidationStatusErrorKey] as! XLFormValidationStatus
            if let rowDescriptor = validationStatus.rowDescriptor, let indexPath = form.indexPath(ofFormRow: rowDescriptor), let cell = tableView.cellForRow(at: indexPath) {
                cell.backgroundColor = .orange
                UIView.animate(withDuration: 0.2, animations: { () -> Void in
                    cell.backgroundColor = .white
                })
            }
        }
    }
    
}

enum FormTag: String {
    case settings
    case alert
    case experience
    case objective
    case height
    case weight
    case name
    case birthdate
}
