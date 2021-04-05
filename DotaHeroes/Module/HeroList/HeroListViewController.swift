//
//  HeroListViewController.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 01/04/21.
//

import UIKit

class HeroListViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var heroesCollectionView: UICollectionView!
    @IBOutlet weak var heroesCollectionViewBottomConstraint: NSLayoutConstraint!

    private let viewModel: HeroListViewModel
    private var loadingView: LoadingView!
    var router: IHeroListRouter?
    var rolesVC: RolesViewController?
    var isPanelAdded: Bool = false

    init(viewModel: HeroListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponent()
        getHeroList()
    }

    func setupComponent() {
        title = "Dota Heroes"

        viewModel.delegate = self

        heroesCollectionView.dataSource = self
        heroesCollectionView.delegate = self
        heroesCollectionView.registerCellType(HeroListCollectionViewCell.self)

        loadingView = LoadingView()
        loadingView.setup(in: contentView)
        loadingView.reloadButton.touchUpInside(self, action: #selector(getHeroList))
    }

    @objc private func getHeroList() {
        if viewModel.isFiltering {
            rolesVC?.selectAllRoles()
            viewModel.getHeroes()
        } else {
            loadingView.start { [weak self] in
                self?.viewModel.getHeroes()
            }
        }
    }
}

extension HeroListViewController: HeroListViewModelDelegate {
    func didSuccessGetHeroes() {
        loadingView.stop()
        heroesCollectionView.reloadData()

        if !isPanelAdded {
            router?.showRolesPanel(roles: viewModel.roles)
        }
    }

    func didFailGetHeroes(message: String) {
        if !(contentView.subviews.last is LoadingView) {
            loadingView.start { [weak self] in
                self?.loadingView.stop(isFailed: true, message: message)
            }
        } else {
            loadingView.stop(isFailed: true, message: message)
        }
    }
}

extension HeroListViewController: RolesDelegate {
    func didSelectAllRoles() {
        viewModel.getHeroes()
    }

    func didSelectRoles(_ roles: [String]) {
        viewModel.filterHeroesBy(selectedRoles: roles)
    }
}

extension HeroListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.heroList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(HeroListCollectionViewCell.self, for: indexPath)
        cell.hero = viewModel.hero(at: indexPath.item)
        return cell
    }
}

extension HeroListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = viewModel.hero(at: indexPath.item).id
        router?.pushToHeroDetail(id: id)
    }
}

extension HeroListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let initialShowCount: CGFloat = 3
        let padding: CGFloat = (initialShowCount + 1) * 12
        let width: CGFloat = (heroesCollectionView.frame.width - padding) / initialShowCount
        return CGSize(width: width - 2, height: width + 26)
    }
}

extension HeroListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        DispatchQueue.main.async {
            guard let panelTipInset = self.router?.panelTipInset else { return }
            let maxYContentOffset = scrollView.contentSize.height - scrollView.bounds.height + scrollView.contentInset.bottom
            let currentYOffset = scrollView.contentOffset.y
            var bottomConstant: CGFloat = 0

            if currentYOffset >= maxYContentOffset - panelTipInset, maxYContentOffset > 0 {
                guard self.heroesCollectionViewBottomConstraint.constant != panelTipInset else { return }
                bottomConstant = panelTipInset
            } else {
                guard self.heroesCollectionViewBottomConstraint.constant != 0 else { return }
                bottomConstant = 0
            }

            UIView.animate(withDuration: 0.5) {
                self.heroesCollectionViewBottomConstraint.constant = bottomConstant
            }
        }
    }
}
