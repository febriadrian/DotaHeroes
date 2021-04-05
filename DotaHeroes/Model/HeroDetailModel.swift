//
//  HeroDetailModel.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 04/04/21.
//

import Foundation

struct HeroDetailModel {
    var id: Int
    var attribute: String
    var name: String
    var type: String
    var roles: String
    var imageUrl: URL?
    var strength: String
    var agility: String
    var intelligence: String
    var damage: String
    var armor: String
    var moveSpeed: String
    var baseHealth: String
    var baseHealthRegen: String
    var baseMana: String
    var baseManaRegen: String
    var baseAttackTime: String
    var attackRange: String
    var baseAttackMax: Int
    var moveSpeedInt: Int
    
    init(object: HeroObject) {
        self.id = object.id
        self.attribute = object.attribute
        self.name = object.name
        self.type = object.type
        self.roles = object.roles
        self.strength = "\(object.strength)"
        self.agility = "\(object.agility)"
        self.intelligence = "\(object.intelligence)"
        self.baseAttackMax = object.baseAttackMax
        self.damage = "\(object.baseAttackMin) - \(object.baseAttackMax)"
        self.armor = "\(object.baseArmor)"
        self.moveSpeedInt = object.moveSpeed
        self.moveSpeed = "\(object.moveSpeed)"
        self.baseHealth = "\(object.baseHealth)"
        self.baseHealthRegen = "\(object.baseHealthRegen)"
        self.baseMana = "\(object.baseMana)"
        self.baseManaRegen = "\(object.baseManaRegen)"
        self.baseAttackTime = "\(object.baseAttackTime)"
        self.attackRange = "\(object.attackRange)"
        
        let urlString = Constants.baseUrl + object.img
        self.imageUrl = URL(string: urlString)
    }
}
