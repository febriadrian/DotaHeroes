//
//  HeroDBProvider.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 03/04/21.
//

import Foundation

class HeroDBProvider: DBService {
    static let share = HeroDBProvider()

    func save(_ response: HeroListResponseModel) {
        let object = HeroObject(response: response)
        saveObject(object)
    }

    func getHerolist() -> [HeroListModel] {
        let object = HeroObject()
        let heroes = load(object).map { HeroListModel(object: $0) }
        return heroes
    }

    func getHeroDetail(id: Int) -> HeroDetailModel? {
        let filter = "(id = \(id))"
        let results = load(HeroObject(), filteredBy: filter)

        guard let object = results.first else {
            return nil
        }

        return HeroDetailModel(object: object)
    }

    func getSimilarHeroes(attribute: String) -> [HeroObject] {
        let filter = "(attribute = '\(attribute)')"
        return load(HeroObject(), filteredBy: filter)
    }
}
