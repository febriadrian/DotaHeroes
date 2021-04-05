//
//  Ext+Data.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 01/04/21.
//

import Foundation

extension Data {
    var toJSON: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: .utf8)
        else {
            return nil
        }
        return prettyPrintedString
    }

    var toDictionary: [String: Any]? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] else {
            return nil
        }
        return object
    }
}
