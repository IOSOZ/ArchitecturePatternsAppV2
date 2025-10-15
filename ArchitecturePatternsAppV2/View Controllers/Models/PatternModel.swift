//
//  PatternModel.swift
//  ArchitecturePatternsApp
//
//  Created by Олег Зуев on 25.08.2025.
//

import Foundation
import UIKit

enum PatternType: String, CaseIterable {
    case creational
    case structural
    case behavioral
    
    var title: String {
        switch self {
        case .creational:
            return "ПОРОЖДАЮЩИЕ"
        case .structural:
            return "СТРУКТУРНЫЕ"
        case .behavioral:
            return "ПОВЕДЕНЧЕСКИЕ"
        }
    }
}

struct Pattern {
    let id = UUID()
    var type: PatternType
    var name: String
    var description: String?
    var image: UIImage?
    var viewCounter: Int = 0
    var isFavorite: Bool = false
}

final class DataStore {
    
    static let shared = DataStore()
    
    var creationalPatterns: [Pattern] = [
        Pattern(
            type: .creational,
            name: "Фабричный метод",
            description:
                "Фабричный метод — это порождающий паттерн проектирования, который определяет общий интерфейс для создания объектов в суперклассе, позволяя подклассам изменять тип создаваемых объектов",
            image: UIImage(resource: .factoryMethod)
        ),
        Pattern(
            type: .creational,
            name: "Абстрактная фабрика",
            description:
                "Абстрактная фабрика — это порождающий паттерн проектирования, который позволяет создавать семейства связанных объектов, не привязываясь к конкретным классам создаваемых объектов.",
            image: UIImage(resource: .abstractFactory)
        ),
        Pattern(
            type: .creational,
            name: "Строитель",
            description:
                "Строитель — это порождающий паттерн проектирования, который позволяет создавать сложные объекты пошагово. Строитель даёт возможность использовать один и тот же код строительства для получения разных представлений объектов.",
            image: UIImage(resource: .builderMini)
        ),
        Pattern(
            type: .creational,
            name: "Прототип",
            description:
                "Прототип — это порождающий паттерн проектирования, который позволяет копировать объекты, не вдаваясь в подробности их реализации.",
            image: UIImage(resource: .prototype)
        ),
        Pattern(
            type: .creational,
            name: "Одиночка",
            description:
                "Одиночка — это порождающий паттерн проектирования, который гарантирует, что у класса есть только один экземпляр, и предоставляет к нему глобальную точку доступа.",
            image: UIImage(resource: .singleton)
        )
    ]
    
    var structuralPatterns: [Pattern] = [
        Pattern(
            type: .structural,
            name: "Адаптер",
            description:
                "Адаптер — это структурный паттерн проектирования, который позволяет объектам с несовместимыми интерфейсами работать вместе.",
            image: UIImage(resource: .adapter)
        ),
        Pattern(
            type: .structural,
            name: "Мост",
            description:
                "Мост — это структурный паттерн проектирования, который разделяет один или несколько классов на две отдельные иерархии — абстракцию и реализацию, позволяя изменять их независимо друг от друга.",
            image: UIImage(resource: .bridge)
        ),
        Pattern(
            type: .structural,
            name: "Компоновщик",
            description:
                "Компоновщик — это структурный паттерн проектирования, который позволяет сгруппировать множество объектов в древовидную структуру, а затем работать с ней так, как будто это единичный объект.",
            image: UIImage(resource: .composite)
        ),
        Pattern(
            type: .structural,
            name: "Декоратор",
            description:
                "Декоратор — это структурный паттерн проектирования, который позволяет динамически добавлять объектам новую функциональность, оборачивая их в полезные «обёртки».",
            image: UIImage(resource: .decorator)
        ),
        Pattern(
            type: .structural,
            name: "Фасад",
            description:
                "Фасад — это структурный паттерн проектирования, который предоставляет простой интерфейс к сложной системе классов, библиотеке или фреймворку.",
            image: UIImage(resource: .facade)
        ),
        Pattern(
            type: .structural,
            name: "Легковес",
            description:
                "Легковес — это структурный паттерн проектирования, который позволяет вместить бóльшее количество объектов в отведённую оперативную память. Легковес экономит память, разделяя общее состояние объектов между собой, вместо хранения одинаковых данных в каждом объекте.",
            image: UIImage(resource: .flyweight)
        ),
        Pattern(
            type: .structural,
            name: "Заместитель",
            description:
                "Заместитель — это структурный паттерн проектирования, который позволяет подставлять вместо реальных объектов специальные объекты-заменители. Эти объекты перехватывают вызовы к оригинальному объекту, позволяя сделать что-то до или после передачи вызова оригиналу.",
            image: UIImage(resource: .proxy)
        )
    ]
    
