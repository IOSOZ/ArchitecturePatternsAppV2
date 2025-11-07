//
//  ContentViewPresenter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 20.10.2025.
//

import Foundation

protocol DesignPatternsViewOutput: AnyObject  {
    func viewDidLoad()
    func didSelectRow(at indexPath: IndexPath)
    func didSwipeToDelete(at indexPath: IndexPath)
    func didTapFavorite(at indexPath: IndexPath)
    func didTapAddNew()
    func didTapSideMenu()
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
    
    func viewDidLoad() {
        sections = interactor.fetchPatterns()
        view?.render(sections: sections)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard let id = interactor.getPatternId(at: indexPath) else { return }
        interactor.incrementViewCount(for: id)
        view?.refreshView()
        router.openPatternDetails(id: id)
    }
    
    func didSwipeToDelete(at indexPath: IndexPath) {
        guard let id = interactor.getPatternId(at: indexPath) else { return }
        interactor.deletePattern(for: id)
        sections = interactor.fetchPatterns()
        view?.render(sections: sections)
    }
    
    func didTapFavorite(at indexPath: IndexPath) {
        guard let id = interactor.getPatternId(at: indexPath) else { return }
        interactor.toggleFavorite(for: id)
        sections = interactor.fetchPatterns()
        view?.render(sections: sections)
    }
    
    func didTapAddNew() {
        router.openCreationMenu()
    }
    
    func didTapSideMenu() {

    }
    
    
    
    
    
}
