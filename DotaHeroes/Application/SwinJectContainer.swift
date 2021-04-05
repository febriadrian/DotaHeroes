//
//  SwinJectContainer.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 01/04/21.
//

import Swinject
import SwinjectAutoregistration

public enum SwinjectContainer {
    static func getContainer() -> Container {
        let container = Container()
        container.autoregister(NetworkService.self, initializer: NetworkService.init)
        container.autoregister(HeroAPIProvider.self, initializer: HeroAPIProvider.init)
        container.autoregister(HeroListViewModel.self, initializer: HeroListViewModel.init)
        container.autoregister(RolesViewModel.self, initializer: RolesViewModel.init)
        container.autoregister(HeroDetailViewModel.self, initializer: HeroDetailViewModel.init)
        return container
    }
}
