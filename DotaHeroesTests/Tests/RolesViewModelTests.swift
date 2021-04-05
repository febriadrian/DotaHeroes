//
//  RolesViewModelTests.swift
//  DotaHeroesTests
//
//  Created by Febri Adrian on 05/04/21.
//

@testable import DotaHeroes
import Mockingbird
import XCTest

class RolesViewModelTests: DotaHeroesTests {
    var sut: RolesViewModel!
    var heroDetail: HeroDetailModel!
    var heroListViewModel: HeroListViewModel!

    override func setUp() {
        super.setUp()
        sut = RolesViewModel()
        heroListViewModel = HeroListViewModel(heroAPIProvider: heroAPIProviderMock)
    }

    override func tearDown() {
        heroDetail = nil
        heroListViewModel = nil
        sut = nil
        super.tearDown()
    }

    func testRolesList() {
        let successResponse = ResponseMocker.mockResponse(of: .success)!
        XCTAssertEqual(sut.roles.count, 1)

        given(heroAPIProviderMock.getHeroList(completion: any())) ~> { result in
            result(.success(successResponse))
        }

        heroListViewModel.getHeroes()
        XCTAssertFalse(heroListViewModel.roles.isEmpty)

        sut.roles += heroListViewModel.roles

        XCTAssertEqual(sut.role(at: 0), "ALL")
        XCTAssertNotEqual(sut.roles.count, 1)
        XCTAssertTrue(sut.roles.count == (heroListViewModel.roles.count + 1))

        heroListViewModel.roles.forEach { role in
            XCTAssertTrue(sut.roles.contains(role))
        }
    }
}
