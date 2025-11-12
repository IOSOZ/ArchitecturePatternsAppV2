//
//  OOPRouter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 12.11.2025.
//

import Foundation

final class EmptyRouter: EmptyRouterInput {
    weak var container: ContainerRouting?
    
    func toggleSideMenu() {
        container?.toggleSideMenu(nil)
    }
    
    
}
