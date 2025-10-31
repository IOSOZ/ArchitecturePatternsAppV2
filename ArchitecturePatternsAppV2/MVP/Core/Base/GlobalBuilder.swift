//
//  GlobalBuilder.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 30.10.2025.
//

import Foundation


final class ModuleDeps {
    let storage: PatternStorageProtocol
    weak var container: ContainerViewController?
    
    init(storage: PatternStorageProtocol, container: ContainerViewController?) {
        self.storage = storage
        self.container = container
    }
}

enum GlobalBuilder {
    static func designPatterns(_ deps: ModuleDeps) -> DesignPatternsViewController {
        let vc = DesignPatternsViewController()
        let presenter = DesignPatternsPresenter(view: vc, storage: deps.storage)
        
        vc.deps = deps
        vc.container = deps.container
        vc.presenter = presenter
        
        return vc
    }
    
    static func favorite(_ deps: ModuleDeps) -> FavoriteViewController {
        let vc = FavoriteViewController()
        let presenter = FavoritePatternsPresenter(view: vc, storage: deps.storage)
        
        vc.deps = deps
        vc.container = deps.container
        vc.presenter = presenter
        
        return vc
    }
    
    static func patternDetails(_ deps: ModuleDeps, id: UUID) -> PatternDetailsViewController {
        let vc = PatternDetailsViewController()
        let presenter = PatternDetailsPresenter(view: vc, storage: deps.storage, objectID: id)
        
        vc.presenter = presenter
        
        return vc
    }
    
    static func patternCreation(_ deps: ModuleDeps) -> PatternCreationViewController {
        let vc = PatternCreationViewController()
        let presenter = PatternCreationPresenter(view: vc, storage: deps.storage)
        
        vc.presenter = presenter
        
        return vc   
    }
        
    
}
