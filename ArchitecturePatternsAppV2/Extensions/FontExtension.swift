//
//  FontExtension.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 13.10.2025.
//

import Foundation
import UIKit

enum SFPro {
    case Semibold(withSize: UIFont.FontSize)
    case Regular(withSize: UIFont.FontSize)
}

extension UIFont {
    /// FontSize
    enum FontSize: CGFloat {
        /// 24
        case xLarge = 24
        /// 20
        case large = 20
        /// 16
        case medium = 16
        ///12
        case small = 12
        ///8
        case xSmall = 8
    }
    
    static func sfProSemibold(with size: FontSize) -> UIFont {
        UIFont(name: "SFPro-Semibold", size: size.rawValue) ?? .systemFont(ofSize: size.rawValue, weight: .semibold)
    }
    
    static func sfProRegular(with size: FontSize) -> UIFont {
        UIFont(name: "SFPro-Regular", size: size.rawValue) ?? .systemFont(ofSize: size.rawValue, weight: .regular)
    }
}


