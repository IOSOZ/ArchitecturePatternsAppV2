//
//  OOPPresenter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 12.11.2025.
//

import Foundation

final class EmptyPresenter: EmptyViewOutput {
    
    private weak var view: EmptyViewInput?
    private let router: EmptyRouterInput
    
    init(view: EmptyViewInput, router: EmptyRouterInput) {
        self.view = view
        self.router = router
    }
    
    func userDidTapSideMenu() {
        router.toggleSideMenu()
    }
}
