//
//  GlobalBuilder.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 30.10.2025.
//

import Foundation

enum Router {
    case designPatterns
    case favorite
    case patternDetails(UUID)
    case patternCreation
}


struct GlobalBuilder {
    private static let storage = StorageManager()
    static func create(_ module: Router) -> RootViewController {
    
        switch module {
        case .designPatterns:
            let vc = DesignPatternsViewController()
            let presenter = DesignPatternsPresenter(view: vc, storage: storage)
            
            vc.presenter = presenter
            
            return vc
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

