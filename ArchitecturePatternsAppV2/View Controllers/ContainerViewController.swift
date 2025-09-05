//
//  ContainerViewController.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 02.09.2025.
//

import UIKit
import SnapKit

final class ContainerViewController: UIViewController, MainViewControllerDelegate {
    
    // MARK: - Properties
    
    private var mainController = MainViewController()
    private var sideMenuController: UIViewController!
    
    private var sideMenuIsShow = false
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMainVC()
        configureSideMenuVC()
    }
 
    // MARK: - Private methods
    private func configureMainVC() {
        mainController.delegate = self
        let navigationController = UINavigationController(rootViewController: mainController)
        view.addSubview(navigationController.view)
        addChild(navigationController)
    }
    
    private func configureSideMenuVC() {
        if sideMenuController == nil {
            sideMenuController = SideMenuViewController()
            view.insertSubview(sideMenuController.view, at: 1)
        }
    }
    
    private func showSideMenu(shouldMove: Bool) {
        if shouldMove {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                self.sideMenuController.view.frame.origin.x = 0
            }
        } else {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                self.sideMenuController.view.frame.origin.x = -self.sideMenuController.view.frame.width
            }
        }
    }
    // MARK: - MainViewControllerDelegate
    
    func toggleSideMenu() -> Bool {
        sideMenuIsShow.toggle()
        showSideMenu(shouldMove: sideMenuIsShow)
        return sideMenuIsShow
    }
}

