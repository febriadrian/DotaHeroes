//
//  HeroDetailViewController.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 04/04/21.
//

import UIKit

class HeroDetailViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var rolesLabel: UILabel!

    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var agilityLabel: UILabel!
    @IBOutlet weak var intelligenceLabel: UILabel!
    @IBOutlet weak var damageLabel: UILabel!
    @IBOutlet weak var armorLabel: UILabel!
    @IBOutlet weak var moveSpeedLabel: UILabel!

    @IBOutlet weak var baseHPLabel: UILabel!
    @IBOutlet weak var baseHPRegenLabel: UILabel!
    @IBOutlet weak var baseManaLabel: UILabel!
    @IBOutlet weak var baseManaRegenLabel: UILabel!
    @IBOutlet weak var baseAttackTimeLabel: UILabel!
    @IBOutlet weak var attackRangeLabel: UILabel!

    @IBOutlet weak var heroesCollectionView: UICollectionView!
    @IBOutlet var headerViews: [UIView]!

    private let viewModel: HeroDetailViewModel
    private var loadingView: LoadingView!
    var router: IHeroDetailRouter?

    init(viewModel: HeroDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponent()
        viewModel.getHeroDetail()
    }

    private func setupComponent() {
        title = "Hero Detail"

        viewModel.delegate = self

        heroesCollectionView.dataSource = self
        heroesCollectionView.delegate = self
        heroesCollectionView.registerCellType(HeroListCollectionViewCell.self)

        loadingView = LoadingView()
        loadingView.setup(in: contentView)
        loadingView.reloadButton.touchUpInside(self, action: #selector(getHeroDetail))

        headerViews.forEach { view in
            view.backgroundColor = Colors.lightBlue
        }
    }

    @objc private func getHeroDetail() {
        loadingView.start { [weak self] in
            self?.viewModel.getHeroDetail()
        }
    }
}

extension HeroDetailViewController: HeroDetailViewModelDelegate {
    func didSuccessGetHeroDetail(detail: HeroDetailModel) {
        loadingView.stop()

        heroImageView.kf.indicatorType = .activity
        heroImageView.kf.setImage(with: detail.imageUrl)

        nameLabel.text = detail.name
        typeLabel.text = detail.type
        rolesLabel.text = detail.roles

        strengthLabel.text = detail.strength
        agilityLabel.text = detail.agility
        intelligenceLabel.text = detail.intelligence
        damageLabel.text = detail.damage
        armorLabel.text = detail.armor
        moveSpeedLabel.text = detail.moveSpeed

        baseHPLabel.text = detail.baseHealth
        baseHPRegenLabel.text = detail.baseHealthRegen
        baseManaLabel.text = detail.baseMana
        baseManaRegenLabel.text = detail.baseManaRegen
        baseAttackTimeLabel.text = detail.baseAttackTime
        attackRangeLabel.text = detail.attackRange

        heroesCollectionView.reloadData()
    }

    func didFailGetHeroDetail(message: String) {
        loadingView.stop(isFailed: true, message: message)
    }
}

extension HeroDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.similarHeroes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(HeroListCollectionViewCell.self, for: indexPath)
        cell.hero = viewModel.hero(at: indexPath.item)
        return cell
    }
}

extension HeroDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = viewModel.hero(at: indexPath.item).id
        router?.pushToHeroDetail(id: id)
    }
}

extension HeroDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let initialShowCount: CGFloat = 3
        let padding: CGFloat = (initialShowCount + 1) * 12
        let width: CGFloat = (heroesCollectionView.frame.width - padding) / initialShowCount
        return CGSize(width: width - 2, height: width + 26)
    }
}
