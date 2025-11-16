//
//  FavoriteInteractor.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 07.11.2025.
//

import Foundation


protocol FavoriteInteractorInput: AnyObject {
    func loadFavoritePatterns()
    func incrementViewCounter(for indexPath: IndexPath)
}

final class FavoriteInteractor: FavoriteInteractorInput {
    weak var presenter: FavoriteInteractorOutput?
    private let storage: PatternStorageProtocol
    private var patterns: [PatternModel] = []
    
    init(storage: PatternStorageProtocol) {
        self.storage = storage
    }
    
    func loadFavoritePatterns() {
        do {
            let favPatterns = try storage.getFavoritePatterns()
            patterns = favPatterns
            presenter?.didLoadRows(patterns)
        } catch {
            presenter?.didFailLoading(error)
        }
    }
    
    func incrementViewCounter(for indexPath: IndexPath) {
        let pattern = patterns[indexPath.row]
        do {
            try storage.incrementViewCounterFor(pattern: pattern)
        } catch {
            presenter?.didFailLoading(error)
        }
    }
}
