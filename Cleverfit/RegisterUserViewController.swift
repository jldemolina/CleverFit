//
//  RegisterViewController.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 11/2/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import UIKit
import XLForm

class RegisterViewController: CleverFitFormViewController {

    var userFromForm : User {
        get {
            let user = User()
            user.name = form.formRow(withTag: FormTag.name.rawValue)?.value as! String
            user.birthDate = form.formRow(withTag: FormTag.birthdate.rawValue)?.value as! NSDate
            user.height = form.formRow(withTag: FormTag.height.rawValue)?.value as! Int
            user.weight = form.formRow(withTag: FormTag.weight.rawValue)?.value as! Int
            user.objectiveFeedback = (form.formRow(withTag: FormTag.objective.rawValue)?.value as! XLFormOptionObject).formValue() as! UserObjective
            user.userGender = (form.formRow(withTag: FormTag.gender.rawValue)?.value as! XLFormOptionObject).formValue() as! UserGender
            user.userExperience = (form.formRow(withTag: FormTag.experience.rawValue)?.value as! XLFormOptionObject).formValue() as! UserExperience
            user.maxRoutineDurationInSeconds = (form.formRow(withTag: FormTag.maxDuration.rawValue)?.value as! XLFormOptionObject).formValue() as! Int * 60
            return user
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  LocalizedString.RegisterView.title

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
        let section = XLFormSectionDescriptor.formSection(withTitle: LocalizedString.FormView.basicInformationSectionTitle) as XLFormSectionDescriptor
        form.addFormSection(section)

        addDescriptor(to: section, with: FormTag.name, title: LocalizedString.FormView.nameDescriptorTitle, descriptorType: XLFormRowDescriptorTypeName, required: true)
        addDescriptor(to: section, with: FormTag.birthdate, title: LocalizedString.FormView.birthdateDescriptorTitle, descriptorType: XLFormRowDescriptorTypeDate, required: true)
        addDescriptor(to: section, with: FormTag.weight, title: LocalizedString.FormView.weightDescriptorTitle, descriptorType: XLFormRowDescriptorTypeInteger, required: true)
        addDescriptor(to: section, with: FormTag.height, title: LocalizedString.FormView.heightDescriptorTitle, descriptorType: XLFormRowDescriptorTypeInteger, required: true)
        self.addGenderDescriptor(to: section)
    }

    private func addTrainingConfigurationSection(to form: XLFormDescriptor) {
        let section = XLFormSectionDescriptor.formSection(withTitle: LocalizedString.FormView.workoutconfigurationSectionTitle) as XLFormSectionDescriptor
        form.addFormSection(section)

        self.addObjectiveDescriptor(to: section)
        self.addExperienceDescriptor(to: section)
        self.addWorkoutDurationDescriptor(to: section)
    }

    private func addExperienceDescriptor(to section: XLFormSectionDescriptor) {
        let options = [
            XLFormOptionsObject(value: UserExperience.low,
                                displayText: UserExperience.low.rawValue.localized), 
            XLFormOptionsObject(value: UserExperience.half,
                                displayText: UserExperience.half.rawValue.localized),
            XLFormOptionsObject(value: UserExperience.hard,
                                displayText: UserExperience.hard.rawValue.localized)]
        addDescriptor(to: section, with: FormTag.experience, title: LocalizedString.FormView.experienceDescriptorTitle, descriptorType: XLFormRowDescriptorTypeSelectorPickerView, options: options as! [XLFormOptionsObject], required: true)

    }
    
    private func addGenderDescriptor(to section: XLFormSectionDescriptor) {
        let options = [
            XLFormOptionsObject(value: UserGender.man,
                                displayText: UserGender.man.rawValue.localized),
            XLFormOptionsObject(value: UserGender.woman,
                                displayText: UserGender.woman.rawValue.localized)]
        addDescriptor(to: section, with: FormTag.gender, title: LocalizedString.FormView.genderDescriptorTitle, descriptorType: XLFormRowDescriptorTypeSelectorPickerView, options: options as! [XLFormOptionsObject], required: true)
        
    }

    private func addObjectiveDescriptor(to section: XLFormSectionDescriptor) {
        let options = [
            XLFormOptionsObject(value: UserObjective.loseWeight,
                                                   displayText: UserObjective.loseWeight.rawValue.localized)]
        addDescriptor(to: section, with: FormTag.objective, title: LocalizedString.FormView.objectiveDescriptorTitle, descriptorType: XLFormRowDescriptorTypeSelectorPickerView, options: options as! [XLFormOptionsObject], required: true)

    }

    private func addWorkoutDurationDescriptor(to section: XLFormSectionDescriptor) {
        let options = [
            XLFormOptionsObject(value: 7,
                                displayText: LocalizedString.FormView.seven_minutes_workout),
            XLFormOptionsObject(value: 10,
                                displayText: LocalizedString.FormView.ten_minutes_workout),
            XLFormOptionsObject(value: 15,
                                displayText: LocalizedString.FormView.fifteen_seven_minutes_workout),
            XLFormOptionsObject(value: 20,
                                 displayText: LocalizedString.FormView.thirsty_minutes_workout),
            XLFormOptionsObject(value: 30,
                                displayText: LocalizedString.FormView.maxDurationDescriptorTitle)]
        addDescriptor(to: section, with: FormTag.maxDuration, title: LocalizedString.FormView.maxDurationDescriptorTitle, descriptorType: XLFormRowDescriptorTypeSelectorPickerView, options: options as! [XLFormOptionsObject], required: true)
        
    }
    
    private func configureNextButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(RegisterViewController.validateForm(_:)))
        navigationItem.rightBarButtonItem?.title = LocalizedString.RegisterView.registerButtonTitle
    }

    func validateForm(_ buttonItem: UIBarButtonItem) {
        if (formValidationErrors().isEmpty) {
            RegisterCommand(currentNavigationController: navigationController!, user: userFromForm).execute() // TODO - FUNC RESULT
        } else {
            showFormErrors()
        }
    }


}
