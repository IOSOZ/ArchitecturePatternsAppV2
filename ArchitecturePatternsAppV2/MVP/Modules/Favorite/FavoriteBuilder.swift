//
//  Favorite.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 22.10.2025.
//

import Foundation

final class FavoriteBuilder {
    static func createModule(for viewController: FavoriteViewController, container: ContainerViewController, storage: PatternStorageProtocol) -> FavoriteViewController {
        viewController.container = container
        viewController.presenter = FavoritePatternsPresenter(view: viewController, storage: storage)
        return viewController
    }
}
