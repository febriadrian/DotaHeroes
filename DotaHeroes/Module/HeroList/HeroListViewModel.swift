//
//  HeroListViewModel.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 01/04/21.
//

import Foundation

protocol HeroListViewModelDelegate {
    func didSuccessGetHeroes()
    func didFailGetHeroes(message: String)
}

class HeroListViewModel {
    private let heroAPIProvider: HeroAPIProvider
    var delegate: HeroListViewModelDelegate?
    var allHeroes: [HeroListModel] = []
    var heroList: [HeroListModel] = []
    var filteredHeroes: [HeroListModel] = []
    var roles: [String] = []
    var isFiltering: Bool = false
    var isFromLocal: Bool = false

    init(heroAPIProvider: HeroAPIProvider) {
        self.heroAPIProvider = heroAPIProvider
    }

    func hero(at index: Int) -> HeroListModel {
        return heroList[index]
    }

    func getHeroes() {
        isFiltering = false
        heroList = HeroDBProvider.share.getHerolist()
        roles = RoleDBProvider.share.getRolelist()

        if heroList.isEmpty || roles.isEmpty {
            heroAPIProvider.getHeroList { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let successResponse):
                    guard !successResponse.isEmpty else {
                        self.delegate?.didFailGetHeroes(message: Messages.noHeroes)
                        return
                    }

                    for response in successResponse {
                        let hero = HeroListModel(response: response)
                        self.allHeroes.append(hero)

                        if let roles = response.roles {
                            roles.forEach { role in
                                if !self.roles.contains(role) {
                                    self.roles.append(role)
                                    RoleDBProvider.share.save(role)
                                }
                            }
                        }

                        HeroDBProvider.share.save(response)
                    }
                    self.delegate?.didSuccessGetHeroes()
                    self.heroList = self.allHeroes
                case .failure(let errorMessage):
                    self.delegate?.didFailGetHeroes(message: errorMessage)
                }
            }
        } else {
            isFromLocal = true
            delegate?.didSuccessGetHeroes()
            allHeroes = heroList
        }
    }

    func filterHeroesBy(selectedRoles: [String]) {
        isFiltering = true
        filteredHeroes.removeAll()

        for hero in allHeroes {
            var matchedRolesCount = 0

            for i in 0 ..< selectedRoles.count {
                let role = selectedRoles[i]

                if hero.roles.contains(role) {
                    matchedRolesCount += 1
                }
            }

            if matchedRolesCount == selectedRoles.count {
                filteredHeroes.append(hero)
            }
        }

        if filteredHeroes.isEmpty {
            let message = Messages.noHeroesWithRoles(selectedRoles)
            delegate?.didFailGetHeroes(message: message)
        } else {
            heroList = filteredHeroes
            delegate?.didSuccessGetHeroes()
        }
    }
}
