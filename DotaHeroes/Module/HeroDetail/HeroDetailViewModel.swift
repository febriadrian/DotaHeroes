//
//  HeroDetailViewModel.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 04/04/21.
//

import Foundation

protocol HeroDetailViewModelDelegate {
    func didSuccessGetHeroDetail(detail: HeroDetailModel)
    func didFailGetHeroDetail(message: String)
}

class HeroDetailViewModel {
    var delegate: HeroDetailViewModelDelegate?
    var similarHeroes: [HeroListModel] = []
    var heroId: Int = 0

    func hero(at index: Int) -> HeroListModel {
        return similarHeroes[index]
    }

    func getHeroDetail() {
        guard let detail = HeroDBProvider.share.getHeroDetail(id: heroId) else {
            delegate?.didFailGetHeroDetail(message: Messages.unknownError)
            return
        }

        var heroObjects = HeroDBProvider.share.getSimilarHeroes(attribute: detail.attribute)
        for i in 0 ..< heroObjects.count {
            if heroObjects[i].id == heroId {
                heroObjects.remove(at: i)
                break
            }
        }

        let heroAttribute = HeroAttribute(rawValue: detail.attribute)
        switch heroAttribute {
        case .strength:
            heroObjects.sort(by: { $0.baseAttackMax > $1.baseAttackMax })
        case .agility:
            heroObjects.sort(by: { $0.moveSpeed > $1.moveSpeed })
        case .intelligence:
            heroObjects.sort(by: { $0.baseMana > $1.baseMana })
        default:
            break
        }

        similarHeroes = heroObjects.prefix(3).map { HeroListModel(object: $0) }
        delegate?.didSuccessGetHeroDetail(detail: detail)
    }
}
