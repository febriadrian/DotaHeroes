//
//  Ext+Array.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 05/04/21.
//

import Foundation

extension Array where Element: Hashable {
    func duplicates() -> Array {
        let dictionary = Dictionary(grouping: self, by: { $0 })
        let duplicatedictionary = dictionary.filter { $1.count > 1 }
        let duplicates = Array(duplicatedictionary.keys)
        return duplicates
    }
}
