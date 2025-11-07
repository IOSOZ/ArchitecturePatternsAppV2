//
//  ContainerMangerProtocol.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 22.10.2025.
//

import Foundation

protocol ContainerDelegate: AnyObject {
    func performControllerChange(with menuItem: MenuItem)
    func toggleSideMenu() -> Bool
}
