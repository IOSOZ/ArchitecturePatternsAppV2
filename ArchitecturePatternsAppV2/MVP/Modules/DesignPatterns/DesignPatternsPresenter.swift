//
//  ContentViewPresenter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 20.10.2025.
//

import Foundation

final class DesignPatternsPresenter: DesignPatternsPresenterProtocol {
    
    weak var view: DesignPatternsViewProtocol?
    private let storage: PatternStorageProtocol
    var patterns: [[Pattern]] { storage.getAllPatterns() }
    
    init(view: DesignPatternsViewProtocol, storage: PatternStorageProtocol) {
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
        let pattern = storage.getPatternFor(indexPath: indexPath)
        storage.incrementViewCounterFor(pattern: pattern)
        view?.reloadData()
        view?.showPatternDetails(forID: pattern.id)
    }
    
    func didSwipeToDelete(at indexPath: IndexPath) {
        let pattern = patterns[indexPath.section][indexPath.row]
        storage.removePattern(pattern)
        view?.reloadData()
    }
    
    func didTapFavorite(at indexPath: IndexPath) {
        var pattern = storage.getPatternFor(indexPath: indexPath)
        pattern.isFavorite.toggle()
        storage.updatePattern(pattern)
        view?.reloadData()
    }
}
