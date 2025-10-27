//
//  FavoritePresenter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 21.10.2025.
//

import Foundation

final class FavoritePatternsPresenter: FavoritePresenterProtocol {
    weak var view: FavoriteViewProtocol?
    
    private let storage: PatternStorageProtocol
    var patterns: [Pattern] { storage.getFavoritePatterns() }
    
    init(view: FavoriteViewProtocol, storage: PatternStorageProtocol) {
        self.view = view
        self.storage = storage
    }
    
    func viewDidLoad() {
        view?.reloadData()
    }
    
    func viewWillAppear() {
        view?.reloadData()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let favoritePatterns = storage.getFavoritePatterns()
        guard let pattern = storage.getPatternByID(favoritePatterns[indexPath.row].id) else { return }
        storage.incrementViewCounterFor(pattern: pattern)
        view?.reloadData()
        view?.showPatternDetails(forID: pattern.id)
    }
}
