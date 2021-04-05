//
//  Messages.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 01/04/21.
//

import Foundation

struct Messages {
    static let loading = "Please wait.."
    static let noHeroes = "No Heroes Found"
    static let noInternet = "No Internet Connection"
    static let unknownError = "Unknown Error"

    static let generalError: String = {
        if NetworkStatus.isInternetAvailable {
            return unknownError
        }
        return noInternet
    }()

    static func noHeroesWithRoles(_ selectedRoles: [String]) -> String {
        let stringRoles = selectedRoles.joined(separator: ", ")
        return "No Heroes Found with Roles: \(stringRoles)"
    }
}
