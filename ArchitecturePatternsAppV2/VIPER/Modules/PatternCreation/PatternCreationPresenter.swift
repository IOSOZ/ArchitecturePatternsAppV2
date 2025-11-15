//
//  PatternCreationPresenter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 23.10.2025.
//

import Foundation

protocol PatternCreationViewOutput: AnyObject {
    func didTapSave()
    func didTapCancel()
    func didTapChooseType()
    func didTapChangeImage()
    func didNotFillRequiredFields()
}

protocol PatternCreationInteractorOutput: AnyObject {
    func didCreateNew(pattern: PatternModel)
    func didFailCreating(_ error: Error)
}

final class PatternCreationPresenter {
    
    
    private weak var view: PatternCreationViewInput?
    private let interactor: PatternCreationInteractorInput
    private let router: PatternCreationRouterInput
    
    init(view: PatternCreationViewInput? = nil, interactor: PatternCreationInteractorInput, router: PatternCreationRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension PatternCreationPresenter: PatternCreationViewOutput {
    
    func didTapSave() {
        guard let fields = view?.getEditedFields() else { return }
        let newPattern = PatternModel(
            id: UUID(),
            type: fields.type,
            name: fields.name,
            description: fields.description,
            image: fields.image,
            viewCounter: 0,
            isFavorite: false
        )
        
        interactor.create(pattern: newPattern)
    }
    
    func didTapCancel() {
        router.close()
    }
    
    func didTapChooseType() {
        router.showBottomSheet()
    }
    
    func didTapChangeImage() {
        router.showImageSourceAlert()
    }
    
    func didNotFillRequiredFields() {
        router.showCreationErrorAlert()
    }
    
}

extension PatternCreationPresenter: PatternCreationInteractorOutput{
    func didCreateNew(pattern: PatternModel) {
        router.close()
    }
    
    func didFailCreating(_ error: any Error) {
        print("Failed to save pattern: \(error)")
    }
    
    
}
