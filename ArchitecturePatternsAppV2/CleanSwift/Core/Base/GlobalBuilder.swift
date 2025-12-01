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

// MARK: - Build Module
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
            let interactor = DesignPatternsInteractor(worker: DesignPatternsWorker(storage: storage))
            let router = DesignPatternsRouter()
            let presenter = DesignPatternsPresenter()
            
            view.interactor = interactor
            view.router = router
            
            interactor.presenter = presenter
            presenter.viewController = view
            
            router.viewController = view
            router.dataStore = interactor
            
            return view
            
        case .favorite:
            let view = FavoriteViewController()
            let interactor = FavoriteInteractor(worker: FavoriteWorker(storage: storage))
            let router = FavoriteRouter()
            let presenter = FavoritePresenter()
            
            view.router = router
            view.interactor = interactor
            
            interactor.presenter = presenter
            presenter.viewController = view
            
            router.viewController = view
            router.dataStore = interactor
            
            return view
            
        case .patternDetails(let id):
            let view = PatternDetailsViewController()
            let interactor = PatternDetailsNewInteractor(patternId: id, worker: PatternDetailsWorker(storage: storage))
            let router = PatternDetailsNewRouter()
            let presenter = PatternDetailsPresenter()
            
            view.router = router
            view.interactor = interactor
            
            interactor.presenter = presenter
            presenter.viewController = view
            
            router.viewController = view
            
            return view
        case .patternCreation:
            let view = PatternCreationViewController()
            let interactor = PatternCreationNewInteractor(worker: PatternCreationWorker(dataStore: storage))
            let router = PatternCreationRouter()
            
            view.interactor = interactor
            view.router = router
            
            router.viewController = view
            
            return view
        case .sideMenu:
            let view = SideMenuViewController()
            let router = SideMenuRouter()
            
            view.router = router
            router.container = container
            
            return view
        case .oop:
            let view = OOPViewController()
            let router = EmptyRouter()
            
            router.container = container
            view.router = router
            
            return view
        case .solid:
            let view = SOLIDViewController()
            let router = EmptyRouter()
            
            router.container = container
            view.router = router
            
            return view
        case .architecturalPatterns:
            let view = ArchitecturalPatternsViewController()
            let router = EmptyRouter()
            
            router.container = container
            view.router = router
            
            return view
        }
    }
}
