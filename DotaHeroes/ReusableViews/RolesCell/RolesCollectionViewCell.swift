//
//  RolesCollectionViewCell.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 03/04/21.
//

import UIKit

class RolesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var roleNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        subView.layer.cornerRadius = 10
        subView.layer.borderWidth = 1
        subView.layer.borderColor = Colors.darkBlue.cgColor
    }

    override var isSelected: Bool {
        didSet {
            subView.backgroundColor = isSelected ? Colors.darkBlue : .white
            roleNameLabel.textColor = isSelected ? .white : Colors.darkBlue
        }
    }
}
