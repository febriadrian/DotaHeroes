//
//  RoleDBProvider.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 03/04/21.
//

import Foundation

class RoleDBProvider: DBService {
    static let share = RoleDBProvider()

    func save(_ roleName: String?) {
        let object = RoleObject(name: roleName)
        saveObject(object)
    }

    func getRolelist() -> [String] {
        let object = RoleObject()
        let roles = load(object).map { $0.name }
        return roles.sorted()
    }
}
