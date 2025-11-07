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
            
            
            view.presenter = presenter
            
            
            return view
        case .favorite:
            let vc = FavoriteViewController()
            let presenter = FavoritePatternsPresenter(view: vc, storage: storage)
            
            vc.presenter = presenter
            
            return vc
        case .patternDetails(let id):
                let vc = PatternDetailsViewController()
                let presenter = PatternDetailsPresenter(view: vc, storage: storage, objectID: id)
                
                vc.presenter = presenter
                
                return vc
            
        case .patternCreation:
            let vc = PatternCreationViewController()
            let presenter = PatternCreationPresenter(view: vc, storage: storage)
            
            vc.presenter = presenter
            
            return vc
        }
    
    }
}

