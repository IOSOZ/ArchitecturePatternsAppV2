//
//  ContainerViewController.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 02.09.2025.
//

import UIKit
import SnapKit

protocol ContainerRouting: AnyObject {
    func setRoot(_ vc: UIViewController, closeMenu: Bool)
    func toggleSideMenu(_ open: Bool?)
}

final class ContainerViewController: RootViewController {
    
    // MARK: - Properties
    private var currentController: BaseContentViewController!
    private var sideMenuController: SideMenuViewController!
    private(set) var navController: UINavigationController!
    
    private var tapGesture: UITapGestureRecognizer!
    private var sideMenuIsShow = false
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func embedd(_ nav: UINavigationController, _ sideMenu: RootViewController) {
        
        self.currentController = nav.viewControllers.first as? BaseContentViewController
        self.sideMenuController = sideMenu as? SideMenuViewController
        self.navController = nav
        
        
        addChild(nav)
        nav.didMove(toParent: self)
        view.addSubview(nav.view)
        
        addChild(sideMenu)
        sideMenu.didMove(toParent: self)
        view.insertSubview(sideMenuController.view, aboveSubview: nav.view)
        view.bringSubviewToFront(sideMenu.view)
        
        nav.navigationBar.tintColor = .black
        
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
//        configureSideMenuVC()
        setupGesture()
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
        currentController.rotateRightButton(isOpen: shouldMove)
    }
}

// MARK: - ContainerManger
extension ContainerViewController: ContainerRouting {
    // MARK: - Change Current View Controller
    func setRoot(_ vc: UIViewController, closeMenu: Bool) {
        navController.setViewControllers([vc], animated: false)
        currentController = vc as? BaseContentViewController
        if closeMenu { sideMenuIsShow = false; showSideMenu(shouldMove: false) }
    }
    
    // MARK: - Toggle Side Menu
    func toggleSideMenu(_ open: Bool?) {
        sideMenuIsShow = open ?? !sideMenuIsShow
        showSideMenu(shouldMove: sideMenuIsShow)
        currentController?.rotateRightButton(isOpen: sideMenuIsShow)
    }
}
