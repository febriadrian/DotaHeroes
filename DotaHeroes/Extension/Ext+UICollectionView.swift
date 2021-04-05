//
//  Ext+UICollectionView.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 01/04/21.
//

import UIKit

extension UICollectionView {
    func registerCellType<T>(_ cellClass: T.Type) where T: AnyObject {
        let identifier = "\(cellClass)"
        register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }

    func dequeueReusableCell<T>(_ cellClass: T.Type, for indexPath: IndexPath) -> T where T: AnyObject {
        let identifier = "\(cellClass)"
        if let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T {
            return cell
        }

        fatalError("Error dequeueing cell")
    }
}
