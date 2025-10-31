//
//  ContainerViewController.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 02.09.2025.
//

import UIKit
import SnapKit


final class ContainerViewController: RootViewController {
    
    // MARK: - MVP Dependency Inversion
    var deps: ModuleDeps!
    
    // MARK: - Properties
    private var currentController: BaseContentViewController!
    private var sideMenuController: SideMenuViewController!
    private(set) var navController: UINavigationController?
    
    private var tapGesture: UITapGestureRecognizer!
    private var sideMenuIsShow = false
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func embedd(_ nav: UINavigationController) {
        self.navController = nav
        addChild(nav)
        view.addSubview(nav.view)
        nav.didMove(toParent: self)
        
        nav.navigationBar.tintColor = .black
        
        self.currentController = nav.viewControllers.first as? BaseContentViewController
        
        if let sideMenuView = sideMenuController?.view {
            view.bringSubviewToFront(sideMenuView)
        }
    }

    
    // MARK: - OBJC Methods
    @objc func didTapOutSideSideMenu(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: view)
        if sideMenuIsShow && !sideMenuController.view.frame.contains(tapLocation) {
            sideMenuIsShow.toggle()
            showSideMenu(shouldMove: sideMenuIsShow)
            currentController?.rotateRightButton(isOpen: sideMenuIsShow)
        }
    }
}

// MARK: - ContainerViewController Extension
private extension ContainerViewController {
    
    // MARK: - View Setup
    private func setupView() {
        configureSideMenuVC()
        setupGesture()
    }
    
    // MARK: - Configure Side VC
    func configureSideMenuVC() {
        if sideMenuController == nil {
            sideMenuController = SideMenuViewController()
            sideMenuController.deleagate = self
            addChild(sideMenuController)
            
            if let nav = navController {
                view.insertSubview(sideMenuController.view, aboveSubview: nav.view)
            } else {
                view.addSubview(sideMenuController.view)
            }
            sideMenuController.didMove(toParent: self)
        }
    }
    
    // MARK: - Gesture Setup
    func setupGesture() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOutSideSideMenu))
        tapGesture.isEnabled = false
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Side Menu Animate
    func showSideMenu(shouldMove: Bool) {
        tapGesture.isEnabled = shouldMove ? true : false
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            options: .curveEaseOut) {
                self.sideMenuController.view.frame.origin.x = shouldMove ? 0 : -self.sideMenuController.view.frame.width
            }
    }
    
    // MARK: - Controller Creation
    func createController(for item: MenuItem) -> BaseContentViewController {
        let controller: BaseContentViewController
        switch item {
        case .oop:
            controller = OOPViewController()
        case .designPatterns:
            controller = GlobalBuilder.designPatterns(deps)
        case .architecturalPatterns:
            controller = ArchitecturalPatternsViewController()
        case .solid:
            controller = SOLIDViewController()
        case .favorite:
            controller = GlobalBuilder.favorite(deps)
        }
        
        controller.container = self
        
        return controller
    }
}

// MARK: - ContainerManger
extension ContainerViewController: ContainerDelegate {

    // MARK: - Change Current View Controller
    func performControllerChange(with menuItem: MenuItem) {
        let newController = createController(for: menuItem)
        if let navController {
            navController.setViewControllers([newController], animated: false)
            currentController = newController
        }
        sideMenuIsShow = false
        showSideMenu(shouldMove: false)
        
        if let mainVC = newController as? DesignPatternsViewController {
            mainVC.rotateRightButton(isOpen: false)
        }
    }
    
    // MARK: - Toggle Side Menu
    func toggleSideMenu() -> Bool {
        sideMenuIsShow.toggle()
        showSideMenu(shouldMove: sideMenuIsShow)
        return sideMenuIsShow
    }
}
