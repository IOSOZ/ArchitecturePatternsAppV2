//
//  PatternCreationPresenter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 23.10.2025.
//

import Foundation

protocol PatternCreationPresenterProtocol {
    func createPattern()
}

final class PatternCreationPresenter: PatternCreationPresenterProtocol {
    weak var view: PatternCreationViewController?
    private let storage: PatternStorageProtocol
    
    init(view: PatternCreationViewController?, storage: PatternStorageProtocol) {
        self.view = view
        self.storage = storage
    }
    
    func createPattern() {
        guard let fields = view?.getEditedFields() else { return }
        let pattern = Pattern(type: fields.type, name: fields.name, description: fields.description, image: fields.image)
        
        storage.addNewPattern(pattern)
    }
}
