//
//  PatternCreationInteractor.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 10.11.2025.
//

import Foundation

protocol PatternCreationInteractorInput: AnyObject {
    func create(pattern: Pattern)
}


final class PatternCreationInteractor: PatternCreationInteractorInput {
    
    private let storage: PatternStorageProtocol
    
    init(storage: PatternStorageProtocol) {
        self.storage = storage
    }
    
    func create(pattern: Pattern) {
        storage.addNewPattern(pattern)
    }
    
    
}
