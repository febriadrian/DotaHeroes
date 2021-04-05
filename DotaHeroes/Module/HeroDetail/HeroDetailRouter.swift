//
//  HeroDetailRouter.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 04/04/21.
//

import Foundation

protocol IHeroDetailRouter: class {
    func pushToHeroDetail(id: Int)
}

class HeroDetailRouter: IHeroDetailRouter {
    weak var view: HeroDetailViewController?
    private var roles: [String] = []

    init(view: HeroDetailViewController?) {
        self.view = view
    }

    func pushToHeroDetail(id: Int) {
        let module = DHRoute.heroDetail(id: id)
        view?.navigate(type: .push, module: module)
    }
}
