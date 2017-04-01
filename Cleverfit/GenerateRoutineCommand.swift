//
//  GenerateRoutineCommand.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 1/4/17.
//  Copyright © 2017 SebastianAndersen. All rights reserved.
//

import Foundation

final class GenerateRoutineCommand: NoFeedbackCommand {
    var delegates: [GenerateRoutineCommandDelegate];
    
    required init(with delegates: [GenerateRoutineCommandDelegate]) {
        self.delegates = delegates
    }
    
    convenience init(with delegate: GenerateRoutineCommandDelegate) {
        var delegates = [GenerateRoutineCommandDelegate]()
        delegates.append(delegate)
        self.init(with: delegates)
    }
    
    func execute() {
        let user: User? = DatabaseManager.sharedInstance.load()
        let exercises: [Exercise] = DatabaseManager.sharedInstance.load()
        notifyGenerationStarted()
        if (user != nil && !exercises.isEmpty) {
            let workoutGenerator = WorkoutGenerator(forUser: user!, andExercises: exercises)
            let workoutRoutine = workoutGenerator.generateRoutine()
            notifyGenerationFinished(workoutRoutine: workoutRoutine)
        }
    }
    
    private func notifyGenerationStarted() {
        for delegate in delegates {
            delegate.generationStarted()
        }
    }
    
    private func notifyGenerationFinished(workoutRoutine: WorkoutRoutine) {
        for delegate in delegates {
            delegate.generationFinished(workoutRoutine: workoutRoutine)
        }
    }
    
}

protocol GenerateRoutineCommandDelegate {
    func generationStarted();
    func generationFinished(workoutRoutine: WorkoutRoutine);
}
