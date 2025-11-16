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

protocol FavoriteInteractorOutput: AnyObject {
    func didLoadRows(_ rows: [PatternModel])
    func didFailLoading(_ error: Error)
}

final class FavoritePatternsPresenter {
    
    weak var view: FavoriteViewInput?
    private let interactor: FavoriteInteractorInput
    private let router: FavoriteRouterInput
    
    private var rows: [PatternModel] = []
    
    init(view: FavoriteViewInput, interactor: FavoriteInteractorInput, router: FavoriteRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension FavoritePatternsPresenter: FavoriteViewOutput {
    func viewIsReady() {
        interactor.loadFavoritePatterns()
    }
    
    func userDidSelectRow(at indexPath: IndexPath) {
        let pattern = rows[indexPath.row]
        interactor.incrementViewCounter(for: indexPath)
        router.openPatternDetails(id: pattern.id)
    }
    
    func userDidTapSideMenu() {
        router.toggleSideMenu()
    }
}

extension FavoritePatternsPresenter: FavoriteInteractorOutput {
    func didLoadRows(_ rows: [PatternModel]) {
        self.rows = rows
        view?.render(rows: rows)
    }
    
    func didFailLoading(_ error: any Error) {
        print ("Error: \(error)")
    }
}
