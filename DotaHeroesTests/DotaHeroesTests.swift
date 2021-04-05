//
//  DotaHeroesTests.swift
//  DotaHeroesTests
//
//  Created by Febri Adrian on 01/04/21.
//

@testable import DotaHeroes
import Mockingbird
import XCTest

class DotaHeroesTests: XCTestCase {
    var networkServiceMock: NetworkServiceMock!
    var heroAPIProviderMock: HeroAPIProviderMock!
    var realmService: DBService!
    var errorMessage: String!

    override func setUp() {
        super.setUp()
        // make sure no response saved in local storage before running tests
        realmService = DBService()
        realmService.deleteAllObjects()

        networkServiceMock = mock(NetworkService.self)
        heroAPIProviderMock = mock(HeroAPIProvider.self).initialize(networkService: networkServiceMock)
    }

    override func tearDown() {
        realmService.deleteAllObjects()
        errorMessage = nil
        realmService = nil
        heroAPIProviderMock = nil
        networkServiceMock = nil
        super.tearDown()
    }
}
