//
//  SideMenuPresenter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 11.11.2025.
//

import Foundation

protocol SideMenuViewOutput: AnyObject {
    func userDidChoseModule(_ module: MenuItem)
}

final class SideMenuPresenter: SideMenuViewOutput {
    
    weak var view: SideMenuViewInput?
    private let router: SideMenuRouterInput
    
    init(view: SideMenuViewInput, router: SideMenuRouter) {
        self.view = view
        self.router = router
    }
    
    func userDidChoseModule(_ module: MenuItem) {
        router.setMainViewController(with: module)
    }
}
