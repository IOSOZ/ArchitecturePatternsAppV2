//
//  StorageManager.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 21.10.2025.
//

import Foundation
import UIKit
import CoreData

protocol PatternStorageProtocol {
    func getAllPatterns() throws -> [PatternModel]
    func getFavoritePatterns() throws -> [PatternModel]
    func addNewPattern(_ pattern: PatternModel) throws
    func updatePattern(_ pattern: PatternModel) throws
    func incrementViewCounterFor(pattern : PatternModel) throws
    func getPatternByID(_ id: UUID) throws -> PatternModel?
    func removePattern(_ pattern: PatternModel ) throws
}

final class StorageManager {
    
    // MARK: - Core Data stack
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ArchitecturePatternsAppV2")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private var viewContext: NSManagedObjectContext { persistentContainer.viewContext }
    private let dataStore: DataStore
    
    
    init(dataStore: DataStore = .shared) {
        self.dataStore = dataStore
        ensureInitialDataIfNeeded()
    }
    
    func saveIfNeeded() {
        guard viewContext.hasChanges else { return }
        do {
            try viewContext.save()
        } catch {
            print("CoreData save error:", error)
        }
    }
}

// MARK: - Private Data Methods
private extension StorageManager {
   func  ensureInitialDataIfNeeded() {
        let didSeed = UserDefaults.standard.bool(forKey: "didSeed")
        guard didSeed == false else { return }
        
        if fetchCount() == 0 {
            insertInitialPatterns()
            saveIfNeeded()

        }
       UserDefaults.standard.set(true, forKey: "didSeed")
    }
    
    func fetchCount() -> Int {
        let request: NSFetchRequest<Pattern> = Pattern.fetchRequest()
        return (try? viewContext.count(for: request)) ?? 0
    }
    
    func insertInitialPatterns() {
        for (index, item) in dataStore.SeedPatterns.enumerated() {
            let entity = Pattern(context: viewContext)
            entity.id = UUID()
            entity.viewCounter = 0
            entity.isFavorite = false
            
            entity.commentary = item.description
            entity.name = item.name
            entity.type = item.type.raw
            
            if let imageName = item.imageName, let uiImage = UIImage(named: imageName), let data = uiImage.pngData() {
                entity.image = data
            } else {
                entity.image = nil
            }
        }
    }
}

// MARK: - Private Mapping Methods
private extension StorageManager {
    func map(_ entity: Pattern) -> PatternModel {
        return PatternModel(
            id: entity.id,
            type: PatternType(raw: entity.type) ?? .creational,
            name: entity.name,
            description: entity.commentary,
            image: entity.image,
            viewCounter: Int(entity.viewCounter),
            isFavorite: entity.isFavorite
        )
    }
    
    func apply(_ model: PatternModel, to entity: Pattern) {
        entity.id = model.id
        entity.type = model.type.raw
        entity.name = model.name
        entity.commentary = model.description
        entity.image = model.image
        entity.viewCounter = Int16(model.viewCounter)
        entity.isFavorite = model.isFavorite
    }
}

// MARK: - Work With Data
extension StorageManager: PatternStorageProtocol {
    func getAllPatterns() throws -> [PatternModel] {
        let request: NSFetchRequest<Pattern> = Pattern.fetchRequest()
        let entities = try viewContext.fetch(request)
        return entities.map(map(_:))
    }
    
    func getFavoritePatterns() throws -> [PatternModel] {
        let request: NSFetchRequest<Pattern> = Pattern.fetchRequest()
        request.predicate = NSPredicate(format: "isFavorite == YES")
        
        let entities = try viewContext.fetch(request)
        return entities.map(map(_:))
    }
    
    func addNewPattern(_ pattern: PatternModel) throws {
        let entity = Pattern(context: viewContext)
        apply(pattern, to: entity)
        saveIfNeeded()
    }
    
    func updatePattern(_ pattern: PatternModel) throws {
        let request: NSFetchRequest<Pattern> = Pattern.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", pattern.id as CVarArg)
        request.fetchLimit = 1
        
        let result = try viewContext.fetch(request)
        guard let entity = result.first else { return }
        
        apply(pattern, to: entity)
        saveIfNeeded()
    }
    
    func incrementViewCounterFor(pattern: PatternModel) throws {
        let request: NSFetchRequest<Pattern> = Pattern.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", pattern.id as CVarArg)
        request.fetchLimit = 1
                
        let result = try viewContext.fetch(request)
        guard let entity = result.first else { return }
                
        entity.viewCounter += 1
        saveIfNeeded()
    }
    
    func getPatternByID(_ id: UUID) throws -> PatternModel? {
        let request: NSFetchRequest<Pattern> = Pattern.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1
        
        let entities = try viewContext.fetch(request)
        guard let entity = entities.first else { return nil }
        return map(entity)
    }
    
    func removePattern(_ pattern: PatternModel) throws {
        let request: NSFetchRequest<Pattern> = Pattern.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", pattern.id as CVarArg)
        request.fetchLimit = 1
        
        let result = try viewContext.fetch(request)
        guard let entity = result.first else { return }
        
        viewContext.delete(entity)
        saveIfNeeded()
    }
}
