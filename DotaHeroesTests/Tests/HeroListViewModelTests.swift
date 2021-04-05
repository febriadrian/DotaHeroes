//
//  HeroListViewModelTests.swift
//  DotaHeroesTests
//
//  Created by Febri Adrian on 05/04/21.
//

@testable import DotaHeroes
import Mockingbird
import XCTest

class HeroListViewModelTests: DotaHeroesTests {
    var sut: HeroListViewModel!

    override func setUp() {
        super.setUp()
        sut = HeroListViewModel(heroAPIProvider: heroAPIProviderMock)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testGetHeroListSuccessResponse() {
        let successResponse = ResponseMocker.mockResponse(of: .success)!
        var selectedHeroResponse: HeroListResponseModel!
        var selectedHero: HeroListModel!
        var selectedIndex: Int!

        given(heroAPIProviderMock.getHeroList(completion: any())) ~> { result in
            result(.success(successResponse))
        }

        sut.getHeroes()

        verify(heroAPIProviderMock.getHeroList(completion: any())).wasCalled()

        XCTAssertFalse(sut.isFiltering)
        XCTAssertEqual(sut.allHeroes.count, successResponse.count)
        XCTAssertEqual(sut.heroList.count, sut.allHeroes.count)
        XCTAssertFalse(sut.allHeroes.isEmpty)
        XCTAssertFalse(sut.heroList.isEmpty)

        selectedIndex = 1
        selectedHero = sut.hero(at: selectedIndex)
        selectedHeroResponse = successResponse[selectedIndex]
        XCTAssertEqual(selectedHero.name, selectedHeroResponse.name)

        // assert sut gathered all roles of each hero from response, no duplicates
        XCTAssertFalse(sut.roles.isEmpty)
        XCTAssertTrue(sut.roles.duplicates().isEmpty)

        successResponse.forEach { heroResponse in
            heroResponse.roles!.forEach { role in
                XCTAssertTrue(sut.roles.contains(role))
            }
        }
    }

    func testGetHeroesFromLocalStorageSuccess() {
        let successResponse = ResponseMocker.mockResponse(of: .success)!
        var selectedHeroResponse: HeroListResponseModel!
        var selectedHero: HeroListModel!
        var selectedIndex: Int!

        given(heroAPIProviderMock.getHeroList(completion: any())) ~> { result in
            result(.success(successResponse))
        }

        // first, call from response to save it
        sut.getHeroes()

        verify(heroAPIProviderMock.getHeroList(completion: any())).wasCalled()

        // then load from local storage
        wait(for: [], timeout: 1)
        sut.getHeroes()
        XCTAssertTrue(sut.isFromLocal)

        XCTAssertFalse(sut.isFiltering)
        XCTAssertEqual(sut.allHeroes.count, successResponse.count)
        XCTAssertEqual(sut.heroList.count, sut.allHeroes.count)
        XCTAssertFalse(sut.allHeroes.isEmpty)
        XCTAssertFalse(sut.heroList.isEmpty)

        selectedIndex = 1
        selectedHero = sut.hero(at: selectedIndex)
        selectedHeroResponse = successResponse[selectedIndex]
        XCTAssertEqual(selectedHero.name, selectedHeroResponse.name)

        // assert sut gathered all roles of each hero from response, no duplicates
        XCTAssertFalse(sut.roles.isEmpty)
        XCTAssertTrue(sut.roles.duplicates().isEmpty)

        successResponse.forEach { heroResponse in
            heroResponse.roles!.forEach { role in
                XCTAssertTrue(sut.roles.contains(role))
            }
        }
    }

    func testGetHeroListSuccessEmptyResponse() {
        let successEmptyResponse = ResponseMocker.mockResponse(of: .successEmpty)!

        given(heroAPIProviderMock.getHeroList(completion: any())) ~> { result in
            result(.success(successEmptyResponse))
        }

        sut.delegate = self
        sut.getHeroes()

        verify(heroAPIProviderMock.getHeroList(completion: any())).wasCalled()
        XCTAssertFalse(sut.isFiltering)
        XCTAssertEqual(sut.heroList.count, sut.allHeroes.count)
        XCTAssertTrue(successEmptyResponse.isEmpty)
        XCTAssertTrue(sut.allHeroes.isEmpty)
        XCTAssertTrue(sut.heroList.isEmpty)
        XCTAssertTrue(sut.roles.isEmpty)
        XCTAssertEqual(errorMessage, Messages.noHeroes)
    }

    func testGetHeroFailedResponse() {
        given(heroAPIProviderMock.getHeroList(completion: any())) ~> { result in
            result(.failure(Messages.generalError))
        }

        sut.delegate = self
        sut.getHeroes()

        verify(heroAPIProviderMock.getHeroList(completion: any())).wasCalled()

        XCTAssertFalse(sut.isFiltering)
        XCTAssertEqual(sut.heroList.count, sut.allHeroes.count)
        XCTAssertTrue(sut.allHeroes.isEmpty)
        XCTAssertTrue(sut.heroList.isEmpty)
        XCTAssertTrue(sut.roles.isEmpty)
        XCTAssertEqual(errorMessage, Messages.generalError)
    }

    func testFilterHeroesByRolesFound() {
        testGetHeroListSuccessResponse()

        var selectedRoles = ["Support"]
        selectedRoles.forEach { role in
            XCTAssertTrue(sut.roles.contains(role))
        }
        sut.filterHeroesBy(selectedRoles: selectedRoles)

        XCTAssertTrue(sut.isFiltering)
        XCTAssertEqual(sut.heroList.first?.name, sut.filteredHeroes.first?.name)

        selectedRoles = ["Jungler", "Disabler"]
        selectedRoles.forEach { role in
            XCTAssertTrue(sut.roles.contains(role))
        }
        sut.filterHeroesBy(selectedRoles: selectedRoles)

        XCTAssertTrue(sut.isFiltering)
        XCTAssertEqual(sut.heroList.first?.name, sut.filteredHeroes.first?.name)

        selectedRoles = ["Carry", "Nuker", "Disabler"]
        selectedRoles.forEach { role in
            XCTAssertTrue(sut.roles.contains(role))
        }
        sut.filterHeroesBy(selectedRoles: selectedRoles)

        XCTAssertTrue(sut.isFiltering)
        XCTAssertEqual(sut.heroList.first?.name, sut.filteredHeroes.first?.name)
    }

    func testFilterHeroesByRolesNotFoundCase1() {
        let selectedRoles = ["Carry", "Escape", "Durable", "Support"]
        testFilterHeroesNotFound(by: selectedRoles)
    }

    func testFilterHeroesByRolesNotFoundCase2() {
        let selectedRoles = ["Nuker", "Initiator", "Jungler", "Pusher"]
        testFilterHeroesNotFound(by: selectedRoles)
    }

    func testFilterHeroesByRolesNotFoundCase3() {
        let selectedRoles = ["Carry", "Initiator", "Jungler", "Support", "Nuker", "Durable"]
        testFilterHeroesNotFound(by: selectedRoles)
    }

    func testFilterHeroesNotFound(by selectedRoles: [String]) {
        var expectedErrorMsg: String!
        sut.delegate = self
        testGetHeroListSuccessResponse()

        selectedRoles.forEach { role in
            XCTAssertTrue(sut.roles.contains(role))
        }
        sut.filterHeroesBy(selectedRoles: selectedRoles)

        expectedErrorMsg = Messages.noHeroesWithRoles(selectedRoles)
        XCTAssertEqual(errorMessage, expectedErrorMsg)
        XCTAssertTrue(sut.isFiltering)
        XCTAssertTrue(sut.filteredHeroes.isEmpty)
        XCTAssertEqual(sut.heroList.first?.name, sut.allHeroes.first?.name)
    }
}

extension HeroListViewModelTests: HeroListViewModelDelegate {
    func didSuccessGetHeroes() {
        TRACE("Success get hero list")
    }

    func didFailGetHeroes(message: String) {
        errorMessage = message
    }
}
