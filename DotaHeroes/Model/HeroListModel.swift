//
//  HeroListModel.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 03/04/21.
//

import Foundation

struct HeroListModel {
    var id: Int
    var name: String
    var roles: String
    var attribute: String
    var baseAttackMax: Int
    var baseMana: Int
    var moveSpeedInt: Int
    var imageUrl: URL?

    init(response: HeroListResponseModel) {
        self.id = response.id ?? 0
        self.name = response.name ?? "n/a"
        self.attribute = response.attribute ?? ""
        self.baseAttackMax = response.baseAttackMax ?? 0
        self.baseMana = response.baseMana ?? 0
        self.moveSpeedInt = response.moveSpeed ?? 0

        let rolesArray = response.roles ?? []
        self.roles = rolesArray.joined(separator: ", ")

        let urlString = Constants.baseUrl + (response.img ?? "")
        self.imageUrl = URL(string: urlString)
    }

    init(object: HeroObject) {
        self.id = object.id
        self.name = object.name
        self.roles = object.roles
        self.attribute = object.attribute
        self.baseAttackMax = object.baseAttackMax
        self.baseMana = object.baseMana
        self.moveSpeedInt = object.moveSpeed

        let urlString = Constants.baseUrl + object.img
        self.imageUrl = URL(string: urlString)
    }
}
