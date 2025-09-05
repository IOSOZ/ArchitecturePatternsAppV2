//
//  CatalogViewViewController.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 01.09.2025.
//

import UIKit
import SnapKit

final class SideMenuViewController: UIViewController {

    // MARK: - Properties
    private var OOPButton = UIView()
    private var designPatternsButton = UIView()
    private var architecturalPatternsButton = UIView()
    private var SOLIDButton = UIView()
    private var containerView = UIView()
    
    private var imageView = UIImageView()
    
    private var buttonVerticalStack = UIStackView()
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupStack()
        setupConstarints()
    }
    
  // MARK: - Stack Setup
    private func setupStack() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonVerticalStack.axis = .vertical
        buttonVerticalStack.spacing = 32
        buttonVerticalStack.alignment = .leading
        
        buttonVerticalStack.addArrangedSubview(OOPButton)
        buttonVerticalStack.addArrangedSubview(designPatternsButton)
        buttonVerticalStack.addArrangedSubview(architecturalPatternsButton)
        buttonVerticalStack.addArrangedSubview(SOLIDButton)
        
        view.addSubview(buttonVerticalStack)

    }
    // MARK: - UI Setup
    private func setupUI() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHight = UIScreen.main.bounds.height
        let sideMenuWidth =  Int(screenWidth - 70)
        view.frame = CGRect(x: -sideMenuWidth, y: 0, width: sideMenuWidth, height: Int(screenHight))
        
        view.backgroundColor = UIColor(named: "sideMenuColor")
        
        OOPButton = setupButtonContainerButton(with: "Приниципы ООП")
        designPatternsButton = setupButtonContainerButton(with: "Паттерны проектирования")
        architecturalPatternsButton = setupButtonContainerButton(with: "Архитектурные паттерны")
        SOLIDButton = setupButtonContainerButton(with: "Принципы SOLID")
      
    }
    // MARK: - Create custom button
    private func setupButtonContainerButton(with title: String) -> UIView {
        let containerView = UIView()
        let imageView = UIImageView(image: UIImage(named: "arrowIcon"))
        imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        imageView.contentMode = .center
        let button = UIButton()
        let buttonStack = UIStackView()
        
        let buttonTextStyle = NSMutableParagraphStyle()
        buttonTextStyle.minimumLineHeight = 20
        let buttonTextAttributes: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "SFPro-Regular", size: 15) ?? .systemFont(ofSize: 15, weight: .regular),
            .paragraphStyle : buttonTextStyle,
        ]
        button.setAttributedTitle(NSAttributedString(string: title, attributes: buttonTextAttributes), for: .normal)
        button.setTitleColor(.white, for: .normal)
    
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        buttonStack.axis = .horizontal
        buttonStack.distribution = .equalCentering
        buttonStack.spacing = 3
        
        imageView.contentMode = .scaleAspectFit
        
        buttonStack.addArrangedSubview(imageView)
        buttonStack.addArrangedSubview(button)
        
        containerView.addSubview(buttonStack)
        buttonStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(4)
        }
        return containerView
    }
    
    // MARK: - Constraints Setup
    private func setupConstarints() {
        buttonVerticalStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(view.snp.centerY)

        }
        
    }

}
