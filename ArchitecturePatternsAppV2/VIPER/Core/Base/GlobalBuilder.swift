//
//  GlobalBuilder.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 30.10.2025.
//

import Foundation

enum Module {
    case designPatterns
    case favorite
    case patternDetails(UUID)
    case patternCreation
}


struct GlobalBuilder {
    private static let storage = StorageManager()
    static func create(_ module: Module) -> RootViewController {
    
        switch module {
        case .designPatterns:
            let view = DesignPatternsViewController()
            let interactor = DesignPatternInteractor(storage: StorageManager())
            let router = DesignPatternRouter(viewController: view)
            let presenter = DesignPatternsPresenter(view: view, interactor: interactor, router: router)
            
            view.containerDelegate = view as? ContainerDelegate
            view.presenter = presenter
            
            
            return view
        case .favorite:
            let vc = FavoriteViewController()
            
            return vc
        case .patternDetails(let id):
            let view = PatternDetailsViewController()
            let interactor = PatternDetailsInteractor(storage: StorageManager())
            let router = PatternDetailsRouter(viewController: view)
            let presenter = PatternDetailsPresenter(view: view, router: router, interactor: interactor, patternID: id)
            
            view.presenter = presenter
            
            return view
            
        case .patternCreation:
            let view = PatternCreationViewController()
            let interactor = PatternCreationInteractor(storage: StorageManager())
            let router = PatternCreationRouter(viewController: view)
            let presenter = PatternCreationPresenter(view: view, interactor: interactor, router: router)
            
            view.presenter = presenter
            
            return view
        }
    
    }
}

