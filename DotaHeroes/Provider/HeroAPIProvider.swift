//
//  HeroAPIProvider.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 03/04/21.
//

import Foundation

class HeroAPIProvider {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func getHeroList(completion: @escaping HeroListResponseBlock) {
        networkService.request(endpoint: Endpoint.getHeroList, completion: completion)
    }
}
