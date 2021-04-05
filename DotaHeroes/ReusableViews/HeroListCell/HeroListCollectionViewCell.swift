//
//  HeroListCollectionViewCell.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 03/04/21.
//

import UIKit

class HeroListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!

    var hero: HeroListModel? {
        didSet {
            guard let hero = hero else { return }
            heroNameLabel.text = hero.name
            heroImageView.kf.indicatorType = .activity
            heroImageView.kf.setImage(with: hero.imageUrl)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        subView.layer.cornerRadius = 10
        subView.layer.borderWidth = 1
        subView.layer.borderColor = Colors.greyText.cgColor
    }
}
