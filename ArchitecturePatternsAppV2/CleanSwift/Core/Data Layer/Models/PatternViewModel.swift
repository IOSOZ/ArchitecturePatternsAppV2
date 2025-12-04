//
//  PatternViewModel.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 03.12.2025.
//

import Foundation
import UIKit

struct PatternViewModel {
    let id: UUID
    var type: PatternType
    var name: String
    var description: String?
    var image: UIImage
    var viewCounter: Int
    var isFavorite: Bool
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
        }
        else if let seed = DataStore.shared.SeedPatterns.first(where: { $0.name == domain.name }),
                let imageName = seed.imageName,
                let uiImage = UIImage(named: imageName) {
            self.image = uiImage
        }
        else {
            self.image = UIImage(resource: .no)
        }
    }
    
}
