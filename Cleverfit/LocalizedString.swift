//
//  LocalizedString.swift
//  Cleverfit
//
//  Created by Jose Luis Molina on 30/4/17.
//  Copyright © 2017 SebastianAndersen. All rights reserved.
//

import Foundation

final class LocalizedString {
    
    class ProgressView {
        static var title: String {
            get {
                return "PROGRESS_VIEW_TITLE".localized
            }
        }
        static var weightEvolution: String {
            get {
                return "WEIGHT_EVOLUTION".localized
            }
        }
        static var month: String {
            get {
                return "MONTH".localized
            }
        }
    }
    
    class HistoryView {
        static var title: String {
            get {
                return "HISTORY_VIEW_TITLE".localized
            }
        }
        static var generationStarted: String {
            get {
                return "GENERATION_STARTED".localized
            }
        }
        static var generationFinished: String {
            get {
                return "GENERATION_FINISHED".localized
            }
        }
    }
    
    class MeView {
        static var title: String {
            get {
                return "ME_VIEW_TITLE".localized
            }
        }
    }
    
    class CurrentPlanView {
        static var title: String {
            get {
                return "CURRENT_PLAN_VIEW_TITLE".localized
            }
        }
        static var generateRoutineDialogButton: String {
            get {
                return "GENERATE_ROUTINE_DIALOG_BUTTON".localized
            }
        }
        static var updateDataDialogButton: String {
            get {
                return "UPDATE_DATA_DIALOG_BUTTON".localized
            }
        }
        static var CloseDialogButton: String {
            get {
                return "CLOSE_DIALOG_BUTTON".localized
            }
        }
        static var generateRoutineDialogtitle: String {
            get {
                return "GENERATE_ROUTINE_DIALOG_TITLE".localized
            }
        }
        static var generateRoutineDialogBody: String {
            get {
                return "GENERATE_ROUTINE_DIALOG_BODY".localized
            }
        }
        static var generationStarted: String {
            get {
                return "GENERATION_STARTED".localized
            }
        }
        static var generationFinished: String {
            get {
                return "GENERATION_FINISHED".localized
            }
        }
        static var seconds: String {
            get {
                return "SECONDS".localized
            }
        }
    }
    
    class RegisterView {
        static var title: String {
            get {
                return "REGISTER_VIEW_TITLE".localized
            }
        }
        static var registerButtonTitle: String {
            get {
                return "REGISTER_BUTTON_TITLE".localized
            }
        }
    }
    
    class SettingsView {
        static var title: String {
            get {
                return "SETTINGS_VIEW_TITLE".localized
            }
        }
        static var registerButtonTitle: String {
            get {
                return "REGISTER_BUTTON_TITLE".localized
            }
        }
    }
    
    class FormView {
        static var basicInformationSectionTitle: String {
            get {
                return "BASIC_INFORMATION_SECTION_TITLE".localized
            }
        }
        static var nameDescriptorTitle: String {
            get {
                return "NAME_DESCRIPTOR_TITLE".localized
            }
        }
        static var birthdateDescriptorTitle: String {
            get {
                return "BIRTHDATE_DESCRIPTOR_TITLE".localized
            }
        }
        static var weightDescriptorTitle: String {
            get {
                return "WEIGHT_DESCRIPTOR_TITLE".localized
            }
        }
        static var heightDescriptorTitle: String {
            get {
                return "HEIGHT_DESCRIPTOR_TITLE".localized
            }
        }
        static var experienceDescriptorTitle: String {
            get {
                return "EXPERIENCE_DESCRIPTOR_TITLE".localized
            }
        }
        static var objectiveDescriptorTitle: String {
            get {
                return "OBJECTIVE_DESCRIPTOR_TITLE".localized
            }
        }
        static var workoutconfigurationSectionTitle: String {
            get {
                return "WORKOUT_CONFIGURATION_SECTION_TITLE".localized
            }
        }
        static var maxDurationDescriptorTitle: String {
            get {
                return "MAX_DURATION_DESCRIPTOR_TITLE".localized
            }
        }
    }
    
    
}
