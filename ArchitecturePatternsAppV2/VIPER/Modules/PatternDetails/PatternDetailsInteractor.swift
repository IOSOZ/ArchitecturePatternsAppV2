//
//  PatternDetailsInteractor.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 07.11.2025.
//

import Foundation


protocol PatternDetailsInteractorInput: AnyObject {
    func getPattern(with id: UUID) -> Pattern?
    func updatePattern(with pattern: Pattern)
}

final class PatternDetailsInteractor: PatternDetailsInteractorInput {
   
    private let storage: PatternStorageProtocol
    
    
    init(storage: PatternStorageProtocol) {
        self.storage = storage
    }
    
    func getPattern(with id: UUID) -> Pattern? {
        guard let pattern = storage.getPatternByID(id) else { return nil }
        return pattern
    }
    
    func updatePattern(with pattern: Pattern) {
        storage.updatePattern(pattern)
    }
    
    
    
    
}


