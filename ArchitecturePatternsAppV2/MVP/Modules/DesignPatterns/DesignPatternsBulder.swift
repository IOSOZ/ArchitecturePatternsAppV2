//
//  DesignPatternsBulder.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 22.10.2025.
//

import Foundation

class DesignPatternsBuilder {
    static func createModule(for viewController: DesignPatternsViewController, container: ContainerViewController, storage: PatternStorageProtocol) -> DesignPatternsViewController {
        viewController.container = container
        viewController.presenter = DesignPatternsPresenter(view: viewController, storage: storage)
        return viewController
    }
}
