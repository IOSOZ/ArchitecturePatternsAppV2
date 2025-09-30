//
//  ContainerViewController.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 02.09.2025.
//

import UIKit
import SnapKit


final class ContainerViewController: UIViewController {
    
    // MARK: - Properties
    
    private var mainController = MainViewController()
    private var sideMenuController: UIViewController!
    
    private var tapGesture: UITapGestureRecognizer!
    private var sideMenuIsShow = false

    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
 
    // MARK: - View Setup
    private func setupView() {
        configureMainVC()
        configureSideMenuVC()
        setupGesture()
    }
   
    // MARK: - MainViewControllerDelegate
    func toggleSideMenu() -> Bool {
        sideMenuIsShow.toggle()
        showSideMenu(shouldMove: sideMenuIsShow)
        return sideMenuIsShow
    }
}

// MARK: - ContainerViewController Extension
extension ContainerViewController {
    private func configureMainVC() {
        mainController.container = self
        let navigationController = UINavigationController(rootViewController: mainController)
        view.addSubview(navigationController.view)
        addChild(navigationController)
    }
    
    private func configureSideMenuVC() {
        if sideMenuController == nil {
            sideMenuController = SideMenuViewController()
            addChild(sideMenuController)
            view.insertSubview(sideMenuController.view, at: 1)
        }
    }
    
    private func setupGesture() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOutSideSideMenu))
        tapGesture.isEnabled = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapOutSideSideMenu(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: view)
        if sideMenuIsShow && !sideMenuController.view.frame.contains(tapLocation) {
            sideMenuIsShow.toggle()
            showSideMenu(shouldMove: sideMenuIsShow)
            mainController.rotateRightButton(isOpen: sideMenuIsShow)
        }
    }
    
    private func showSideMenu(shouldMove: Bool) {
        if shouldMove {
            tapGesture.isEnabled = true
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                self.sideMenuController.view.frame.origin.x = 0
            }
        } else {
            tapGesture.isEnabled = false
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                self.sideMenuController.view.frame.origin.x = -self.sideMenuController.view.frame.width
            }
        }
    }
}



