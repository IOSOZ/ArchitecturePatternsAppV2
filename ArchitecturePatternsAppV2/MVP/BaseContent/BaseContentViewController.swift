//
//  BaseContentViewController.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 04.10.2025.
//

import UIKit

class BaseContentViewController: RootViewController {
    
    // MARK: - ContainerViewController Delgate
    weak var container: ContainerViewController?
    
    var basePresenter: BaseContentPresenterProtocol?
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        print("\(String(describing: self.basePresenter))")
    }

    // MARK: - Public Methods
    func rotateRightButton(isOpen: Bool) {
        guard let customView = navigationItem.rightBarButtonItem?.customView else { return }
        
        let targetAngle: CGFloat = isOpen ? -.pi / 2 : 0
        
        UIView.animate(withDuration: 0.3) {
            customView.transform = CGAffineTransform(rotationAngle: targetAngle)
        }
    }
    
    // MARK: - Objc methods
    @objc func didTapLeftButton() {
        // Реализую в след раз, не успеваю( 
    }
    
    @objc private func didTapRightButton() {
        basePresenter?.didTapRightBarButton()
    }
}

private extension BaseContentViewController {
    // MARK: - View Setup
    func setupView() {
        setUpNavigationBar()
    }
    
    // MARK: - NavBar Setup
    func setUpNavigationBar() {
        self.navigationItem.leftBarButtonItem = createCustomBarButton(
            with: .addIconC,
            action: #selector(didTapLeftButton),
            tintColor: .black
        )
        self.navigationItem.rightBarButtonItem = createCustomBarButton(
            with: .burgerIcon,
            action:  #selector(didTapRightButton)
        )
        self.navigationItem.title = "Паттерны проектирования"
        
    }
    
    // MARK: - Create Bar Button
    func createCustomBarButton(with image: UIImage, action: Selector, tintColor: UIColor? = nil) -> UIBarButtonItem {
        let customButton = UIButton(type: .system)
        customButton.setImage(image, for: .normal)
        customButton.tintColor = tintColor
        customButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        customButton.addTarget(self, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: customButton)
    }
}


extension BaseContentViewController: BaseContentViewProtocol {
    func showSideMenu() {
        if let isShown = container?.toggleSideMenu() {
            rotateRightButton(isOpen: isShown)
        }
    }
}
