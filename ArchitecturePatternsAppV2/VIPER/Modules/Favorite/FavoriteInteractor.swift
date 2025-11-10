//
//  FavoriteInteractor.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 07.11.2025.
//

import Foundation


protocol FavoriteInteractorInput {
    func fetchFavoritePatterns() -> [Pattern]
    func getPatternId(at indexPath: IndexPath) -> UUID?
}

final class FavoriteInteractor: FavoriteInteractorInput {
    private let storage: PatternStorageProtocol
    private var patterns: [Pattern] { storage.getFavoritePatterns() }
    
    init(storage: PatternStorageProtocol) {
        self.storage = storage
    }
    
    func fetchFavoritePatterns() -> [Pattern] {
        return patterns
    }
    
    func getPatternId(at indexPath: IndexPath) -> UUID? {
        guard patterns.indices.contains(indexPath.row) else { return nil}
        return patterns[indexPath.row].id
    }
}
