//
//  PatternModel.swift
//  ArchitecturePatternsApp
//
//  Created by Олег Зуев on 25.08.2025.
//

import Foundation

struct Pattern {
    var name: String
    var description: String
    var image: String
    var viewCounter: Int = 0
    var isFavorite: Bool = true
    
    init() {
        self.name = "Прототип"
        self.description = "Прототип — это порождающий паттерн проектирования, который позволяет копировать объекты, не вдаваясь в подробности их реализации."
        self.image = "prototype"
    }
    
    
}
