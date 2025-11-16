//
//  PatternDetaillsPresenter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 22.10.2025.
//

import Foundation
import UIKit

protocol PatternDetailsViewOutput: AnyObject {
    func viewIsReady()
    func userDidTapSave()
    func userDidTapCancel()
    func userDidTapChooseType()
    func userDidChoose(type: PatternType)
    func userDidTapChangeImage()
    func userDidPickImage(data: Data)
    func userDidTapOpenViewer()
}

protocol PatternDetailsInteractorOutput: AnyObject {
    func didLoadPattern(_ pattern: PatternModel)
    func didFailLoading(_ error: Error)
    func didFailSaving(_ error: Error)
}

final class PatternDetailsPresenter {

    private let patternID: UUID
    
    private var original: PatternModel?
    private var draft: PatternModel?
    
    private weak var view: PatternDetailsViewInput?
    private let router: PatternDetailsRouterInput
    private let interactor: PatternDetailsInteractorInput
    
    init(view: PatternDetailsViewInput?, router: PatternDetailsRouterInput, interactor: PatternDetailsInteractorInput, patternID: UUID) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.patternID = patternID
    }
}

extension PatternDetailsPresenter: PatternDetailsViewOutput {
    func viewIsReady() {
        interactor.getPattern()
    }
    
    func userDidTapSave() {
        guard var draft = draft else { return }
        
        if let fields = view?.getEditedFields() {
            draft.name = fields.name
            draft.description = fields.description
        }
        
        interactor.updatePattern(with: draft)
        original = draft
        self.draft = draft
        
        view?.display(pattern: draft)
    }
    
    func userDidTapCancel() {
        guard let original else { return }
        draft = original
        view?.display(pattern: original)
    }
    
    func userDidTapChooseType() {
        guard let draft else { return }
        router.showBottomSheet(selectedType: draft.type)
    }
    
    func userDidChoose(type: PatternType) {
        guard var draft = draft else { return }
        draft.type = type
        self.draft = draft
        view?.display(pattern: draft)
    }
    
    func userDidTapChangeImage() {
        router.showImageSourceAlert()
    }
    
    func userDidPickImage(data: Data) {
        guard var draft = draft else { return }
        draft.image = data
        self.draft = draft
        view?.display(pattern: draft)
    }
    
    func userDidTapOpenViewer() {
        guard let data = draft?.image else { return }
        router.showImageViewer(with: data)
    }
}

extension PatternDetailsPresenter: PatternDetailsInteractorOutput {
    func didLoadPattern(_ pattern: PatternModel) {
        original = pattern
        draft = pattern
        view?.display(pattern: pattern)
    }
    
    func didFailLoading(_ error: any Error) {
        print("Failed to load pattern: \(error)")
    }
    
    func didFailSaving(_ error: any Error) {
        print("Failed to save pattern: \(error)")
    }
}
