//
//  RoleModel.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 03/04/21.
//

import Foundation

struct RoleModel {
    var name: String
    
    init(object: RoleObject) {
        self.name = object.name
    }
}
