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

    convenience init(title: String, image: UIImage) {
        self.init(frame: .zero)
        setupButton(title: title, image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SideMenuButton Extension
private extension SideMenuButton {
    func setupButton(title: String, image: UIImage) {
        
        var config = UIButton.Configuration.plain()
        config.imagePadding = 5
        config.imagePlacement = .leading
        config.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10)
        self.configuration = config
        
        setImage(image, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "SFPro-Regular", size: 15)
        setTitle(title, for: .normal)
    }
}