    var behavioralPatterns: [Pattern] = [
        Pattern(
            type: .behavioral,
            name: "Цепочка обязанностей",
            description:
                "Цепочка обязанностей — это поведенческий паттерн проектирования, который позволяет передавать запросы последовательно по цепочке обработчиков. Каждый последующий обработчик решает, может ли он обработать запрос сам и стоит ли передавать запрос дальше по цепи.",
            image: UIImage(resource: .chainoOfResponsibility)
        ),
        Pattern(
            type: .behavioral,
            name: "Команда",
            description:
                "Команда — это поведенческий паттерн проектирования, который превращает запросы в объекты, позволяя передавать их как аргументы при вызове методов, ставить запросы в очередь, логировать их, а также поддерживать отмену операций.",
            image: UIImage(resource: .command)
        ),
        Pattern(
            type: .behavioral,
            name: "Итератор",
            description:
                "Итератор — это поведенческий паттерн проектирования, который даёт возможность последовательно обходить элементы составных объектов, не раскрывая их внутреннего представления.",
            image: UIImage(resource: .iterator)
        ),
        Pattern(
            type: .behavioral,
            name: "Посредник",
            description:
                "Посредник — это поведенческий паттерн проектирования, который позволяет уменьшить связанность множества классов между собой, благодаря перемещению этих связей в один класс-посредник.",
            image: UIImage(resource: .mediator)
        ),
        Pattern(
            type: .behavioral,
            name: "Снимок",
            description:
                "Снимок — это поведенческий паттерн проектирования, который позволяет сохранять и восстанавливать прошлые состояния объектов, не раскрывая подробностей их реализации.",
            image: UIImage(resource: .memento)
        ),
        Pattern(
            type: .behavioral,
            name: "Наблюдатель",
            description:
                "Наблюдатель — это поведенческий паттерн проектирования, который создаёт механизм подписки, позволяющий одним объектам следить и реагировать на события, происходящие в других объектах.",
            image: UIImage(resource: .observer)
        ),
        Pattern(
            type: .behavioral,
            name: "Состояние",
            description:
                "Состояние — это поведенческий паттерн проектирования, который позволяет объектам менять поведение в зависимости от своего состояния. Извне создаётся впечатление, что изменился класс объекта.",
            image: UIImage(resource: .state)
        ),
        Pattern(
            type: .behavioral,
            name: "Стратегия",
            description:
                "Стратегия — это поведенческий паттерн проектирования, который определяет семейство схожих алгоритмов и помещает каждый из них в собственный класс, после чего алгоритмы можно взаимозаменять прямо во время исполнения программы.",
            image: UIImage(resource: .strategy)
        ),
        Pattern(
            type: .behavioral,
            name: "Шаблонный метод",
            description:
                "Шаблонный метод — это поведенческий паттерн проектирования, который определяет скелет алгоритма, перекладывая ответственность за некоторые его шаги на подклассы. Паттерн позволяет подклассам переопределять шаги алгоритма, не меняя его общей структуры.",
            image: UIImage(resource: .templateMethod)
        ),
        Pattern(
            type: .behavioral,
            name: "Посетитель",
            description: "Посетитель — это поведенческий паттерн проектирования, который позволяет добавлять в программу новые операции, не изменяя классы объектов, над которыми эти операции могут выполняться.",
            image: UIImage(resource: .visitor)
        )
    ]
    
    subscript(index: Int) -> [Pattern] {
        switch index {
        case 0: return creationalPatterns
        case 1: return structuralPatterns
        case 2: return behavioralPatterns
        default : return []
        }
    }
    
    private init() {}
    
}

final class StorageManager {
    private let dataStore = DataStore.shared
    static let shared = StorageManager()
    func getAllPatterns() -> [[Pattern]] {
        return [dataStore.creationalPatterns, dataStore.structuralPatterns, dataStore.behavioralPatterns]
    }
    
    func getPatternFor(indexPath: IndexPath) -> Pattern {
        return dataStore[indexPath.section][indexPath.row]
        }
        
    func getFavoritePatterns() -> [Pattern] {
        var favoritePattens: [Pattern] = []
        let allPatterns = getAllPatterns().flatMap { $0 }
        allPatterns.forEach { pattern in
            if pattern.isFavorite == true {
                favoritePattens.append(pattern)
            }
        }
        return favoritePattens
    }
    
    func addNewPattern(_ pattern: Pattern) {
        switch pattern.type {
        case .behavioral:
            dataStore.behavioralPatterns.append(pattern)
        case .structural:
            dataStore.structuralPatterns.append(pattern)
        case .creational:
            dataStore.creationalPatterns.append(pattern)
        }
    }
    
    func updatePattern(_ pattern: Pattern) {
        guard let oldPattern = getPatternByID(pattern.id) else { return }
            
        if oldPattern.type != pattern.type {
            removePattern(oldPattern)
            addNewPattern(pattern)
            return
        }
        
        switch pattern.type {
        case .behavioral:
            if let index = dataStore.behavioralPatterns.firstIndex(where: { $0.id == pattern.id }) {
                dataStore.behavioralPatterns[index] = pattern
            }
        case .creational:
            if let index = dataStore.creationalPatterns.firstIndex(where: { $0.id == pattern.id }) {
                dataStore.creationalPatterns[index] = pattern
            }
        case .structural:
            if let index = dataStore.structuralPatterns.firstIndex(where: { $0.id == pattern.id }) {
                dataStore.structuralPatterns[index] = pattern
            }
        }
    }
    
    func incrementViewCounterFor(pattern : Pattern) {
        var incrementPattern = pattern
        incrementPattern.viewCounter += 1
        updatePattern(incrementPattern)
    }
    
    func getPatternByID(_ id: UUID) -> Pattern? {
            let allPattens = getAllPatterns().flatMap { $0 }
            return allPattens.first { $0.id == id }
        }
    
    func removePattern(_ pattern: Pattern ) {
        switch pattern.type {
        case .behavioral:
            guard let index = dataStore.behavioralPatterns.firstIndex(where: { $0.id == pattern.id}) else {return}
            dataStore.behavioralPatterns.remove(at: index)
        case .structural:
            guard let index = dataStore.structuralPatterns.firstIndex(where: { $0.id == pattern.id}) else {return}
            dataStore.structuralPatterns.remove(at: index)
        case .creational:
            guard let index = dataStore.creationalPatterns.firstIndex(where: { $0.id == pattern.id}) else {return}
            dataStore.creationalPatterns.remove(at: index)
        }
    }
    
    private init() {}
    
//    private func getPatternByName(_ name: String) -> Pattern? {
//        let allPattens = getAllPatterns().flatMap { $0 }
//        return allPattens.first { $0.name == name }
//    }
}
