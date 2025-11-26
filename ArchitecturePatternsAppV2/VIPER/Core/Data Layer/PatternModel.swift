//
//  PatternModel.swift
//  ArchitecturePatternsApp
//
//  Created by Олег Зуев on 25.08.2025.
//

import Foundation

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

extension PatternType {
    init?(raw: String) {
        self = PatternType(rawValue: raw) ?? .creational
    }
    
    var raw: String { rawValue }
}

struct PatternModel {
    let id: UUID
    var type: PatternType
    var name: String
    var description: String?
    var image: Data?
    var viewCounter: Int
    var isFavorite: Bool
}




