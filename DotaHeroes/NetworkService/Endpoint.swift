//
//  Endpoint.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 01/04/21.
//

import Alamofire

enum Endpoint {
    case getHeroList
}

extension Endpoint: IEndpoint {
    var url: String {
        return Constants.baseUrl + "/api" + path
    }

    private var path: String {
        switch self {
        case .getHeroList:
            return "/herostats"
        }
    }

    var method: HTTPMethod {
        return .get
    }

    var parameters: Parameters? {
        return nil
    }

    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }

    var headers: HTTPHeaders? {
        return [
            "Content-Type": "application/json",
        ]
    }
}
