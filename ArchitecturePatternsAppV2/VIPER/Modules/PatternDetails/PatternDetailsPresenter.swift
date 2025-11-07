//
//  PatternDetaillsPresenter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 22.10.2025.
//

import Foundation
#warning("Избавиться от UIKit")
import UIKit

protocol PatternDetailsPresenterProtocol: AnyObject {
    func getData()
    func savePatternChanges()
}

class PatternDetailsPresenter: PatternDetailsPresenterProtocol {
   
    weak var view: PatternDetailsViewProtocol?
    private let storage: PatternStorageProtocol
    private let objectID: UUID
    
    var currentPattern: Pattern? { storage.getPatternByID(objectID) }
    init(view: PatternDetailsViewProtocol, storage: PatternStorageProtocol, objectID: UUID) {
        self.view = view
        self.storage = storage
        self.objectID = objectID
    }
    
    func savePatternChanges() {
        guard
            let fields = view?.getEditedFields(),
            var pattern = storage.getPatternByID(objectID)
        else { return }
        
        pattern.name = fields.name
        pattern.description = fields.description
        pattern.image = fields.image
        pattern.type = fields.type
        
        storage.updatePattern(pattern)
        view?.displayFieldsWith(pattern: pattern)
           
    }
    
    func getData() {
        guard let pattern = storage.getPatternByID(objectID) else { return }
        view?.displayFieldsWith(pattern: pattern)
    }
}
