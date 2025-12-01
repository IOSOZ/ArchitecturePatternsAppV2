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
    func addNewPattern(_ model: PatternModel) throws
    func updatePattern(_ model: PatternModel) throws
    func incrementViewCounterFor(model: PatternModel) throws
    func getPatternByID(_ id: UUID) throws -> PatternModel?
    func removePattern(_ model: PatternModel) throws
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


// MARK: - Work With Data
extension StorageManager: PatternStorageProtocol {
   
    
    func getAllPatterns() throws -> [PatternModel] {
        let request: NSFetchRequest<Pattern> = Pattern.fetchRequest()
        let entities = try viewContext.fetch(request)
        
        return entities.map { PatternModel(entity: $0) }
    }
    
    func getFavoritePatterns() throws -> [PatternModel] {
        let request: NSFetchRequest<Pattern> = Pattern.fetchRequest()
        request.predicate = NSPredicate(format: "isFavorite == YES")
        
        let entities = try viewContext.fetch(request)
        return entities.map { PatternModel(entity: $0) }
    }
    
    func addNewPattern(_ model: PatternModel) throws {
        let entity = Pattern(context: viewContext)
        entity.apply(from: model)
        saveIfNeeded()
    }
    
    func updatePattern(_ model: PatternModel) throws {
        let request: NSFetchRequest<Pattern> = Pattern.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", model.id as CVarArg)
        request.fetchLimit = 1
        
        let result = try viewContext.fetch(request)
        guard let entity = result.first else { return }
        
        entity.apply(from: model)
        saveIfNeeded()
    }
    
    func incrementViewCounterFor(model: PatternModel) throws {
        let request: NSFetchRequest<Pattern> = Pattern.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", model.id as CVarArg)
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
        return PatternModel(entity: entity)
    }
    
    func removePattern(_ model: PatternModel) throws {
        let request: NSFetchRequest<Pattern> = Pattern.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", model.id as CVarArg)
        request.fetchLimit = 1
        
        let result = try viewContext.fetch(request)
        guard let entity = result.first else { return }
        
        viewContext.delete(entity)
        saveIfNeeded()
    }
}
