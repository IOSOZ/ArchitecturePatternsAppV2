//
//  FavoriteRouter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 07.11.2025.
//

import Foundation
import UIKit

protocol FavoriteRouterInput {
    func openPatternDetails(id: UUID)
    func toggleSideMenu()
}

final class FavoriteRouter: FavoriteRouterInput {
    
    weak var container: ContainerRouting?
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func openPatternDetails(id: UUID) {
        let vc = GlobalBuilder.create(.patternDetails(id))
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func toggleSideMenu() {
        container?.toggleSideMenu(nil)
    }
}
