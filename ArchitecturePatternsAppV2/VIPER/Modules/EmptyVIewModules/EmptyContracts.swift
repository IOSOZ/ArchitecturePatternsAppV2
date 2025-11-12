//
//  EmptyContracts.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 12.11.2025.
//

import Foundation

protocol EmptyViewInput: AnyObject { }

protocol EmptyViewOutput: AnyObject {
    func userDidTapSideMenu()
}

protocol EmptyRouterInput: AnyObject {
    func toggleSideMenu()
}


