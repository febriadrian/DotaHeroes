//
//  HeroDetailViewModelTests.swift
//  DotaHeroesTests
//
//  Created by Febri Adrian on 05/04/21.
//

@testable import DotaHeroes
import Mockingbird
import XCTest

class HeroDetailViewModelTests: DotaHeroesTests {
    var sut: HeroDetailViewModel!
    var heroDetail: HeroDetailModel!
    var heroListViewModel: HeroListViewModel!

    override func setUp() {
        super.setUp()
        sut = HeroDetailViewModel()
        heroListViewModel = HeroListViewModel(heroAPIProvider: heroAPIProviderMock)
    }

    override func tearDown() {
        heroDetail = nil
        heroListViewModel = nil
        sut = nil
        super.tearDown()
    }

    func testGetHeroDetailStrength() {
        testGetHeroDetailSuccess(heroAttribute: .strength)
    }

    func testGetHeroDetailAgility() {
        testGetHeroDetailSuccess(heroAttribute: .agility)
    }

    func testGetHeroDetailIntelligence() {
        testGetHeroDetailSuccess(heroAttribute: .intelligence)
    }

    func testGetHeroDetailSuccess(heroAttribute: HeroAttribute) {
        var selectedSimilarHeroIndex: Int!
        var allHeroesWithAttribute: [HeroListModel] = []
        let successResponse = ResponseMocker.mockResponse(of: .success)!

        given(heroAPIProviderMock.getHeroList(completion: any())) ~> { result in
            result(.success(successResponse))
        }

        heroListViewModel.getHeroes()
        XCTAssertFalse(heroListViewModel.heroList.isEmpty)

        for hero in heroListViewModel.heroList {
            if hero.attribute == heroAttribute.rawValue {
                sut.heroId = hero.id
                allHeroesWithAttribute.append(hero)
                break
            }
        }

        sut.delegate = self
        sut.getHeroDetail()

        XCTAssertEqual(heroDetail.id, sut.heroId)
        XCTAssertFalse(allHeroesWithAttribute.isEmpty)
        XCTAssertEqual(sut.similarHeroes.count, 3)

        selectedSimilarHeroIndex = 1

        for i in 0 ..< sut.similarHeroes.count {
            let similarHero = sut.similarHeroes[i]
            XCTAssertEqual(similarHero.attribute, heroAttribute.rawValue)

            allHeroesWithAttribute.forEach { hero in
                if hero.id != similarHero.id {
                    switch heroAttribute {
                    case .strength:
                        XCTAssertGreaterThanOrEqual(similarHero.baseAttackMax, hero.baseAttackMax)
                    case .agility:
                        XCTAssertGreaterThanOrEqual(similarHero.moveSpeedInt, hero.moveSpeedInt)
                    case .intelligence:
                        XCTAssertGreaterThanOrEqual(similarHero.baseMana, hero.baseMana)
                    }
                } else {
                    XCTAssertEqual(similarHero.name, hero.name)
                    XCTAssertEqual(similarHero.roles, hero.roles)
                    XCTAssertEqual(similarHero.attribute, hero.attribute)
                    XCTAssertEqual(similarHero.attribute, hero.attribute)
                    XCTAssertEqual(similarHero.baseAttackMax, hero.baseAttackMax)
                    XCTAssertEqual(similarHero.baseMana, hero.baseMana)
                    XCTAssertEqual(similarHero.moveSpeedInt, hero.moveSpeedInt)
                    XCTAssertEqual(similarHero.imageUrl, hero.imageUrl)
                }
            }

            if i == selectedSimilarHeroIndex {
                let hero = sut.hero(at: i)
                XCTAssertEqual(similarHero.id, hero.id)
            }
        }
    }

    func testGetHeroDetailFailed() {
        sut.heroId = 000

        sut.delegate = self
        sut.getHeroDetail()

        XCTAssertTrue(sut.similarHeroes.isEmpty)
        XCTAssertEqual(errorMessage, Messages.unknownError)

        sut.heroId = 0

        sut.getHeroDetail()

        XCTAssertTrue(sut.similarHeroes.isEmpty)
        XCTAssertEqual(errorMessage, Messages.unknownError)
    }
}

extension HeroDetailViewModelTests: HeroDetailViewModelDelegate {
    func didSuccessGetHeroDetail(detail: HeroDetailModel) {
        heroDetail = detail
    }

    func didFailGetHeroDetail(message: String) {
        errorMessage = message
    }
}
