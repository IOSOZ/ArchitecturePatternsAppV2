//
//  PatternDetailsProtocol.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 22.10.2025.
//

import Foundation
#warning("Избавиться от UIKit")
import UIKit

protocol PatternDetailsViewProtocol: AnyObject {
    func display(pattern: Pattern)
    func editedFields() -> (name: String, description: String?, image: UIImage?, type: PatternType)?
}

protocol PatternDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapSaveButton()
}
