//
//  PatternDetailsInteractor.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 07.11.2025.
//

import Foundation


protocol PatternDetailsInteractorInput: AnyObject {
    func getPattern()
    func updatePattern(with pattern: PatternModel)
}


final class PatternDetailsInteractor: PatternDetailsInteractorInput {
   
    weak var presenter: PatternDetailsInteractorOutput?
    private let storage: PatternStorageProtocol
    private let id: UUID
    
    
    init(storage: PatternStorageProtocol, id: UUID) {
        self.storage = storage
        self.id = id
    }
    
    func getPattern() {
        do {
            if let pattern = try storage.getPatternByID(id) {
                presenter?.didLoadPattern(pattern)
            } else {
               
            }
        } catch {
            presenter?.didFailLoading(error)
        }
    }
    
    func updatePattern(with pattern: PatternModel) {
        do {
            try storage.updatePattern(pattern)
        } catch {
            presenter?.didFailSaving(error)
        }
    }
}


