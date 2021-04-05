//
//  HeroListRouter.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 03/04/21.
//

import FloatingPanel
import UIKit

protocol IHeroListRouter: class {
    var panelTipInset: CGFloat? { get }

    func showRolesPanel(roles: [String])
    func pushToHeroDetail(id: Int)
}

class HeroListRouter: IHeroListRouter {
    weak var view: HeroListViewController?
    var panelTipInset: CGFloat?
    private var roles: [String] = []

    init(view: HeroListViewController?) {
        self.view = view
    }

    func showRolesPanel(roles: [String]) {
        guard let view = view else { return }
        self.roles = roles
        let roleVC = RolesFactory.setup(roles: roles)
        roleVC.delegate = view
        view.rolesVC = roleVC

        let fpcHeight = setFPCHeight()
        let fpc = FloatingPanelController()
        fpc.delegate = self
        fpc.set(contentViewController: roleVC)
        fpc.surfaceView.cornerRadius = 10
        fpc.surfaceView.shadowHidden = false
        fpc.isRemovalInteractionEnabled = false
        fpc.surfaceView.borderWidth = 1.0 / view.traitCollection.displayScale
        fpc.surfaceView.borderColor = UIColor.black.withAlphaComponent(0.5)
        fpc.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: fpcHeight)
        fpc.addPanel(toParent: view)
        view.isPanelAdded = true
    }

    private func setFPCHeight() -> CGFloat {
        let topInset = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
        let navBarHeight = view?.navigationController?.navigationBar.frame.height ?? 20
        return UIScreen.main.bounds.height - navBarHeight - topInset
    }

    func pushToHeroDetail(id: Int) {
        let module = DHRoute.heroDetail(id: id)
        view?.navigate(type: .push, module: module)
    }
}

extension HeroListRouter: FloatingPanelControllerDelegate {
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        let layout = DHFloatingPanelLayout()
        let fpcHeight = setFPCHeight()
        panelTipInset = layout.insetFor(position: .tip)

        let screenType = UIDevice().screenType
        switch screenType {
        case .iPhones_X_XS,
             .iPhone_XR_11,
             .iPhone_11Pro,
             .iPhone_XSMax_ProMax_11Pro_Max,
             .iPhone_12_12Pro,
             .iPhone_12_Pro_Max,
             .iPhone_12_Mini:
            layout.fullHeight = fpcHeight - 256
        default:
            layout.fullHeight = fpcHeight - 232
        }
        return layout
    }
}
