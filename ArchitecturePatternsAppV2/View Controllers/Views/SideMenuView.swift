//
//  SideMenuView.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 02.09.2025.
//

import UIKit
import SnapKit

class SideMenuView: UIView {
    private var menuWidth: CGFloat {
        UIScreen.main.bounds.width * 0.6
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurateInitialFrame(in view: UIView) {
        frame = CGRect(x: menuWidth, y: 0, width: menuWidth, height: UIScreen.main.bounds.height)
        view.addSubview(self)
    }
    
    func animate(to x: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.frame.origin.x = x
        }
    }
    
}
