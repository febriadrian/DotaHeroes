//
//  HeroDetailFactory.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 04/04/21.
//

import Foundation

struct HeroDetailFactory {
    static func setup(id: Int) -> HeroDetailViewController {
        let container = SwinjectContainer.getContainer()
        let viewModel = container.resolve(HeroDetailViewModel.self)!
        viewModel.heroId = id

        let vc = HeroDetailViewController(viewModel: viewModel)
        let router = HeroDetailRouter(view: vc)
        vc.router = router
        return vc
    }
}
