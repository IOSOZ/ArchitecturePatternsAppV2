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


extension StorageManager {
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





//func getAllPatterns() -> [[Pattern]] {
////        return [dataStore.creationalPatterns, dataStore.structuralPatterns, dataStore.behavioralPatterns]
//    
//    
//}
//
//func getPatternFor(indexPath: IndexPath) -> Pattern {
//    return dataStore[indexPath.section][indexPath.row]
//}
//
//func getFavoritePatterns() -> [Pattern] {
//    var favoritePattens: [Pattern] = []
//    let allPatterns = getAllPatterns().flatMap { $0 }
//    allPatterns.forEach { pattern in
//        if pattern.isFavorite == true {
//            favoritePattens.append(pattern)
//        }
//    }
//    return favoritePattens
//}
//
//func addNewPattern(_ pattern: Pattern) {
//    switch pattern.type {
//    case .behavioral:
//        dataStore.behavioralPatterns.append(pattern)
//    case .structural:
//        dataStore.structuralPatterns.append(pattern)
//    case .creational:
//        dataStore.creationalPatterns.append(pattern)
//    }
//}
//
//func updatePattern(_ pattern: Pattern) {
//    guard let oldPattern = getPatternByID(pattern.id) else { return }
//    
//    if oldPattern.type != pattern.type {
//        removePattern(oldPattern)
//        addNewPattern(pattern)
//        return
//    }
//    
//    switch pattern.type {
//    case .behavioral:
//        if let index = dataStore.behavioralPatterns.firstIndex(where: { $0.id == pattern.id }) {
//            dataStore.behavioralPatterns[index] = pattern
//        }
//    case .creational:
//        if let index = dataStore.creationalPatterns.firstIndex(where: { $0.id == pattern.id }) {
//            dataStore.creationalPatterns[index] = pattern
//        }
//    case .structural:
//        if let index = dataStore.structuralPatterns.firstIndex(where: { $0.id == pattern.id }) {
//            dataStore.structuralPatterns[index] = pattern
//        }
//    }
//}
//
//func incrementViewCounterFor(pattern : Pattern) {
//    var incrementPattern = pattern
//    incrementPattern.viewCounter += 1
//    updatePattern(incrementPattern)
//}
//
//func getPatternByID(_ id: UUID) -> Pattern? {
//    let allPattens = getAllPatterns().flatMap { $0 }
//    return allPattens.first { $0.id == id }
//}
//
//func removePattern(_ pattern: Pattern ) {
//    switch pattern.type {
//    case .behavioral:
//        guard let index = dataStore.behavioralPatterns.firstIndex(where: { $0.id == pattern.id}) else {return}
//        dataStore.behavioralPatterns.remove(at: index)
//    case .structural:
//        guard let index = dataStore.structuralPatterns.firstIndex(where: { $0.id == pattern.id}) else {return}
//        dataStore.structuralPatterns.remove(at: index)
//    case .creational:
//        guard let index = dataStore.creationalPatterns.firstIndex(where: { $0.id == pattern.id}) else {return}
//        dataStore.creationalPatterns.remove(at: index)
//    }
//}
