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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SETTINGS_VIEW_TITLE".localized

        loadData()
    }

    func configureFormWithParams(name: String, weight: Float, height: Float, date: NSDate, objective: String, alerta: String) {
        let form = XLFormDescriptor(title: SettingsViewControllerConstants.settingsTag) as XLFormDescriptor

        addBasicInformationSection(to: form, with: name, weight: weight, height: height, date: date)
        addTrainingConfigurationSection(to: form)

        self.form = form
    }

    func addBasicInformationSection(to form: XLFormDescriptor, with name: String, weight: Float, height: Float, date: NSDate) {
        var section: XLFormSectionDescriptor

        section = XLFormSectionDescriptor.formSection(withTitle: "BASIC_INFORMATION_SECTION_TITLE".localized) as XLFormSectionDescriptor
        form.addFormSection(section)

        addDateDescriptor(to: section, with: date)
        addNameDescriptor(to: section, with: name)
        addWeightDescriptor(to: section, with: weight)
        addHeightDescriptor(to: section, with: height)

        section = XLFormSectionDescriptor.formSection()
        form.addFormSection(section)
    }

    func addTrainingConfigurationSection(to form: XLFormDescriptor) {
        var section: XLFormSectionDescriptor

        section = XLFormSectionDescriptor.formSection(withTitle: "WORKOUT_CONFIGURATION_SECTION_TITLE".localized) as XLFormSectionDescriptor
        form.addFormSection(section)

        self.addObjectiveDescriptor(to: section)
        self.addExperienceDescriptor(to: section)
        self.addAlertDescriptor(to: section)
    }

    // TODO VALUE
    func addAlertDescriptor(to section: XLFormSectionDescriptor) {
        var row: XLFormRowDescriptor

        row = XLFormRowDescriptor(tag: SettingsViewControllerConstants.alertTag, rowType:XLFormRowDescriptorTypeSelectorPush, title:"ALERT_DESCRIPTOR_TITLE".localized)
        // row.value = XLFormOptionsObject(value: UserAlertsPreference.doNotNotifyMe, displayText: "No me notifiques")
        row.selectorOptions = [
            XLFormOptionsObject(value: UserAlertsPreference.doNotNotifyMe,
                                displayText: UserAlertsPreference.doNotNotifyMe.rawValue.localized),
            XLFormOptionsObject(value: UserAlertsPreference.notifyMe,
                                displayText: UserAlertsPreference.notifyMe.rawValue.localized)]
        section.addFormRow(row)
    }

    func addExperienceDescriptor(to section: XLFormSectionDescriptor) {
        var row: XLFormRowDescriptor

        row = XLFormRowDescriptor(tag: SettingsViewControllerConstants.experienceTag, rowType:XLFormRowDescriptorTypeSelectorPush, title:"EXPERIENCE_DESCRIPTOR_TITLE".localized)
        // row.value = XLFormOptionsObject(value: UserExperience.low, displayText: "Nuevo")
        row.selectorOptions = [
            XLFormOptionsObject(value: UserExperience.low,
                                displayText: UserExperience.low.rawValue.localized),
            XLFormOptionsObject(value: UserExperience.half,
                                displayText: UserExperience.half.rawValue.localized),
            XLFormOptionsObject(value: UserExperience.hard,
                                displayText: UserExperience.hard.rawValue.localized)]
        section.addFormRow(row)
    }

    // TODO VALUE
    func addObjectiveDescriptor(to section: XLFormSectionDescriptor) {
        var row: XLFormRowDescriptor

        row = XLFormRowDescriptor(tag: SettingsViewControllerConstants.objectiveTag,
                                  rowType:XLFormRowDescriptorTypeSelectorPush,
                                  title:"OBJECTIVE_DESCRIPTOR_TITLE".localized)
        // row.value = XLFormOptionsObject(value: UserObjective.loseWeight, displayText: "Bajar de peso")
        row.selectorOptions = [XLFormOptionsObject(value: UserObjective.loseWeight,
                                                   displayText: UserObjective.loseWeight.rawValue.localized),
                               XLFormOptionsObject(value: UserObjective.maintenanceWeight,
                                                   displayText: UserObjective.maintenanceWeight.rawValue.localized)]
        section.addFormRow(row)
    }

    func addDateDescriptor(to section: XLFormSectionDescriptor, with value: NSDate) {
        var row: XLFormRowDescriptor

        row = XLFormRowDescriptor(tag: SettingsViewControllerConstants.birthdateTag, rowType: XLFormRowDescriptorTypeDateInline, title:"BIRTHDATE_DESCRIPTOR_TITLE".localized)
        row.value = value
        section.addFormRow(row)
    }

    func addNameDescriptor(to section: XLFormSectionDescriptor, with value: String) {
        var row: XLFormRowDescriptor

        row = XLFormRowDescriptor(tag: SettingsViewControllerConstants.nameTag, rowType: XLFormRowDescriptorTypeName, title: "NAME_DESCRIPTOR_TITLE".localized)
        row.value = value
        section.addFormRow(row)
    }

    func addWeightDescriptor(to section: XLFormSectionDescriptor, with value: Float) {
        var row: XLFormRowDescriptor

        row = XLFormRowDescriptor(tag: SettingsViewControllerConstants.weightTag, rowType: XLFormRowDescriptorTypeDecimal, title: "WEIGHT_DESCRIPTOR_TITLE".localized)
        row.value = value
        section.addFormRow(row)
    }

    func addHeightDescriptor(to section: XLFormSectionDescriptor, with value: Float) {
        var row: XLFormRowDescriptor

        row = XLFormRowDescriptor(tag: SettingsViewControllerConstants.heightTag, rowType: XLFormRowDescriptorTypeDecimal, title: "HEIGHT_DESCRIPTOR_TITLE".localized)
        row.value = value
        section.addFormRow(row)
    }

    func loadData() {
        let user: User? = DatabaseManager.sharedInstance.load()
        if user != nil {
            self.configureFormWithParams(name: user!.name, weight: Float(user!.weight), height: Float(user!.height), date: user!.birthDate, objective: user!.objectiveFeedback.rawValue, alerta: user!.userAlertsPreference.rawValue)
        } else {
            self.configureFormWithParams(name: "", weight: 65.0, height: 67.0, date: NSDate(), objective: "", alerta: "")
        }
    }

}

fileprivate struct SettingsViewControllerConstants {
    static let settingsTag = "settings"
    static let alertTag = "alert"
    static let experienceTag = "experience"
    static let objectiveTag = "objective"
    static let heightTag = "height"
    static let weightTag = "weight"
    static let nameTag = "name"
    static let birthdateTag = "birthdate"
}
