//
//  ResponseMocker.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 05/04/21.
//

import Foundation

enum ResponseFile: String {
    case success = "heroListSuccessResponse"
    case successEmpty = "heroListSuccessEmptyResponse"
    case failed = "heroListFailedResponse"
}

struct ResponseMocker {
    static func mockResponse(of fileName: ResponseFile) -> [HeroListResponseModel]? {
        guard let path = Bundle.main.path(forResource: fileName.rawValue, ofType: "json") else {
            return nil
        }

        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            let response = try? jsonDecoder().decode([HeroListResponseModel].self, from: data)
            return response
        } catch {
            return nil
        }
    }
}
