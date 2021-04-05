//
//  DHFloatingPanelLayout.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 04/04/21.
//

import FloatingPanel

class DHFloatingPanelLayout: FloatingPanelLayout {
    var fullHeight: CGFloat?
    var supportedPositions: Set<FloatingPanelPosition> {
        return [.full, .tip]
    }

    var initialPosition: FloatingPanelPosition {
        return .tip
    }

    func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full:
            return fullHeight ?? 0
        case .tip:
            let screenType = UIDevice().screenType
            switch screenType {
            case .iPhones_X_XS,
                 .iPhone_XR_11,
                 .iPhone_11Pro,
                 .iPhone_XSMax_ProMax_11Pro_Max,
                 .iPhone_12_12Pro,
                 .iPhone_12_Pro_Max,
                 .iPhone_12_Mini:
                return 46
            default:
                return 72
            }
        default:
            return nil
        }
    }
}
