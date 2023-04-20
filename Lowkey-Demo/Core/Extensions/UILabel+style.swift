//
//  UILabel+style.swift
//  Lowkey-Demo
//
//  Created by Eduard on 19.04.2023.
//

import UIKit

extension UILabel {
    func apply(style: FontStyle, size: CGFloat) {
        font = .applying(style: style, size: size)
    }
}
