//
//  Ext+UIButton.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 01/04/21.
//

import UIKit

extension UIButton {
    func touchUpInside(_ target: Any?, action: Selector) {
        addTarget(target, action: action, for: .touchUpInside)
    }
}
