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
    func dataForCell(at indexPath: IndexPath) -> PatternModel
    func getNumberOfRows(for section: Int) -> Int
    func getNumberOfSections() -> Int
}

protocol DesignPatternsInteractorOutput: AnyObject {
    func didLoadSections(_ sections: [[PatternModel]])
    func didFailLoading(_ error: Error)
    func didUpdateRow(at indexPath: IndexPath)
    func didDeleteRow(at indexPath: IndexPath)
}


final class DesignPatternsPresenter {
    
    private weak var view: DesignPatternsInput?
    private let interactor: DesignPatternInteractorInput
    private let router: DesignPatternRouterInput
    
    private var data: [[PatternModel]] = []
    
    init(view: DesignPatternsInput?, interactor: DesignPatternInteractorInput, router: DesignPatternRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension DesignPatternsPresenter: DesignPatternsViewOutput {
    
    func viewIsReady() {
        interactor.loadPatterns()
    }
    
    func viewWillShow() {
        interactor.loadPatterns()
    }
    
    func userDidSelectRow(at indexPath: IndexPath) {
        let pattern = data[indexPath.section][indexPath.row]
        interactor.incrementViewCounter(for: indexPath)
        view?.reloadRows(at: indexPath)
        router.openPatternDetails(id: pattern.id)
    }
    
    func userDidSwipeToDelete(at indexPath: IndexPath) {
        interactor.delete(at: indexPath)
    }
    
    func userDidTapFavorite(at indexPath: IndexPath) {
        interactor.toggleFavorite(at: indexPath)
        interactor.loadPatterns()
    }
    
    func userDidTapAddNew() {
        router.openCreationMenu()
    }
    
    func userDidTapSideMenu() {
        router.toggleSideMenu()
    }
    
    func dataForCell(at indexPath: IndexPath) -> PatternModel {
        return data[indexPath.section][indexPath.row]
    }
    
    func getNumberOfRows(for section: Int) -> Int {
        return data[section].count
    }
    
    func getNumberOfSections() -> Int {
        return data.count
    }
}

extension DesignPatternsPresenter: DesignPatternsInteractorOutput {
    func didLoadSections(_ sections: [[PatternModel]]) {
        self.data = sections
    }
    
    func didFailLoading(_ error: any Error) {
        print ("Error: \(error)")
    }
    
    func didUpdateRow(at indexPath: IndexPath) {
        view?.reloadRows(at: indexPath)
    }
    
    func didDeleteRow(at indexPath: IndexPath) {
        interactor.loadPatterns()
    }
}
