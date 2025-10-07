//
//  CatalogViewViewController.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 01.09.2025.
//

import SnapKit
import UIKit

enum MenuItem {
    case oop
    case designPatterns
    case architecturalPatterns
    case solid
    case favorite
}

final class SideMenuViewController: UIViewController {

    // MARK: - UI Properties
    private var OOPButton = UIControl()
    private var designPatternsButton = UIControl()
    private var architecturalPatternsButton = UIControl()
    private var SOLIDButton = UIControl()
    private var favoriteButton = UIControl()

    private var buttonVerticalStack = UIStackView()
    
    weak var containerManager: ContainerManger?

    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Objc methods
    @objc func didTapOOPButton() {
        let oopVC = OOPViewController()
        containerManager?.changeCurrentVC(to: oopVC)
    }
    
    @objc func didTapDesignPatternsButton() {
        let designPatternsVC = ArchitecturalPatternsViewController()
        containerManager?.changeCurrentVC(to: designPatternsVC)
    }
    
    @objc func didTapArchitecturalPatternsButton() {
        let architecturalPatternsVC = DesignPatternsViewController()
        containerManager?.changeCurrentVC(to: architecturalPatternsVC)
    }
    
    @objc func didTapSOLIDButton() {
        let solidVC = SOLIDViewController()
        containerManager?.changeCurrentVC(to: solidVC)
    }
    
    @objc func didTapFavoriteButton() {
        let favoriteVC = FavoriteViewController()
        containerManager?.changeCurrentVC(to: favoriteVC)
    }
}

// MARK: - SideMenuViewController Extension
private extension SideMenuViewController {
    // MARK: - View Setup
    func setupView() {
        setupUI()
        addViews()
        setupStack()
        setupConstraints()
    } 
    
    // MARK: - UI Setup
    func setupUI() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHight = UIScreen.main.bounds.height
        let sideMenuWidth = Int(screenWidth - 70)
        view.frame = CGRect(x: -sideMenuWidth, y: 0, width: sideMenuWidth, height: Int(screenHight))
        
        view.backgroundColor = UIColor(named: "sideMenuColor")
        
        OOPButton = SideMenuButton(title: "Приниципы ООП", image: .arrowIcon)
        designPatternsButton = SideMenuButton(title: "Паттерны проектирования", image: .arrowIcon)
        architecturalPatternsButton = SideMenuButton(title: "Архитектурные паттерны", image: .arrowIcon)
        SOLIDButton = SideMenuButton(title: "Принципы SOLID", image: .arrowIcon)
        favoriteButton = SideMenuButton(title: "Избранное", image: .heart)
        
        OOPButton.addTarget(self, action: #selector(didTapOOPButton), for: .touchUpInside)
        designPatternsButton.addTarget(self, action: #selector(didTapDesignPatternsButton), for: .touchUpInside)
        architecturalPatternsButton.addTarget(self, action: #selector(didTapArchitecturalPatternsButton), for: .touchUpInside)
        SOLIDButton.addTarget(self, action: #selector(didTapSOLIDButton), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    }
    
    // MARK: - Add View
    func addViews() {
        buttonVerticalStack.addArrangedSubview(OOPButton)
        buttonVerticalStack.addArrangedSubview(designPatternsButton)
        buttonVerticalStack.addArrangedSubview(architecturalPatternsButton)
        buttonVerticalStack.addArrangedSubview(SOLIDButton)
        
        view.addSubview(buttonVerticalStack)
        view.addSubview(favoriteButton)
    }
    
    // MARK: - Stack Setup
    func setupStack() {
        buttonVerticalStack.axis = .vertical
        buttonVerticalStack.spacing = 40
        buttonVerticalStack.alignment = .leading
    }
    
    // MARK: - Constraints Setup
    func setupConstraints() {
        buttonVerticalStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.leading.equalTo(buttonVerticalStack)
            make.bottom.equalToSuperview().inset(100)
        }
    }
}
