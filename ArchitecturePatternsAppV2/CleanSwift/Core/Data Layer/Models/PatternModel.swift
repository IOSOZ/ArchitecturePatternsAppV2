//
//  PatternModel.swift
//  ArchitecturePatternsApp
//
//  Created by Олег Зуев on 25.08.2025.
//

import Foundation
import FirebaseDatabase

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

extension PatternModel {
    init(entity: Pattern) {
        self.id = entity.id
        self.type = PatternType(raw: entity.type) ?? .creational
        self.name = entity.name
        self.description = entity.commentary
        self.image = entity.image
        self.viewCounter = Int(entity.viewCounter)
        self.isFavorite = entity.isFavorite
    }
    
    init(viewModel: PatternViewModel) {
        self.id = viewModel.id
        self.type = viewModel.type
        self.name = viewModel.name
        self.description = viewModel.description
        self.isFavorite = viewModel.isFavorite
        self.viewCounter = viewModel.viewCounter
        self.image = viewModel.image.pngData()
    }
}

extension PatternModel {
    var rtdbDictionary: [String: Any] {
        [
            "id": id.uuidString,
            "type": type.raw,
            "name": name,
            "description": description ?? "",
            "viewCounter": viewCounter,
            "isFavorite": isFavorite,
            "image": image?.description ?? ""
        ]
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let dict = snapshot.value as? [String: Any],
            let idString = dict["id"] as? String,
            let id = UUID(uuidString: idString),
            let typeString = dict["type"] as? String,
            let type = PatternType(raw: typeString),
            let name = dict["name"] as? String
        else { return nil }
          
        self.id = id
        self.type = type
        self.name = name
        self.description = dict["description"] as? String
        self.image = nil
        self.viewCounter = dict["viewCounter"] as? Int ?? 0
        self.isFavorite = dict["isFavorite"] as? Bool ?? false
    
    }
}





