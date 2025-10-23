//
//  ModuleBuilder.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 21.10.2025.
//

import UIKit

protocol BaseBuilder {
    static func createVC(with container: ContainerViewController?, for viewController: BaseContentViewController) -> BaseContentViewController
}

class BaseModuleBuilder: BaseBuilder {
    static func createVC(with container: ContainerViewController?, for viewController: BaseContentViewController) -> BaseContentViewController {
        viewController.container = container
        
        switch viewController {
        case let designPatternsVC as DesignPatternsViewController:
            designPatternsVC.presenter = DesignPatternsPresenter(view: designPatternsVC)
            return designPatternsVC
        case let favoriteVC as FavoriteViewController:
            favoriteVC.presenter = FavoritePatternsPresenter(view: favoriteVC)
            return favoriteVC
        default:
            viewController.basePresenter = BaseContentPresenter(view: viewController)
            return viewController
        }
    }
}


