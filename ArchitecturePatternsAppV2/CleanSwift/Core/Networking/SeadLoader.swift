//
//  SeadLoader.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 03.12.2025.
//

import Foundation


final class SeedLoader {
    private let remoteStore = PatternRemoteRealtimeStore()
    
    func resetRemoteToSeeds(completion: (() -> Void)? = nil) {
        
        remoteStore.clearAll() { [weak self] in
            guard let self else { return }
            
            self.uploadAllSeeds {
                print(" Remote DB reset to seed state")
                completion?()
            }
        }
    }
    private func uploadAllSeeds(completion: (() -> Void)? = nil) {
        let seeds = DataStore.shared.SeedPatterns
        
        for seed in seeds {
            
            let model = PatternModel(
                id: UUID(),
                type: seed.type,
                name: seed.name,
                description: seed.description,
                image: nil,
                viewCounter: 0,
                isFavorite: false
            )
            
            remoteStore.save(model) {_ in
                
            }
        }
    }
}
