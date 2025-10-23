//
//  StorageManagerProtocol.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 22.10.2025.
//

import Foundation

protocol PatternStorageProtocol {
    func getAllPatterns() -> [[Pattern]]
    func getPatternFor(indexPath: IndexPath) -> Pattern
    func getFavoritePatterns() -> [Pattern]
    func addNewPattern(_ pattern: Pattern)
    func updatePattern(_ pattern: Pattern)
    func incrementViewCounterFor(pattern : Pattern)
    func getPatternByID(_ id: UUID) -> Pattern?
    func removePattern(_ pattern: Pattern )
}
