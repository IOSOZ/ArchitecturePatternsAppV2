//
//  SOLIDViewController.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 04.10.2025.
//

import UIKit

class SOLIDViewController: BaseContentViewController {
    
// MARK: - UI Properties
    let technicalWorkImage = UIImageView(image: UIImage(resource: .technicalWork))
    let textLabel = UILabel()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}
    
// MARK: - SOLIDViewController Extension
private extension SOLIDViewController {
    
    // MARK: - Setup View
    func setupView() {
        setupUI()
        addViews()
        setupConstraints()
    }
    
    // MARK: - Setup UI
    func setupUI() {
        view.backgroundColor = .white
        title = "Принципы SOLID"
        
        textLabel.font = UIFont(name: "SFPro-Regular", size: 20)
        textLabel.text = "Ведутся технические работы"
        textLabel.shadowOffset = CGSize(width: 3, height: 3)
        textLabel.shadowColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
    }
    
    // MARK: - Add Views
    func addViews() {
        view.addSubview(technicalWorkImage)
        view.addSubview(textLabel)
    }
    
    // MARK: - Setup Constraints
    func setupConstraints() {
        technicalWorkImage.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(technicalWorkImage.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
    }
}
