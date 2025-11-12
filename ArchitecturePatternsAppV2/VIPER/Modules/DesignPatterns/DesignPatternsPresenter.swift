//
//  ContentViewPresenter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 20.10.2025.
//

import Foundation

protocol DesignPatternsViewOutput: AnyObject  {
    func viewIsReady()
    func viewWillShow()
    func userDidSelectRow(at indexPath: IndexPath)
    func userDidSwipeToDelete(at indexPath: IndexPath)
    func userDidTapFavorite(at indexPath: IndexPath)
    func userDidTapAddNew()
    func userDidTapSideMenu()
}

final class DesignPatternsPresenter: DesignPatternsViewOutput {
    
    private weak var view: DesignPatternsInput?
    private let interactor: DesignPatternInteractorInput
    private let router: DesignPatternRouterInput
    
    private var sections: [[Pattern]] = []
    
    init(view: DesignPatternsInput?, interactor: DesignPatternInteractorInput, router: DesignPatternRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewIsReady() {
        sections = interactor.fetchPatterns()
        view?.render(sections: sections)
    }
    
    func viewWillShow() {
        sections = interactor.fetchPatterns()
        view?.render(sections: sections)
    }
    
    func userDidSelectRow(at indexPath: IndexPath) {
        guard let id = interactor.getPatternId(at: indexPath) else { return }
        interactor.incrementViewCount(for: id)
        sections = interactor.fetchPatterns()
        view?.render(sections: sections)
        router.openPatternDetails(id: id)
    }
    
    func userDidSwipeToDelete(at indexPath: IndexPath) {
        guard let id = interactor.getPatternId(at: indexPath) else { return }
        interactor.deletePattern(for: id)
        sections = interactor.fetchPatterns()
        view?.render(sections: sections)
    }
    
    func userDidTapFavorite(at indexPath: IndexPath) {
        guard let id = interactor.getPatternId(at: indexPath) else { return }
        interactor.toggleFavorite(for: id)
        sections = interactor.fetchPatterns()
        view?.render(sections: sections)
    }
    
    func userDidTapAddNew() {
        router.openCreationMenu()
    }
    
    func userDidTapSideMenu() {
        router.toggleSideMenu()
    }
    
    
    
    
    
}
