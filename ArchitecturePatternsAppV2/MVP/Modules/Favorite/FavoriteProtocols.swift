//
//  FavoriteProtocols.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 21.10.2025.
//

import Foundation

protocol FavoriteViewProtocol: AnyObject {
    func reloadData()
    func showPatternDetails(forID id: UUID)
}

protocol FavoritePresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func didSelectRow(at indexPath: IndexPath)
}
