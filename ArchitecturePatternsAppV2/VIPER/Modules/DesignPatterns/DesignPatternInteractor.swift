//
//  DesignPatternInteractor.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 05.11.2025.
//

import Foundation

protocol DesignPatternInteractorInput: AnyObject {
    func loadPatterns()
    func toggleFavorite(at indexPath: IndexPath)
    func delete(at indexPath: IndexPath)
    func incrementViewCounter(for indexPath: IndexPath)
}


final class DesignPatternInteractor: DesignPatternInteractorInput {
    
    weak var presenter: DesignPatternsInteractorOutput?
    private let storage: PatternStorageProtocol
    private var sections: [[PatternModel]] = []
    
    //    private var patterns: [PatternModel] { (try? storage.getAllPatterns()) ?? []}
    
    init(storage: PatternStorageProtocol) {
        self.storage = storage
    }
    
    func loadPatterns() {
        do {
            let allPattern = try storage.getAllPatterns()
            sections = Self.makeSections(from: allPattern)
            presenter?.didLoadSections(sections)
        } catch {
            presenter?.didFailLoading(error)
        }
    }
    
    func toggleFavorite(at indexPath: IndexPath) {
        var pattern = sections[indexPath.section][indexPath.row]
        pattern.isFavorite.toggle()
        
        do {
            try storage.updatePattern(pattern)
            sections[indexPath.section][indexPath.row] = pattern
            presenter?.didUpdateRow(at: indexPath)
        } catch {
            presenter?.didFailLoading(error)
        }
    }
    
    func delete(at indexPath: IndexPath) {
        let pattern = sections[indexPath.section][indexPath.row]
        
        do {
            try storage.removePattern(pattern)
            sections[indexPath.section].remove(at: indexPath.row)
            presenter?.didDeleteRow(at: indexPath)
        } catch {
            presenter?.didFailLoading(error)
        }
    }
    
    func incrementViewCounter(for indexPath: IndexPath) {
        let pattern = sections[indexPath.section][indexPath.row]
        do {
            try storage.incrementViewCounterFor(pattern: pattern)
        } catch {
            presenter?.didFailLoading(error)
        }
    }
}


private extension DesignPatternInteractor {
    static func makeSections(from all: [PatternModel]) -> [[PatternModel]] {
        let grouped = Dictionary(grouping: all, by: {$0.type})
        return PatternType.allCases.map { type in
            grouped[type] ?? []
        }
    }
}


//
//func fetchPatterns() -> [[Pattern]] {
//    return patterns
//}
//
//func toggleFavorite(for id: UUID) {
//    guard var pattern = storage.getPatternByID(id) else { return }
//    pattern.isFavorite.toggle()
//    storage.updatePattern(pattern)
//}
//
//func deletePattern(for id: UUID) {
//    if let pattern = storage.getPatternByID(id) {
//        storage.removePattern(pattern)
//    }
//}
//
//func incrementViewCount(for id: UUID) {
//    guard let pattern = storage.getPatternByID(id) else { return }
//    storage.incrementViewCounterFor(pattern: pattern)
//}
//
//func getPatternId(at indexPath: IndexPath) -> UUID? {
//    guard patterns.indices.contains(indexPath.section),
//          patterns[indexPath.section].indices.contains(indexPath.row) else { return nil}
//    return patterns[indexPath.section][indexPath.row].id
//}
