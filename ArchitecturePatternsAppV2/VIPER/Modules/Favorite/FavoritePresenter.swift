//
//  FavoritePresenter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 21.10.2025.
//

import Foundation

protocol FavoriteViewOutput: AnyObject {
    func viewIsReady()
    func userDidSelectRow(at indexPath: IndexPath)
    func userDidTapSideMenu()
}

final class FavoritePatternsPresenter: FavoriteViewOutput {
    
    weak var view: FavoriteViewInput?
    private let interactor: FavoriteInteractorInput
    private let router: FavoriteRouterInput
    
    private var rows: [Pattern] = []
    
    init(view: FavoriteViewInput, interactor: FavoriteInteractorInput, router: FavoriteRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewIsReady() {
        rows = interactor.fetchFavoritePatterns()
        view?.render(rows: rows)
    }
    
    func userDidSelectRow(at indexPath: IndexPath) {
        guard let id = interactor.getPatternId(at: indexPath) else { return }
        interactor.incrementViewCount(for: id)
        rows = interactor.fetchFavoritePatterns()
        view?.render(rows: rows)
        router.openPatternDetails(id: id)
    }
    
    func userDidTapSideMenu() {
        router.toggleSideMenu()
    }



}
