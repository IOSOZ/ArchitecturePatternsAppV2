//
//  PatternTableViewProtocol.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 23.10.2025.
//

import Foundation

protocol PatternTableViewCellDelegate: AnyObject {
    func didTapFavorite(on cell: PatternTableViewCell)
}
