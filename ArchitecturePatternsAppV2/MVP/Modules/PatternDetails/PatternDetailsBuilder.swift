//
//  PatternDetailsBuilder.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 22.10.2025.
//

import Foundation

final class PatternDetailsBuilder {
    static func createModule(for viewController: PatternDetailsViewController, storage: PatternStorageProtocol, objectID: UUID) -> PatternDetailsViewController {
        viewController.presenter = PatternDetailsPresenter(view: viewController, storage: storage, objectID: objectID)
        return viewController
    }
}
