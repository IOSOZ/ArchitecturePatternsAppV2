//
//  PatternCreationProtocol.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 23.10.2025.
//

import Foundation
#warning("Избавиться от UIKit")
import UIKit

protocol PatternCreationViewProtocol {
    func fieldFields() -> (name: String, description: String?, image: UIImage?, type: PatternType)?
}

protocol PatternCreationPresenterProtocol {
    func didTapSaveButton()
}
