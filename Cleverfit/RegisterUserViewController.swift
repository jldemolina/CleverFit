//
//  RegisterViewController.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 11/2/17.
//  Copyright © 2017 SebastianAndersen. All rights reserved.
//

import UIKit
import XLForm

class RegisterViewController: CleverFitFormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "REGISTER_VIEW_TITLE".localized

        configureForm()
        configureNextButton()
    }

    private func configureForm() {
        let form = XLFormDescriptor(title: FormTag.settings.rawValue) as XLFormDescriptor

        addBasicInformationSection(to: form)
        addTrainingConfigurationSection(to: form)

        self.form = form
    }

    private func addBasicInformationSection(to form: XLFormDescriptor) {
        let section = XLFormSectionDescriptor.formSection(withTitle: "BASIC_INFORMATION_SECTION_TITLE".localized) as XLFormSectionDescriptor
        form.addFormSection(section)

        addDescriptor(to: section, with: FormTag.name, title: "NAME_DESCRIPTOR_TITLE".localized, descriptorType: XLFormRowDescriptorTypeName, required: true)
        addDescriptor(to: section, with: FormTag.birthdate, title: "BIRTHDATE_DESCRIPTOR_TITLE".localized, descriptorType: XLFormRowDescriptorTypeDate, required: true)
        addDescriptor(to: section, with: FormTag.weight, title: "WEIGHT_DESCRIPTOR_TITLE".localized, descriptorType: XLFormRowDescriptorTypeInteger, required: true)
        addDescriptor(to: section, with: FormTag.height, title: "HEIGHT_DESCRIPTOR_TITLE".localized, descriptorType: XLFormRowDescriptorTypeInteger, required: true)
    }

    private func addTrainingConfigurationSection(to form: XLFormDescriptor) {
        let section = XLFormSectionDescriptor.formSection(withTitle: "WORKOUT_CONFIGURATION_SECTION_TITLE".localized) as XLFormSectionDescriptor
        form.addFormSection(section)

        self.addObjectiveDescriptor(to: section)
        self.addExperienceDescriptor(to: section)
    }

    private func addExperienceDescriptor(to section: XLFormSectionDescriptor) {
        let options = [
            XLFormOptionsObject(value: UserExperience.low,
                                displayText: UserExperience.low.rawValue.localized),
            XLFormOptionsObject(value: UserExperience.half,
                                displayText: UserExperience.half.rawValue.localized),
            XLFormOptionsObject(value: UserExperience.hard,
                                displayText: UserExperience.hard.rawValue.localized)]
        addDescriptor(to: section, with: FormTag.experience, title: "EXPERIENCE_DESCRIPTOR_TITLE".localized, descriptorType: XLFormRowDescriptorTypeSelectorPickerView, options: options as! [XLFormOptionsObject], required: true)

    }

    private func addObjectiveDescriptor(to section: XLFormSectionDescriptor) {
        let options = [
            XLFormOptionsObject(value: UserObjective.loseWeight,
                                                   displayText: UserObjective.loseWeight.rawValue.localized),
            XLFormOptionsObject(value: UserObjective.maintenanceWeight,
                                                   displayText: UserObjective.maintenanceWeight.rawValue.localized)]
        addDescriptor(to: section, with: FormTag.objective, title: "OBJECTIVE_DESCRIPTOR_TITLE".localized, descriptorType: XLFormRowDescriptorTypeSelectorPickerView, options: options as! [XLFormOptionsObject], required: true)

    }

    private func configureNextButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(RegisterViewController.validateForm(_:)))
        navigationItem.rightBarButtonItem?.title = "REGISTER_BUTTON_TITLE".localized
    }

    func validateForm(_ buttonItem: UIBarButtonItem) {
        if (formValidationErrors().isEmpty) {
            if (addUser()) {
                present(MainNavigationController(), animated: true, completion: nil)
            }
        } else {
            showFormErrors()
        }
    }

    private func addUser() -> Bool {
        let user = User()
        user.name = form.formRow(withTag: FormTag.name.rawValue)?.value as! String
        user.birthDate = form.formRow(withTag: FormTag.birthdate.rawValue)?.value as! NSDate
        user.height = form.formRow(withTag: FormTag.height.rawValue)?.value as! Int
        user.weight = form.formRow(withTag: FormTag.weight.rawValue)?.value as! Int
        user.objectiveFeedback = (form.formRow(withTag: FormTag.objective.rawValue)?.value as! XLFormOptionObject).formValue() as! UserObjective
        user.userExperience = (form.formRow(withTag: FormTag.experience.rawValue)?.value as! XLFormOptionObject).formValue() as! UserExperience

        return DatabaseManager.sharedInstance.add(user: user)
    }

}
