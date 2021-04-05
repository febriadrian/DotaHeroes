//
//  HeroListFactory.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 01/04/21.
//

import Foundation

struct HeroListFactory {
    static func setup(parameters: [String: Any] = [:]) -> HeroListViewController {
        let container = SwinjectContainer.getContainer()
        let viewModel = container.resolve(HeroListViewModel.self)!

        let vc = HeroListViewController(viewModel: viewModel)
        let router = HeroListRouter(view: vc)
        vc.router = router
        return vc
    }
}
