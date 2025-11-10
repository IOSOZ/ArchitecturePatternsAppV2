//
//  PatternDetaillsPresenter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 22.10.2025.
//

import Foundation
import UIKit

protocol PatternDetailsViewOutput: AnyObject {
    func viewDidLoad()
    func didTapSave()
    func didTapCancel()
    func didTapChooseType()
    func didChoose(type: PatternType)
    func didTapChangeImage()
    func didPickImage(data: Data)
    func didTapOpenViewer()

}

class PatternDetailsPresenter: PatternDetailsViewOutput {

    private let patternID: UUID
    
    private var original: Pattern!
    private var draft: PatternDraft!
    
    private weak var view: PatternDetailsViewInput?
    private let router: PatternDetailsRouterInput
    private let interactor: PatternDetailsInteractorInput
    
    init(view: PatternDetailsViewInput?, router: PatternDetailsRouterInput, interactor: PatternDetailsInteractorInput, patternID: UUID) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.patternID = patternID
    }
    
    func viewDidLoad() {
        guard let entity = interactor.getPattern(with: patternID) else { return }
        original = entity
        draft = PatternDraft(
            id: entity.id,
            name: entity.name,
            description: entity.description,
            type: entity.type,
            isFavorite: entity.isFavorite,
            imageData: entity.image?.pngData()
        )
        pushDraftToView()
    }
    
    func didTapSave() {
        if let fields = view?.getEditedFields() {
            draft.name = fields.name
            draft.description = fields.description
        }
        
        var updated = original!
        updated.name = draft.name
        updated.description = draft.description
        updated.type = draft.type
        updated.isFavorite = draft.isFavorite
        if let data = draft.imageData {
            updated.image = UIImage(data: data)
        } else {
            updated.image = nil
        }
        
        interactor.updatePattern(with: updated)
        original = updated
        pushDraftToView()
    }
    
    func didTapCancel() {
        draft = PatternDraft(
            id: original.id,
            name: original.name,
            description: original.description,
            type: original.type,
            isFavorite: original.isFavorite,
            imageData: original.image?.pngData()
        )
        pushDraftToView()
    }
    
    func didTapChooseType() {
        router.showBottomSheet(selectedType: draft.type)
    }
    
    func didChoose(type: PatternType) {
        draft.type = type
        pushDraftToView()
    }
    
    func didTapChangeImage() {
        router.showImageSourceAlert()
    }
    
    func didPickImage(data: Data) {
        draft.imageData = data
        pushDraftToView()
    }
    
    func didTapOpenViewer() {
        guard let data = draft.imageData else { return }
        router.showImageViewer(with: data)
    }
    
    
    private func pushDraftToView() {
        let viewModel = PatternDetailsViewModel(
            name: draft.name,
            description: draft.description,
            typeTitle: draft.type.title,
            isFavorite: draft.isFavorite,
            imageData: draft.imageData
        )
        view?.display(viewModel: viewModel)
    }

}


//
//weak var view: PatternDetailsViewProtocol?
//private let storage: PatternStorageProtocol
//private let objectID: UUID
//
//var currentPattern: Pattern? { storage.getPatternByID(objectID) }
//init(view: PatternDetailsViewProtocol, storage: PatternStorageProtocol, objectID: UUID) {
//    self.view = view
//    self.storage = storage
//    self.objectID = objectID
//}
//
//func savePatternChanges() {
//    guard
//        let fields = view?.getEditedFields(),
//        var pattern = storage.getPatternByID(objectID)
//    else { return }
//    
//    pattern.name = fields.name
//    pattern.description = fields.description
//    pattern.image = fields.image
//    pattern.type = fields.type
//    
//    storage.updatePattern(pattern)
//    view?.displayFieldsWith(pattern: pattern)
//       
//}
//
//func getData() {
//    guard let pattern = storage.getPatternByID(objectID) else { return }
//    view?.displayFieldsWith(pattern: pattern)
//}
