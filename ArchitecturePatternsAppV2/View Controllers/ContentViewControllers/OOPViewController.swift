//
//  OOPViewController.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 04.10.2025.
//

import UIKit

class OOPViewController: BaseContentViewController {
    
    let technicalWorkImage = UIImageView(image: UIImage(resource: .technicalWork))
    let textLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Принципы ООП"
        
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(technicalWorkImage)
        view.addSubview(textLabel)
        
        textLabel.font = UIFont(name: "SFPro-Regular", size: 20)
        textLabel.text = "Ведутся технические работы"
        textLabel.shadowOffset = CGSize(width: 3, height: 3)
        textLabel.shadowColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
        
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
