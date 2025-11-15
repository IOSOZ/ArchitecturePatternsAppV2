//
//  PatternCreationInteractor.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 10.11.2025.
//

import Foundation

protocol PatternCreationInteractorInput: AnyObject {
    func create(pattern: PatternModel)
}

final class PatternCreationInteractor: PatternCreationInteractorInput {
    
    weak var presenter: PatternCreationInteractorOutput?
    private let storage: PatternStorageProtocol
    
    init(storage: PatternStorageProtocol) {
        self.storage = storage
    }
    
    func create(pattern: PatternModel) {
        do {
            try storage.addNewPattern(pattern)
            presenter?.didCreateNew(pattern: pattern)
        } catch {
            presenter?.didFailCreating(error)
        }
        
    }
    
    
}
