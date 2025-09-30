//
//  SideMenuButton.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 24.09.2025.
//

import Foundation
import SnapKit
import UIKit

final class SideMenuButton: UIButton {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        setupButton(title: title)
        setupConstraints()
    }
    
    convenience init(title: String, image: UIImage) {
        self.init(frame: .zero)
        setupCustomButtonWith(title: title, image: image)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SideMenuButton Extension
private extension SideMenuButton {
    func setupButton(title: String) {
        setImage(UIImage(resource: .arrowIcon), for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "SFPro-Regular", size: 15)
        setTitle(title, for: .normal)
    }
    
    func setupCustomButtonWith(title: String, image: UIImage) {
        setImage(image, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "SFPro-Regular", size: 15)
        setTitle(title, for: .normal)
    }
    
    // MARK: - Constraints Setup
    func setupConstraints() {
        self.imageView?.snp.makeConstraints { make in
            make.size.equalTo(14)
            make.trailing.equalTo(titleLabel!.snp.leading).offset(-5)
            make.centerY.equalTo(titleLabel!.snp.centerY).offset(20)
        }
    }
}

