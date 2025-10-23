//
//  BaseContentViewProtocols.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 20.10.2025.
//

import Foundation

protocol DesignPatternsViewProtocol: AnyObject {
    func reloadData()
    func showPatternDetails(forID id: UUID)
    func showPatternCreation()
}

protocol DesignPatternsPresenterProtocol: AnyObject  {
    func viewDidLoad()
    func viewWillAppear()
    func didSelectRow(at indexPath: IndexPath)
    func didSwipeToDelete(at indexPath: IndexPath)
    func didTapFavorite(at indexPath: IndexPath)
}

