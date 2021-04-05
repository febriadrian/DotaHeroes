//
//  RolesFactory.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 03/04/21.
//

import Foundation

struct RolesFactory {
    static func setup(roles: [String]) -> RolesViewController {
        let container = SwinjectContainer.getContainer()
        let viewModel = container.resolve(RolesViewModel.self)!
        viewModel.roles += roles

        let vc = RolesViewController(viewModel: viewModel)
        return vc
    }
}
