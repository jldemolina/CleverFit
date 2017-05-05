//
//  SettingsViewController.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 13/9/16.
//  Copyright © 2016 Jose Luis Molina. All rights reserved.
//

import UIKit
import XLForm

class SettingsViewController: CleverFitFormViewController {
    
    var userFromForm: User {
        get {
            let user = User()
            user.name = form.formRow(withTag: FormTag.name.rawValue)?.value as! String
            user.birthDate = form.formRow(withTag: FormTag.birthdate.rawValue)?.value as! NSDate
            user.height = form.formRow(withTag: FormTag.height.rawValue)?.value as! Int
            user.weight = form.formRow(withTag: FormTag.weight.rawValue)?.value as! Int
            if let selectedObjective = form.formRow(withTag: FormTag.objective.rawValue)?.value as? UserObjective {
                user.objectiveFeedback = selectedObjective
            }
            if let selectedExperience = form.formRow(withTag: FormTag.experience.rawValue)?.value as? UserExperience {
                user.userExperience = selectedExperience
            }
            user.maxRoutineDurationInSeconds = (form.formRow(withTag: FormTag.maxDuration.rawValue)?.value as! XLFormOptionObject).formValue() as! Int * 60
            
            return user
        }
    }
    var userFromDatabase: User? {
        get {
            return DatabaseManager.sharedInstance.load()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalizedString.SettingsView.title
        
        configureForm()
        configureNextButton()
        
        loadInitialValues()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showNavigationBar()
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
    
    private func addObjectiveDescriptor(to section: XLFormSectionDescriptor) {
        let options = [
            XLFormOptionsObject(value: UserObjective.loseWeight,
                                displayText: UserObjective.loseWeight.rawValue.localized),
            XLFormOptionsObject(value: UserObjective.maintenanceWeight,
                                displayText: UserObjective.maintenanceWeight.rawValue.localized)]
        addDescriptor(to: section, with: FormTag.objective, title: LocalizedString.FormView.objectiveDescriptorTitle, descriptorType: XLFormRowDescriptorTypeSelectorPickerView, options: options as! [XLFormOptionsObject], required: true)
        
    }
    
    private func addWorkoutDurationDescriptor(to section: XLFormSectionDescriptor) {
        let options = [
            XLFormOptionsObject(value: 7,
                                displayText: "7 minutos"),
            XLFormOptionsObject(value: 10,
                                displayText: "10 minutos"),
            XLFormOptionsObject(value: 15,
                                displayText: "15 minutos"),
            XLFormOptionsObject(value: 20,
                                displayText: "20 minutos"),
            XLFormOptionsObject(value: 30,
                                displayText: "30 minutos")]
        addDescriptor(to: section, with: FormTag.maxDuration, title: LocalizedString.FormView.maxDurationDescriptorTitle, descriptorType: XLFormRowDescriptorTypeSelectorPickerView, options: options as! [XLFormOptionsObject], required: true)
        
    }
    
    private func configureNextButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(RegisterViewController.validateForm(_:)))
        navigationItem.rightBarButtonItem?.title = LocalizedString.SettingsView.registerButtonTitle
    }
    
    private func loadInitialValues() {
        if let loadedUser = userFromDatabase {
            form.formRow(withTag: FormTag.name.rawValue)?.value = loadedUser.name
            form.formRow(withTag: FormTag.birthdate.rawValue)?.value = loadedUser.birthDate
            form.formRow(withTag: FormTag.height.rawValue)?.value = loadedUser.height
            form.formRow(withTag: FormTag.weight.rawValue)?.value = loadedUser.weight
            form.formRow(withTag: FormTag.experience.rawValue)?.value = loadedUser.userExperience.rawValue.localized
            form.formRow(withTag: FormTag.objective.rawValue)?.value = loadedUser.objectiveFeedback.rawValue.localized
            form.formRow(withTag: FormTag.maxDuration.rawValue)?.value = Int(loadedUser.maxRoutineDurationInSeconds / 60)
        }
    }
    
    func validateForm(_ buttonItem: UIBarButtonItem) {
        if (formValidationErrors().isEmpty) {
            UpdateUserCommand(currentNavigationController: navigationController!, user: userFromForm).execute() // TODO - FUNC RESULT
        } else {
            showFormErrors()
        }
    }
}

