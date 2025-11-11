//
//  DesignPatternInteractor.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 05.11.2025.
//

import Foundation

protocol DesignPatternInteractorInput: AnyObject {
    func fetchPatterns() -> [[Pattern]]
    func toggleFavorite(for id: UUID)
    func deletePattern(for id: UUID)
    func incrementViewCount(for id: UUID)
    func getPatternId(at indexPath: IndexPath) -> UUID?
}


final class DesignPatternInteractor: DesignPatternInteractorInput {
    
    private let storage: PatternStorageProtocol
    private var patterns: [[Pattern]] { storage.getAllPatterns() }
    
    init(storage: PatternStorageProtocol) {
        self.storage = storage
    }
    
    
    func fetchPatterns() -> [[Pattern]] {
        return patterns
    }
    
    func toggleFavorite(for id: UUID) {
        guard var pattern = storage.getPatternByID(id) else { return }
        pattern.isFavorite.toggle()
        storage.updatePattern(pattern)
    }
    
    func deletePattern(for id: UUID) {
        if let pattern = storage.getPatternByID(id) {
            storage.removePattern(pattern)
        }
    }
    
    func incrementViewCount(for id: UUID) {
        guard let pattern = storage.getPatternByID(id) else { return }
        storage.incrementViewCounterFor(pattern: pattern)
    }
    
    func getPatternId(at indexPath: IndexPath) -> UUID? {
        guard patterns.indices.contains(indexPath.section),
              patterns[indexPath.section].indices.contains(indexPath.row) else { return nil}
        return patterns[indexPath.section][indexPath.row].id
    }
    
}
