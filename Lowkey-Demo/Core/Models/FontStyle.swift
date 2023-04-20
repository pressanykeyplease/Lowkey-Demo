//
//  FontStyle.swift
//  Lowkey-Demo
//
//  Created by Eduard on 20.04.2023.
//

import UIKit

enum FontStyle: String {
    case medium = "Poppins-Medium"
    case regular = "Poppins-Regular"
    case semibold = "Poppins-SemiBold"
}

extension UIFont {
    static func applying(style: FontStyle, size: CGFloat) -> UIFont {
        UIFont(name: style.rawValue, size: size)!
    }
}
