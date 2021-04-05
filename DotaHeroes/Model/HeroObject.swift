//
//  HeroObject.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 03/04/21.
//

import RealmSwift

@objcMembers class HeroObject: Object {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var img: String = ""
    dynamic var attribute: String = ""
    dynamic var type: String = ""
    dynamic var moveSpeed: Int = 0
    dynamic var roles: String = ""
    dynamic var strength: Int = 0
    dynamic var agility: Int = 0
    dynamic var intelligence: Int = 0
    dynamic var baseAttackMax: Int = 0
    dynamic var baseAttackMin: Int = 0
    dynamic var baseHealth: Int = 0
    dynamic var baseHealthRegen: Double = 0
    dynamic var baseMana: Int = 0
    dynamic var baseManaRegen: Double = 0
    dynamic var attackRange: Int = 0
    dynamic var baseArmor: Int = 0
    dynamic var baseAttackTime: Double = 0

    override class func primaryKey() -> String? {
        return "id"
    }

    required init() {
        super.init()
    }

    init(response: HeroListResponseModel) {
        self.id = response.id ?? 0
        self.name = response.name ?? ""
        self.img = response.img ?? ""
        self.attribute = response.attribute ?? ""
        self.type = response.type ?? ""
        self.moveSpeed = response.moveSpeed ?? 0

        let rolesArray = response.roles ?? []
        self.roles = rolesArray.joined(separator: ", ")

        self.strength = response.strength ?? 0
        self.agility = response.agility ?? 0
        self.intelligence = response.intelligence ?? 0
        self.baseArmor = Int(response.baseArmor ?? 0)
        self.baseAttackMax = response.baseAttackMax ?? 0
        self.baseAttackMin = response.baseAttackMin ?? 0
        self.baseHealth = response.baseHealth ?? 0
        self.baseHealthRegen = response.baseHealthRegen ?? 0
        self.baseMana = response.baseMana ?? 0
        self.baseManaRegen = response.baseManaRegen ?? 0
        self.baseAttackTime = response.baseAttackTime ?? 0
        self.attackRange = response.attackRange ?? 0
    }
}
