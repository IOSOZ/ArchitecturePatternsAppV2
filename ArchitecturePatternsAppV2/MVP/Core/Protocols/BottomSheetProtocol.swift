//
//  BottomSheetProtocol.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 22.10.2025.
//

import Foundation

protocol BottomSheetDelegate: AnyObject {
    func updatePatternType(_ patternType: PatternType)
}
