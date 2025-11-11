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
    func creationError()
}

final class PatternCreationPresenter: PatternCreationViewOutput {
    
    
    private weak var view: PatternCreationViewInput?
    private let interactor: PatternCreationInteractorInput
    private let router: PatternCreationRouterInput
    
    init(view: PatternCreationViewInput? = nil, interactor: PatternCreationInteractorInput, router: PatternCreationRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func didTapSave() {
        guard let fields = view?.getEditedFields() else { return }
        let newPattern = Pattern(
            type: fields.type,
            name: fields.name,
            description: fields.description,
            image: fields.image
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
    
    func creationError() {
        router.showCreationErrorAlert()
    }
}
