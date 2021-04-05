//
//  RolesViewController.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 03/04/21.
//

import UIKit

protocol RolesDelegate {
    func didSelectAllRoles()
    func didSelectRoles(_ roles: [String])
}

class RolesViewController: UIViewController {
    @IBOutlet weak var rolesCollectionView: UICollectionView!
    @IBOutlet weak var rolesCollectionViewTopConstraint: NSLayoutConstraint!

    var delegate: RolesDelegate?
    private let viewModel: RolesViewModel
    private let initialShowCount: CGFloat = 3
    private var selectedRoles: [String] = []
    private var isFirstLoad: Bool = true

    init(viewModel: RolesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupComponent()
        view.layoutIfNeeded()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isFirstLoad {
            isFirstLoad = false
            selectAllRoles(shouldCallDelegate: false)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rolesCollectionViewTopConstraint.constant = 12
        view.layoutIfNeeded()
    }

    func setupComponent() {
        rolesCollectionView.allowsMultipleSelection = true
        rolesCollectionView.dataSource = self
        rolesCollectionView.delegate = self
        rolesCollectionView.registerCellType(RolesCollectionViewCell.self)
    }

    private func selectItem(at indexPath: IndexPath, shouldCallDelegate: Bool = true) {
        _ = rolesCollectionView.delegate?.collectionView?(rolesCollectionView, shouldSelectItemAt: indexPath)
        rolesCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)

        if shouldCallDelegate {
            rolesCollectionView.delegate?.collectionView?(rolesCollectionView, didSelectItemAt: indexPath)
        }
    }

    private func deselectItem(at indexPath: IndexPath) {
        _ = rolesCollectionView.delegate?.collectionView?(rolesCollectionView, shouldDeselectItemAt: indexPath)
        rolesCollectionView.deselectItem(at: indexPath, animated: true)
        rolesCollectionView.delegate?.collectionView?(rolesCollectionView, didDeselectItemAt: indexPath)
    }

    func selectAllRoles(shouldCallDelegate: Bool = true) {
        let firstIndexPath = IndexPath(item: 0, section: 0)
        selectItem(at: firstIndexPath, shouldCallDelegate: shouldCallDelegate)
    }
}

extension RolesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return indexPath.item != 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let role = viewModel.role(at: indexPath.item)

        if role == "ALL" {
            delegate?.didSelectAllRoles()

            for i in 1 ..< viewModel.roles.count {
                let indexPath = IndexPath(item: i, section: 0)
                deselectItem(at: indexPath)
            }

            selectedRoles.removeAll()
        } else {
            let firstIndexPath = IndexPath(item: 0, section: 0)
            deselectItem(at: firstIndexPath)

            selectedRoles.append(role)
            delegate?.didSelectRoles(selectedRoles)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let role = viewModel.role(at: indexPath.item)

        if let index = selectedRoles.firstIndex(of: role) {
            selectedRoles.remove(at: index)

            if selectedRoles.isEmpty {
                delegate?.didSelectAllRoles()
                selectAllRoles()
            } else {
                delegate?.didSelectRoles(selectedRoles)
            }
        }
    }
}

extension RolesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.roles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(RolesCollectionViewCell.self, for: indexPath)
        cell.roleNameLabel.text = viewModel.role(at: indexPath.item)
        return cell
    }
}

extension RolesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = (initialShowCount + 1) * 12
        let width: CGFloat = (collectionView.frame.size.width - padding) / initialShowCount
        return CGSize(width: width - 2, height: 40)
    }
}
