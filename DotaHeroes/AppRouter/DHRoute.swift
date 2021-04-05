//
//  DHRoute.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 01/04/21.
//

import UIKit

enum DHRoute: IRouter {
    case heroList
    case heroDetail(id: Int)
}

extension DHRoute {
    var module: UIViewController? {
        switch self {
        case .heroList:
            return HeroListFactory.setup()
        case .heroDetail(let id):
            return HeroDetailFactory.setup(id: id)
        }
    }
}
