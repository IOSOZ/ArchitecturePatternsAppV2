//
//  SideMenuViewRouter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 11.11.2025.
//

import Foundation


protocol SideMenuRouterInput: AnyObject {
    func setMainViewController(with module: MenuItem)
}

final class SideMenuRouter: SideMenuRouterInput {
    
    weak var container: ContainerRouting?
    
    func setMainViewController(with module: MenuItem) {
        let newVc = createController(for: module)
        container?.setRoot(newVc, closeMenu: true)
    }
    
    private func createController(for item: MenuItem) -> BaseContentViewController {
        let controller: RootViewController
        switch item {
        case .oop:
            controller = GlobalBuilder.create(.oop)
        case .designPatterns:
            controller = GlobalBuilder.create(.designPatterns)
        case .architecturalPatterns:
            controller = GlobalBuilder.create(.architecturalPatterns)
        case .solid:
            controller = GlobalBuilder.create(.solid)
        case .favorite:
            controller = GlobalBuilder.create(.favorite) 
        }
        
        return controller as! BaseContentViewController
    }
}
