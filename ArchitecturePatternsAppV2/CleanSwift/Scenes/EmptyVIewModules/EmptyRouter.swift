//
//  OOPRouter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 12.11.2025.
//

import Foundation

protocol EmptyRoutingLogic: AnyObject {
    func toggleSideMenu()
}

final class EmptyRouter: EmptyRoutingLogic {
    weak var container: ContainerRouting?
    
    func toggleSideMenu() {
        container?.toggleSideMenu(nil)
    }
}
