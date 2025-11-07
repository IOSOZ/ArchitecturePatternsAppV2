//
//  StorageManager.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 21.10.2025.
//

import Foundation

final class StorageManager: PatternStorageProtocol {
    
    private let dataStore: DataStore
    init(dataStore: DataStore = .shared) {
        self.dataStore = dataStore
    }
    
    func getAllPatterns() -> [[Pattern]] {
        return [dataStore.creationalPatterns, dataStore.structuralPatterns, dataStore.behavioralPatterns]
    }
    
    func getPatternFor(indexPath: IndexPath) -> Pattern {
        return dataStore[indexPath.section][indexPath.row]
    }
    
    func getFavoritePatterns() -> [Pattern] {
        var favoritePattens: [Pattern] = []
        let allPatterns = getAllPatterns().flatMap { $0 }
        allPatterns.forEach { pattern in
            if pattern.isFavorite == true {
                favoritePattens.append(pattern)
            }
        }
        return favoritePattens
    }
    
    func addNewPattern(_ pattern: Pattern) {
        switch pattern.type {
        case .behavioral:
            dataStore.behavioralPatterns.append(pattern)
        case .structural:
            dataStore.structuralPatterns.append(pattern)
        case .creational:
            dataStore.creationalPatterns.append(pattern)
        }
    }
    
    func updatePattern(_ pattern: Pattern) {
        guard let oldPattern = getPatternByID(pattern.id) else { return }
        
        if oldPattern.type != pattern.type {
            removePattern(oldPattern)
            addNewPattern(pattern)
            return
        }
        
        switch pattern.type {
        case .behavioral:
            if let index = dataStore.behavioralPatterns.firstIndex(where: { $0.id == pattern.id }) {
                dataStore.behavioralPatterns[index] = pattern
            }
        case .creational:
            if let index = dataStore.creationalPatterns.firstIndex(where: { $0.id == pattern.id }) {
                dataStore.creationalPatterns[index] = pattern
            }
        case .structural:
            if let index = dataStore.structuralPatterns.firstIndex(where: { $0.id == pattern.id }) {
                dataStore.structuralPatterns[index] = pattern
            }
        }
    }
    
    func incrementViewCounterFor(pattern : Pattern) {
        var incrementPattern = pattern
        incrementPattern.viewCounter += 1
        updatePattern(incrementPattern)
    }
    
    func getPatternByID(_ id: UUID) -> Pattern? {
        let allPattens = getAllPatterns().flatMap { $0 }
        return allPattens.first { $0.id == id }
    }
    
    func removePattern(_ pattern: Pattern ) {
        switch pattern.type {
        case .behavioral:
            guard let index = dataStore.behavioralPatterns.firstIndex(where: { $0.id == pattern.id}) else {return}
            dataStore.behavioralPatterns.remove(at: index)
        case .structural:
            guard let index = dataStore.structuralPatterns.firstIndex(where: { $0.id == pattern.id}) else {return}
            dataStore.structuralPatterns.remove(at: index)
        case .creational:
            guard let index = dataStore.creationalPatterns.firstIndex(where: { $0.id == pattern.id}) else {return}
            dataStore.creationalPatterns.remove(at: index)
        }
    }
    //    private func getPatternByName(_ name: String) -> Pattern? {
    //        let allPattens = getAllPatterns().flatMap { $0 }
    //        return allPattens.first { $0.name == name }
    //    }
}
