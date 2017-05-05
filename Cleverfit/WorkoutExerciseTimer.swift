//
//  WorkoutExerciseTimer.swift
//  Cleverfit
//
//  Created by Jose Luis Molina on 27/4/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import Foundation
import SwiftyTimer

class WorkoutExerciseTimer {
    
    private var currentTimeValue = 0
    private var currentExerciseIndex = 0

    private let workoutRoutine: WorkoutRoutine
    private let delegate: WorkoutExerciseTimerDelegate
    private var timer: Timer?
    private var paused: Bool
    
    private var currentExercise: WorkoutExercise? {
        didSet(newExercixe) {
            if newExercixe != nil {
                currentTimeValue = currentExercise!.durationInSeconds + currentExercise!.restInSeconds
                delegate.exerciseChanged(workoutExercise: currentExercise!)
            }
        }
    }
    
    init(delegate: WorkoutExerciseTimerDelegate, workoutRoutine: WorkoutRoutine) {
        self.delegate = delegate
        self.workoutRoutine = workoutRoutine
        self.paused = true
        prepareInitialExercise()
    }
    
    public func play() {
        if (currentExerciseIndex == 0) {
            delegate.workoutStarted()
        }
        
        timer = Timer.new(every: 1.second) {
            self.updateTime()
        }
        
        timer?.start()
        paused = false
    }
    
    public func pause() {
        timer?.invalidate()
        paused = true
    }
    
    public func toggleStatus() {
        paused ? play() : pause()
    }
    
    public func stop() {
        timer?.invalidate()
        prepareInitialExercise()
        paused = true
    }
    
    private func updateTime() {
        if timeHasFinished() {
            updateTimerWhenExerciseFinished()
        } else if isRestTime() {
            updateRestTime()
        } else {
            if currentExercise != nil {
                delegate.timeUpdated(currentTimeValue: currentTimeValue - currentExercise!.restInSeconds)
            }
        }
        
        currentTimeValue -= 1
    }
    
    private func updateRestTime() {
        if currentExercise != nil {
            if restTimeHasJustStarted() {
                delegate.restTimeStarted(workoutExercise: currentExercise!)
            } else {
                delegate.restTimeUpdated(currentTimeValue: currentTimeValue - currentExercise!.durationInSeconds + 1)
            }
        }
    }
    
    private func updateTimerWhenExerciseFinished() {
        timer?.invalidate()
        if changeExerciseIfPossible() {
            play()
        } else {
            delegate.workoutFinished()
            paused = true
        }
    }
    
    public func changeExerciseIfPossible()-> Bool {
        guard currentExerciseIndex + 1 < workoutRoutine.workoutExercises.count else { return false }
        
        currentExerciseIndex += 1
        currentExercise = workoutRoutine.workoutExercises[currentExerciseIndex]
        
        return true
    }

    private func prepareInitialExercise() {
        if !workoutRoutine.workoutExercises.isEmpty {
            self.currentExercise = workoutRoutine.workoutExercises.first
        }
    }
    
    private func isRestTime()-> Bool {
        if currentExercise != nil {
            if currentExercise!.restInSeconds != 0 {
                return currentTimeValue < currentExercise!.restInSeconds
            }
        }
        
        return false
    }
    
    private func restTimeHasJustStarted()-> Bool {
        if currentExercise != nil {
            return currentTimeValue == currentExercise!.restInSeconds - 1
        }
        
        return false
    }
    
    private func timeHasFinished()-> Bool {
        return currentTimeValue == 0
    }
}

protocol WorkoutExerciseTimerDelegate {
    func workoutStarted()
    func workoutFinished()
    func timeUpdated(currentTimeValue: Int)
    func restTimeUpdated(currentTimeValue: Int)
    func exerciseChanged(workoutExercise: WorkoutExercise)
    func restTimeStarted(workoutExercise: WorkoutExercise)
}
