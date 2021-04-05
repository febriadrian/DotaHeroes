//
//  Ext+String.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 01/04/21.
//

import Foundation

extension String {
    var removeBackslash: String {
        return replacingOccurrences(of: "\\/", with: "/")
    }
}
