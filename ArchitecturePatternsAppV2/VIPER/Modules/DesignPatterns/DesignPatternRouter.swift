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
    func performChangeBaseViewController()
    func openCreationMenu()
}


final class DesignPatternRouter: DesignPatternRouterInput {
   
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func openPatternDetails(id: UUID) {
        
    }
    
    func performChangeBaseViewController() {
        
    }
    
    func openCreationMenu() {
        
    }
}
