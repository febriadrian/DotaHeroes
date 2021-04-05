//
//  RolesViewModel.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 03/04/21.
//

import Foundation

class RolesViewModel {
    var roles: [String] = ["ALL"]

    func role(at index: Int) -> String {
        return roles[index]
    }
}
