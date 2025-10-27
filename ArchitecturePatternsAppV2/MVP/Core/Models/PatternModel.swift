//
//  PatternModel.swift
//  ArchitecturePatternsApp
//
//  Created by Олег Зуев on 25.08.2025.
//

import Foundation
#warning("Избавиться от UIKit")
import UIKit

enum PatternType: String, CaseIterable {
    case creational
    case structural
    case behavioral
    
    var title: String {
        switch self {
        case .creational:
            return "ПОРОЖДАЮЩИЕ"
        case .structural:
            return "СТРУКТУРНЫЕ"
        case .behavioral:
            return "ПОВЕДЕНЧЕСКИЕ"
        }
    }
}

struct Pattern {
    let id = UUID()
    var type: PatternType
    var name: String
    var description: String?
    var image: UIImage?
    var viewCounter: Int = 0
    var isFavorite: Bool = false
}



