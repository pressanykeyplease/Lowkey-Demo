//
//  UILabel+style.swift
//  Lowkey-Demo
//
//  Created by Eduard on 19.04.2023.
//

import UIKit

extension UILabel {
    func apply(style: LabelStyle, size: CGFloat) {
        font = UIFont(name: style.rawValue, size: size)
    }

    enum LabelStyle: String {
        case medium = "Poppins-Medium"
        case regular = "Poppins-Regular"
        case semibold = "Poppins-SemiBold"
    }
}
