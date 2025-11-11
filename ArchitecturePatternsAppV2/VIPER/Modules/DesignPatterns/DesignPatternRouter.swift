//
//  DesignPatternRouter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 05.11.2025.
//

import Foundation
import UIKit

protocol DesignPatternRouterInput {
    func openPatternDetails(id: UUID)
    func openCreationMenu()
    func toggleSideMenu()
    func performChangeBaseViewController()
    
}


final class DesignPatternRouter: DesignPatternRouterInput {
   
    weak var container: ContainerDelegate?
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func openPatternDetails(id: UUID) {
        let vc = GlobalBuilder.create(.patternDetails(id))
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func toggleSideMenu() {
        container?.toggleSideMenu()
    }
    
    func performChangeBaseViewController() {
        
    }
    
    
    func openCreationMenu() {
        let vc = GlobalBuilder.create(.patternCreation)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
