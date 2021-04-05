//
//  RoleObject.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 03/04/21.
//

import RealmSwift

@objcMembers class RoleObject: Object {
    dynamic var name: String = ""

    override class func primaryKey() -> String? {
        return "name"
    }

    required init() {
        super.init()
    }

    init(name: String?) {
        self.name = name ?? ""
    }
}
