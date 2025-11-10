//
//  PatternDetailsViewModel.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 10.11.2025.
//

import Foundation


struct PatternDetailsViewModel {
    let name: String
    let description: String?
    let typeTitle: String
    let isFavorite: Bool
    let imageData: Data?
}

struct PatternDraft {
    let id: UUID
    var name: String
    var description: String?
    var type: PatternType
    var isFavorite: Bool
    var imageData: Data?
}
