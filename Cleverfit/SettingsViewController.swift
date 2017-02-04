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
        self.title = "Ajustes"
        
        self.configureFormWithParams(name: "Test", weight: 65.0, height: 67.0, date: NSDate(), objective: "", alerta: "")
    }
    
    func configureFormWithParams(name: String, weight: Float, height: Float, date: NSDate, objective: String, alerta: String) {
        let form = XLFormDescriptor(title: "Settings") as XLFormDescriptor
        
        addBasicInformationSection(to: form, with: name, weight: weight, height: height, date: date)
        addTrainingConfigurationSection(to: form)

        self.form = form;
    }
    
    func addBasicInformationSection(to form: XLFormDescriptor, with name: String, weight: Float, height: Float, date: NSDate) {
        var section : XLFormSectionDescriptor
        
        section = XLFormSectionDescriptor.formSection(withTitle: "INFORMACIÓN BÁSICA") as XLFormSectionDescriptor
        form.addFormSection(section)
        
        addDateDescriptor(to: section, with: date)
        addNameDescriptor(to: section, with: name)
        addWeightDescriptor(to: section, with: weight)
        addHeightDescriptor(to: section, with: height)
        
        section = XLFormSectionDescriptor.formSection()
        form.addFormSection(section)
    }
    
    func addTrainingConfigurationSection(to form: XLFormDescriptor) {
        var section : XLFormSectionDescriptor
        
        section = XLFormSectionDescriptor.formSection(withTitle: "Configuración de entrenamiento") as XLFormSectionDescriptor
        form.addFormSection(section)
        
        self.addObjectiveDescriptor(to: section)
        self.addExperienceDescriptor(to: section)
        self.addAlertDescriptor(to: section)
        
    }
    
    // TODO VALUE
    func addAlertDescriptor(to section: XLFormSectionDescriptor) {
        var row : XLFormRowDescriptor
        
        row = XLFormRowDescriptor(tag: "alert", rowType:XLFormRowDescriptorTypeSelectorPush, title:"Alerta")
        row.value = XLFormOptionsObject(value: 0, displayText: "No me notifiques")
        row.selectorOptions = [
            XLFormOptionsObject(value: 0, displayText: "No me notifiques"),
            XLFormOptionsObject(value: 1, displayText: "Justo en el momento"),
            XLFormOptionsObject(value: 2, displayText: "5 minutos antes"),
            XLFormOptionsObject(value: 3, displayText: "15 minutos antes"),
            XLFormOptionsObject(value: 4, displayText: "30 minutos antes"),
            XLFormOptionsObject(value: 5, displayText: "1 hora antes"),
            XLFormOptionsObject(value: 6, displayText: "2 horas antes"),
            XLFormOptionsObject(value: 7, displayText: "1 día antes"),
            XLFormOptionsObject(value: 8, displayText: "2 días antes")]
        section.addFormRow(row)
    }
    
    func addExperienceDescriptor(to section: XLFormSectionDescriptor) {
        var row : XLFormRowDescriptor
        
        row = XLFormRowDescriptor(tag: "experience", rowType:XLFormRowDescriptorTypeSelectorPush, title:"Experiencia")
        row.value = XLFormOptionsObject(value: 0, displayText: "Nuevo")
        row.selectorOptions = [
            XLFormOptionsObject(value: 0, displayText: "Intermedio"),
            XLFormOptionsObject(value: 1, displayText: "Avanzado")]
        section.addFormRow(row)
    }
    
    // TODO VALUE
    func addObjectiveDescriptor(to section: XLFormSectionDescriptor) {
        var row : XLFormRowDescriptor
        
        row = XLFormRowDescriptor(tag: "objective", rowType:XLFormRowDescriptorTypeSelectorPush, title:"Objetivo")
        row.value = XLFormOptionsObject(value: 0, displayText: "Bajar de peso")
        row.selectorOptions = [XLFormOptionsObject(value: 0, displayText: "Bajar de peso"),
                               XLFormOptionsObject(value: 1, displayText: "Mantener peso actual")]
        section.addFormRow(row)
    }
    
    func addDateDescriptor(to section: XLFormSectionDescriptor, with value: NSDate) {
        var row : XLFormRowDescriptor
        
        row = XLFormRowDescriptor(tag: "", rowType: XLFormRowDescriptorTypeDateInline, title:"Fecha de nacimiento")
        row.value = value
        section.addFormRow(row)
    }
    
    func addNameDescriptor(to section: XLFormSectionDescriptor, with value: String) {
        var row : XLFormRowDescriptor
        
        row = XLFormRowDescriptor(tag: "name", rowType: XLFormRowDescriptorTypeName, title: "Nombre")
        row.value = value
        section.addFormRow(row)
    }
    
    func addWeightDescriptor(to section: XLFormSectionDescriptor, with value: Float) {
        var row : XLFormRowDescriptor
        
        row = XLFormRowDescriptor(tag: "weight", rowType: XLFormRowDescriptorTypeDecimal, title: "Peso")
        row.value = value
        section.addFormRow(row)
    }
    
    func addHeightDescriptor(to section: XLFormSectionDescriptor, with value: Float) {
        var row : XLFormRowDescriptor
        
        row = XLFormRowDescriptor(tag: "height", rowType: XLFormRowDescriptorTypeDecimal, title: "Altura")
        row.value = value
        section.addFormRow(row)
    }
    
    
}
