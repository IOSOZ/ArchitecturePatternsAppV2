//
//  FavoriteRouter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 07.11.2025.
//

import Foundation


protocol FavoriteRouterInput {
    func openPatternDetails(id: UUID)
    func performChangeBaseViewController()
}

final class FavoriteRouter: FavoriteRouterInput {
    func openPatternDetails(id: UUID) {
        
    }
    
    func performChangeBaseViewController() {
    }
}
