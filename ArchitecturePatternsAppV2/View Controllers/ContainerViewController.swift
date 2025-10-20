//
//  ContainerViewController.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 02.09.2025.
//

import UIKit
import SnapKit

// MARK: - ContainerManager Protocol
protocol ContainerManger: AnyObject {
    func performControllerChange(with menuItem: MenuItem)
    func toggleSideMenu() -> Bool
}

final class ContainerViewController: RootViewController {
    
    // MARK: - Properties
    
    private var currentController: BaseContentViewController!
    private var sideMenuController: SideMenuViewController!
    private var navController: UINavigationController?
    
    private var tapGesture: UITapGestureRecognizer!
    private var sideMenuIsShow = false
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - OBJC Methods
    @objc func didTapOutSideSideMenu(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: view)
        if sideMenuIsShow && !sideMenuController.view.frame.contains(tapLocation) {
            sideMenuIsShow.toggle()
            showSideMenu(shouldMove: sideMenuIsShow)
            
            if let currentVC = currentController {
                currentVC.rotateRightButton(isOpen: sideMenuIsShow)
            }
        }
    }
}

// MARK: - ContainerViewController Extension
private extension ContainerViewController {
    
    // MARK: - View Setup
    private func setupView() {
        configureMainVC()
        configureSideMenuVC()
        setupGesture()
    }
    
    // MARK: - Configure Main VC
    func configureMainVC() {
        let mainVC = DesignPatternsViewController()
        mainVC.container = self
        currentController = mainVC
        
        navController = UINavigationController(rootViewController: currentController)
        
        configureNavigationController()
    }
   
    // MARK: - Configure Navigation Controller
    func configureNavigationController() {
        if let navController {
            addChild(navController)
            view.addSubview(navController.view)
            navController.didMove(toParent: self)
            
            navController.navigationBar.tintColor = .black
        }
    }
    
    // MARK: - Configure Side VC
    func configureSideMenuVC() {
        if sideMenuController == nil {
            sideMenuController = SideMenuViewController()
            sideMenuController.containerManager = self
            addChild(sideMenuController)
            view.insertSubview(sideMenuController.view, at: 1)
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
            controller = DesignPatternsViewController()
        case .architecturalPatterns:
            controller = ArchitecturalPatternsViewController()
        case .solid:
            controller = SOLIDViewController()
        case .favorite:
            controller = FavoriteViewController()
        }
        
        controller.container = self
        
        return controller
    }
}

// MARK: - ContainerManger
extension ContainerViewController: ContainerManger {

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
