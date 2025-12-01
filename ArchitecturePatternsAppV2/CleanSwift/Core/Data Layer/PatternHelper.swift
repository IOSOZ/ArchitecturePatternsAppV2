//
//  PatternExtention.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 26.11.2025.
//

import Foundation
import CoreData
import UIKit

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

extension PatternViewModel {
    init(domain: PatternModel) {
        self.id = domain.id
        self.type = domain.type
        self.name = domain.name
        self.description = domain.description
        self.viewCounter = domain.viewCounter
        self.isFavorite = domain.isFavorite
        
        if let data = domain.image, let uiImage = UIImage(data: data) {
            self.image = uiImage
        } else {
            self.image = UIImage(resource: .no)
        }
    }
}

extension Pattern {
    func apply(from model: PatternModel) {
        id = model.id
        type = model.type.raw
        name = model.name
        commentary = model.description
        image = model.image
        viewCounter = Int16(model.viewCounter)
        isFavorite = model.isFavorite
    }
}



