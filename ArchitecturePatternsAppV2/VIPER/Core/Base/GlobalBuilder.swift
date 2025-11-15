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
    case oop
    case solid
    case architecturalPatterns
    case sideMenu
}


struct GlobalBuilder {
    
    private static var storage: PatternStorageProtocol!
    private static weak var container: ContainerViewController?
    
    static func configure(storage: PatternStorageProtocol, container: ContainerViewController) {
        self.storage = storage
        self.container = container
    }
    
    static func create(_ module: Module) -> RootViewController {
    
        switch module {
            
        case .designPatterns:
            let view = DesignPatternsViewController()
            let interactor = DesignPatternInteractor(storage: storage )
            let router = DesignPatternRouter(viewController: view)
            let presenter = DesignPatternsPresenter(view: view, interactor: interactor, router: router)
            
            interactor.presenter = presenter
            router.container = container
            view.presenter = presenter
            
            
            return view
        case .favorite:
            let view = FavoriteViewController()
            let interactor = FavoriteInteractor(storage: storage)
            let router = FavoriteRouter(viewController: view)
            let presenter = FavoritePatternsPresenter(view: view, interactor: interactor, router: router)
            
            interactor.presenter = presenter
            router.container = container
            view.presenter = presenter
            
            return view
        case .patternDetails(let id):
            let view = PatternDetailsViewController()
            let interactor = PatternDetailsInteractor(storage: storage, id: id)
            let router = PatternDetailsRouter(viewController: view)
            let presenter = PatternDetailsPresenter(view: view, router: router, interactor: interactor, patternID: id)
            
            interactor.presenter = presenter
            view.presenter = presenter
            
            return view
            
        case .patternCreation:
            let view = PatternCreationViewController()
            let interactor = PatternCreationInteractor(storage: storage)
            let router = PatternCreationRouter(viewController: view)
            let presenter = PatternCreationPresenter(view: view, interactor: interactor, router: router)
            
            interactor.presenter = presenter
            view.presenter = presenter
            
            return view
        case .sideMenu:
            let view = SideMenuViewController()
            let router = SideMenuRouter()
            let presenter = SideMenuPresenter(view: view, router: router)
            
            router.container = container
            view.presenter = presenter
            
            return view
    
        case .oop:
            let view = OOPViewController()
            let router = EmptyRouter()
            let presenter = EmptyPresenter(view: view, router: router)
            
            router.container = container
            view.presenter = presenter
            
            return view
            
        case .solid:
            let view = SOLIDViewController()
            let router = EmptyRouter()
            let presenter = EmptyPresenter(view: view, router: router)
            
            router.container = container
            view.presenter = presenter
            
            return view
            
        case .architecturalPatterns:
            let view = ArchitecturalPatternsViewController()
            let router = EmptyRouter()
            let presenter = EmptyPresenter(view: view, router: router)
            
            router.container = container
            view.presenter = presenter
            
            return view
        }
    }
}


