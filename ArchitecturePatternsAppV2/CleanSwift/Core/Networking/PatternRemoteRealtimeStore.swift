//
//  PatternRemoteRealtimeStore.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 02.12.2025.
//

import Foundation
import FirebaseDatabase

protocol PatternRemoteStoreProtocol {
    func fetchAll(completion: @escaping (Result<[PatternModel], Error>) -> Void)
    func save(_ model: PatternModel, completion: ((Result<Void, Error>) -> Void)?)
    func delete(id: UUID, completion: ((Result<Void, Error>) -> Void)?)
    func incrementViewCounterFor(_ model: PatternModel, completion: ((Result<Void, Error>) -> Void)?)
    func getPatternByID(_ id: UUID, completion: @escaping ((Result<PatternModel, Error>) -> Void))
}

final class PatternRemoteRealtimeStore: PatternRemoteStoreProtocol {
    
    private let ref: DatabaseReference
    
    init(dataBase: DatabaseReference = Database.database().reference()) {
        self.ref = dataBase.child("patterns")
    }
    
    private func getKey(for model: PatternModel) -> String {
        model.id.uuidString
    }
    
    func fetchAll(completion: @escaping (Result<[PatternModel], Error>) -> Void) {
        ref.observe(.value) { spanshot in
            var result: [PatternModel] = []
            
            for child in spanshot.children {
                guard let snap = child as? DataSnapshot,
                      let model = PatternModel(snapshot: snap) else {
                    continue
                }
                result.append(model)
            }
            completion(.success(result))
        } withCancel: { error in
            completion(.failure(error))
        }

    }
    
    func save(_ model: PatternModel, completion: ((Result<Void, Error>) -> Void)? = nil) {
        let key = getKey(for: model)
        let value = model.rtdbDictionary
        
        ref.child(key).setValue(value) { error, _ in
            if let error = error {
                print("Firebase save error:", error)
                completion?(.failure(error))
            } else {
                completion?(.success(()))
            }
        }
    }
    
    func delete(id: UUID, completion: ((Result<Void, Error>) -> Void)? = nil) {
        ref.child(id.uuidString).removeValue { error, _ in
            if let error = error {
                print("Firebase delete error:", error)
                completion?(.failure(error))
            } else {
                completion?(.success(()))
            }
        }
    }
    
    func incrementViewCounterFor(_ model: PatternModel, completion: ((Result<Void, any Error>) -> Void)?) {
        let key = getKey(for: model)
        var value = model.rtdbDictionary
        
        let current = value["viewCounter"] as? Int ?? 0
        value["viewCounter"] = current + 1
        
        ref.child(key).setValue(value) { error, _ in
            if let error = error {
                print("Firebase save error:", error)
                completion?(.failure(error))
            } else {
                completion?(.success(()))
            }
        }
    }
    
    func getPatternByID(_ id: UUID, completion: @escaping (Result<PatternModel, any Error>) -> Void) {
        let key = id.uuidString
        
        ref.child(key).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.exists() else {
                return completion(.failure(
                    NSError(
                        domain: "PatternStore",
                        code: 404,
                        userInfo: [NSLocalizedDescriptionKey: "Pattern not found"]
                    )))
            }
            guard let model = PatternModel(snapshot: snapshot) else {
                return completion(
                    .failure(
                        NSError(
                            domain: "PatternStore",
                            code: 400,
                            userInfo: [NSLocalizedDescriptionKey: "Invalid snapshot format"]
                        )))
            }
            
            completion(.success(model))
        } withCancel: { error in
            completion(.failure(error))
        }
    }
    
    
    func clearAll(completion: (() -> Void)? = nil) {
        ref.removeValue() { error, _ in
            if let error = error {
                print("Firebase clearAll error:", error)
            } else {
                print("Firebase patterns cleared")
            }
            completion?()
        }
    }
}
