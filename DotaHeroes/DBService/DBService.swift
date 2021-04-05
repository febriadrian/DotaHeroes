//
//  DBService.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 03/04/21.
//

import RealmSwift

class DBService {
    private var realm: Realm?

    init() {
        do {
            self.realm = try Realm()
        } catch {
            TRACE(error.localizedDescription)
        }
    }

    func saveObject(_ object: Object, otherTasks: (DHVoidCompletion)? = nil) {
        do {
            try realm?.write {
                otherTasks?()
                realm?.add(object, update: .all)
            }
        } catch {
            TRACE(error.localizedDescription)
        }
    }

    func deleteObject(_ object: Object, otherTasks: (DHVoidCompletion)? = nil) {
        do {
            try realm?.write {
                otherTasks?()
                realm?.delete(object)
            }
        } catch {
            TRACE(error.localizedDescription)
        }
    }

    func deleteAllObject(_ objects: [Object], otherTasks: (DHVoidCompletion)? = nil) {
        objects.forEach { object in
            deleteObject(object)
        }
    }

    func load<T: Object>(_ object: T) -> [T] {
        if let results = realm?.objects(T.self).toArray(ofType: T.self) {
            return results as [T]
        }
        return []
    }

    func load<T: Object>(_ object: T, filteredBy filter: String) -> [T] {
        if !filter.isEmpty {
            if let results = realm?.objects(T.self).filter(filter).toArray(ofType: T.self) {
                return results as [T]
            }
        }
        return []
    }

    func deleteAllObjects() {
        realm?.configuration.objectTypes?.forEach { objectType in
            if let results = realm?.objects(objectType.self) {
                do {
                    try realm?.write {
                        realm?.delete(results)
                    }
                } catch {
                    TRACE(error.localizedDescription)
                }
            }
        }
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
