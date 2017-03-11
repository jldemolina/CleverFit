//
//  WorkoutGenerator.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 4/2/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import Foundation
import RealmSwift

class WorkoutGenerator {
    private let user: User
    private let exercises: [Exercise]

    init(forUser: User, andExercises: [Exercise]) {
        user = forUser
        exercises = andExercises
    }

    // TODO CALCULATE EXERCISE INTENSITY
    func generateRoutine() -> WorkoutRoutine {
        let workoutRoutine = WorkoutRoutine()
        workoutRoutine.startDate = NSDate()
        
        let exerciseTree = ExererciseTree(exercises: exercises, for: user)
        exerciseTree.generateTree()
        if let generatedExercises = exerciseTree.branchWithHigherHeuristicValue {
            for generatedExercise in generatedExercises {
                let workoutExercise = WorkoutExercise()
                workoutExercise.durationInSeconds = 30
                workoutExercise.exercise = generatedExercise
                workoutRoutine.workoutExercises.append(workoutExercise)
            }
        }

        return workoutRoutine
    }


    private func totalNumberOfExercises() -> Int {
        return (user.objectiveFeedback == UserObjective.loseWeight) ? 20 : 20
    }

}

class ExererciseTree {
    private var treeRoot: [ExerciseTreeNode]
    private let exercises: [Exercise]
    private let user: User
    
    var branchWithHigherHeuristicValue: [Exercise]? {
        get {
            var exercises = [Exercise]()
            if var currentNode = getRootNodeWithHighestHeuristic() {
                while (!currentNode.children.isEmpty) {
                    exercises.append(currentNode.value)
                    if currentNode.childWithHighestHeuristic != nil {
                        currentNode = currentNode.childWithHighestHeuristic!
                    } else {
                        break
                    }
                }
            }
            return exercises
        }
    }
    
    init(exercises: [Exercise], for user: User) {
        self.exercises = exercises
        self.user = user
        self.treeRoot = [ExerciseTreeNode]()
    }
    
    
    public func generateTree() {
        let permutations = Permutator.combinationsWithoutRepetitionFrom(elements: exercises, taking: exercises.count)
        
        initRoot(with: permutations)
        generateChildren(for: treeRoot, with: 0, permutations: permutations)

    }
    
    private func generateChildren(for nodes: [ExerciseTreeNode], with level: Int, permutations: [[Exercise]]) {
        for node in nodes {
            for currentColumn in 0...permutations.count {
                var currentExerciseList = [Exercise]()
                currentExerciseList.append(permutations[currentColumn][level])
                if current(node: node, have:currentExerciseList) {
                    add(exercise: permutations[currentColumn][level], to: node)
                }
            }
            if !node.children.isEmpty {
                generateChildren(for: node.children, with: level + 1, permutations: permutations)
            }
        }

    }
    
    private func current(node: ExerciseTreeNode, have parentExercises: [Exercise])-> Bool {
        if (node.parentsExercises.reversed() == parentExercises) {
            return true
        }
        return false
    }
    
    private func initRoot(with permutations: [[Exercise]]) {
        for currentColumn in 0...permutations.count {
            for depthLevel in 0...permutations[currentColumn].count {
                if (depthLevel == 0) {
                    addToRootIfNotExist(exercise: permutations[currentColumn][depthLevel])
                }
            }
        }
    }
    
    private func add(exercise: Exercise, to node: ExerciseTreeNode) {
        node.add(child: ExerciseTreeNode(value: exercise, for: user, with: node))
    }
 
    private func addToRootIfNotExist(exercise: Exercise) {
        for node in treeRoot {
            if node.value.name == exercise.name {
                return
            }
        }
        treeRoot.append(ExerciseTreeNode(value: exercise, for: user, with: nil))
    }
    
    private func getRootNodeWithHighestHeuristic()-> ExerciseTreeNode? {
        if treeRoot.isEmpty {
            return nil
        }
        
        var highestChildren = treeRoot[0]
        for child in treeRoot {
            if child.heuristicValue > highestChildren.heuristicValue {
                highestChildren = child
            }
        }
        return highestChildren
    }
}

class ExerciseTreeNode {
    var value: Exercise
    var user: User
    var children: [ExerciseTreeNode] = []
    var parent: ExerciseTreeNode?
    var heuristicValue: Int {
        get {
            return calculateHeuristicValueForNode()
        }
    }
    var parentsExercises: [Exercise] {
        get {
            var parentExercises = [Exercise]()
            if parent == nil {
                return parentExercises
            }
            
            var parentToCheck : ExerciseTreeNode? = parent
            while (parentToCheck != nil) {
                parentExercises.append(parentToCheck!.value)
                parentToCheck = parentToCheck!.parent
            }
            
            return parentExercises
        }
    }
    var childWithHighestHeuristic : ExerciseTreeNode? {
        get {
            if children.isEmpty {
                return nil
            }
            var highestChildren = children[0]
            for child in children {
                if child.heuristicValue > highestChildren.heuristicValue {
                    highestChildren = child
                }
            }
            return highestChildren
        }
    }
    
    init(value: Exercise, for user: User, with parent: ExerciseTreeNode?) {
        self.value = value
        self.user = user
        self.parent = parent
    }
    
    func add(child: ExerciseTreeNode) {
        children.append(child)
        child.parent = self
    }
    
    func add(children: [ExerciseTreeNode]) {
        for child in children {
            self.children.append(child)
        }
        
    }
    
    public func calculateHeuristicValueForChildren()-> Int {
        var total = 0
        for exerciseTreeNode in children {
            total += exerciseTreeNode.heuristicValue
        }
        return total
    }
    
    private func calculateHeuristicValueForNode()-> Int {
        return calculateExperienceValue() + calculateValueForRepetitiveExercise() - numberOfTimesTrainedInParent()
    }
    
    private func calculateExperienceValue()-> Int {
        if user.isNotExperimented() && value.isEasy() {
            return 3
        } else if user.isNotExperimented() && value.isNormal() {
            return 2
        }
        
        if user.isModeratelyExperimented() && value.isNormal() {
            return 3
        } else if user.isNotExperimented() && value.isEasy() {
            return 2
        }
    
        if (user.isExperimented() && value.isHard()) {
            return 3
        } else if user.isNotExperimented() && value.isNormal() {
            return 2
        }
        
        return 0
    }
    
    private func calculateValueForRepetitiveExercise()-> Int {
        if exerciseExistsInParent() {
            return 0
        }
        return 3
    }
    
    private func exerciseExistsInParent()-> Bool {
        if parent == nil {
            return false
        }
        
        var parentToCheck : ExerciseTreeNode? = parent
        while (parentToCheck != nil) {
            if parentToCheck?.value.id == value.id {
                return true
            }
            parentToCheck = parentToCheck?.parent
        }
        
        return false
    }
    
    private func numberOfTimesTrainedInParent()-> Int {
        if parent == nil {
            return 0
        }
        
        var repetitions = 0
        var parentToCheck = parent
        while (parentToCheck != nil) {
            for currentMuscle in value.affectedMuscles {
                for parentMuscle in parentToCheck!.value.affectedMuscles {
                    if currentMuscle.name == parentMuscle.name {
                        repetitions += 1
                    }
                }
            }
            parentToCheck = parentToCheck?.parent
        }
        
        return repetitions
    }
    
}
