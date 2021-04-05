//
//  HeroListResponseModel.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 03/04/21.
//

import Foundation

struct HeroListResponseModel: Codable {
    let id: Int?
    let name: String?
    let img: String?
    let attribute: String?
    let type: String?
    let moveSpeed: Int?
    let roles: [String]?
    let strength: Int?
    let agility: Int?
    let intelligence: Int?
    let baseArmor: Double?
    let baseAttackMax: Int?
    let baseAttackMin: Int?
    let baseHealth: Int?
    let baseHealthRegen: Double?
    let baseMana: Int?
    let baseManaRegen: Double?
    let attackRange: Int?
    let baseAttackTime: Double?

    enum CodingKeys: String, CodingKey {
        case id, img, roles
        case name = "localized_name"
        case attribute = "primary_attr"
        case type = "attack_type"
        case moveSpeed = "move_speed"
        case strength = "base_str"
        case agility = "base_agi"
        case intelligence = "base_int"
        case baseArmor = "base_armor"
        case baseAttackMax = "base_attack_max"
        case baseAttackMin = "base_attack_min"
        case baseHealth = "base_health"
        case baseHealthRegen = "base_health_regen"
        case baseMana = "base_mana"
        case baseManaRegen = "base_mana_regen"
        case baseAttackTime = "attack_rate"
        case attackRange = "attack_range"
    }
}
