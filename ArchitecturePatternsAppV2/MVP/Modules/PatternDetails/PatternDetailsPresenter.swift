//
//  PatternDetaillsPresenter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 22.10.2025.
//

import Foundation
#warning("Избавиться от UIKit")
import UIKit

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
    
    func didTapSaveButton() {
        guard
            let fields = view?.editedFields(),
            var pattern = storage.getPatternByID(objectID)
        else { return }
        
        pattern.name = fields.name
        pattern.description = fields.description
        pattern.image = fields.image
        pattern.type = fields.type
        
        storage.updatePattern(pattern)
        view?.display(pattern: pattern)
           
    }
    
    func viewDidLoad() {
        guard let pattern = storage.getPatternByID(objectID) else { return }
        view?.display(pattern: pattern)
    }
}
