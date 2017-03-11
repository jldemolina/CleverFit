//
//  Array.swift
//  Clevefit
//
//  Created by Jose Luis Molina on 10/3/17.
//  Copyright © 2017 SebastianAndersen. All rights reserved.
//

import Foundation

public struct Permutator {
    
    public static func permutationsWithoutRepetitionFrom<T>(elements: [T], taking: Int) -> [[T]] {
        guard elements.count >= taking else { return [] }
        guard elements.count >= taking && taking > 0 else { return [[]] }
        
        if taking == 1 {
            return elements.map {[$0]}
        }
        
        var permutations = [[T]]()
        for (index, element) in elements.enumerated() {
            var reducedElements = elements
            reducedElements.remove(at: index)
            permutations += permutationsWithoutRepetitionFrom(elements: reducedElements, taking: taking - 1).map {[element] + $0}
        }
        
        return permutations
    }
    
    public static func permutationsWithRepetitionFrom<T>(elements: [T], taking: Int) -> [[T]] {
        guard elements.count >= 0 && taking > 0 else { return [[]] }
        
        if taking == 1 {
            return elements.map {[$0]}
        }
        
        var permutations = [[T]]()
        for element in elements {
            permutations += permutationsWithRepetitionFrom(elements: elements, taking: taking - 1).map {[element] + $0}
        }
        
        return permutations
    }
    
    // MARK: - Combinations
    
    public static func combinationsWithoutRepetitionFrom<T>(elements: [T], taking: Int) -> [[T]] {
        guard elements.count >= taking else { return [] }
        guard elements.count > 0 && taking > 0 else { return [[]] }
        
        if taking == 1 {
            return elements.map {[$0]}
        }
        
        var combinations = [[T]]()
        for (index, element) in elements.enumerated() {
            var reducedElements = elements
            reducedElements.removeFirst(index + 1)
            combinations += combinationsWithoutRepetitionFrom(elements: reducedElements, taking: taking - 1).map {[element] + $0}
        }
        
        return combinations
    }
    
    public static func combinationsWithRepetitionFrom<T>(elements: [T], taking: Int) -> [[T]] {
        guard elements.count >= 0 && taking > 0 else { return [[]] }
        
        if taking == 1 {
            return elements.map {[$0]}
        }
        
        var combinations = [[T]]()
        var reducedElements = elements
        for element in elements {
            combinations += combinationsWithRepetitionFrom(elements: reducedElements, taking: taking - 1).map {[element] + $0}
            reducedElements.removeFirst()
        }
        
        return combinations
    }
    
}
