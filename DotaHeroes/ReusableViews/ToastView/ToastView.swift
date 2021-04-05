//
//  ToastView.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 01/04/21.
//

import UIKit

class ToastView: CustomXIBView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var messageLabel: UILabel!

    override func setupComponent() {
        contentView.fixInView(self)
    }
}
