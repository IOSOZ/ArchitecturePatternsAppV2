//
//  PatternCreationBuilder.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 23.10.2025.
//

import Foundation

final class PatternCreationBuilder {
    static func createModule(for viewController: PatternCreationViewController, storage: PatternStorageProtocol) -> PatternCreationViewController {
        viewController.presenter = PatternCreationPresenter(view: viewController, storage: storage)
        return viewController
    }
}
