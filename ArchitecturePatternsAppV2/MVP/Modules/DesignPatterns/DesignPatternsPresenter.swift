//
//  ContentViewPresenter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 20.10.2025.
//

import Foundation

protocol DesignPatternsPresenterProtocol: AnyObject  {
    func getData()
    func getPattern(at indexPath: IndexPath)
    func deletePattern(at indexPath: IndexPath)
    func toggleFavoriteForPattern(at indexPath: IndexPath)
}

final class DesignPatternsPresenter: DesignPatternsPresenterProtocol {
    
    weak var view: DesignPatternsViewProtocol?
    private let storage: PatternStorageProtocol
    var patterns: [[Pattern]] { storage.getAllPatterns() }
    
    init(view: DesignPatternsViewProtocol, storage: PatternStorageProtocol) {
        self.view = view
        self.storage = storage
    }
    
    func getData() {
        view?.refreshView()
    }
    
    func getPattern(at indexPath: IndexPath) {
        let pattern = storage.getPatternFor(indexPath: indexPath)
        storage.incrementViewCounterFor(pattern: pattern)
        view?.refreshView()
        view?.showPatternDetails(forID: pattern.id)
    }
    
    func deletePattern(at indexPath: IndexPath) {
        let pattern = patterns[indexPath.section][indexPath.row]
        storage.removePattern(pattern)
        view?.refreshView()
    }
    
    func toggleFavoriteForPattern(at indexPath: IndexPath) {
        var pattern = storage.getPatternFor(indexPath: indexPath)
        pattern.isFavorite.toggle()
        storage.updatePattern(pattern)
        view?.refreshView()
    }
}
