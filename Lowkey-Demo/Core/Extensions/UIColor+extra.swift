//
//  UIColor+extra.swift
//  Lowkey-Demo
//
//  Created by Eduard on 19.04.2023.
//

import UIKit

extension UIColor {
    struct Navigation {
        static var tintColor: UIColor { HEX.hFEFEFE }
        static var backgroundColor: UIColor { HEX.h1C1A2A }
        static var subtitleColor: UIColor { HEX.h7E7A9A }
        static var inactiveButtonColor: UIColor { HEX.h7E7A9A }
        static var activeButtonColor: UIColor { HEX.h1C6EF2 }
    }

    struct Chat {
        static var nameLabelColor: UIColor { HEX.h7E7A9A }
        static var messageLabelColor: UIColor { HEX.hFEFEFE }
        static var backgroundColor: UIColor { HEX.h14131B }
        static var votesViewColor: UIColor { HEX.hAC1393 }
        static var textColor: UIColor { HEX.hFEFEFE }
        static var pollGradientStartColor: UIColor { HEX.hA83D7F }
        static var pollGradientEndColor: UIColor { HEX.h0A0D26 }
        static var textFieldBackgroundColor: UIColor { HEX.h2E2C3C }
        static var placeholderColor: UIColor { HEX.h7E7A9A }
        static var pollOptionColor: UIColor { HEX.h1C6EF2 }
    }

    fileprivate struct HEX {
        static let hFEFEFE = UIColor(hex: 0xFEFEFE)
        static let h7E7A9A = UIColor(hex: 0x7E7A9A)
        static let h1C1A2A = UIColor(hex: 0x1C1A2A)
        static let h14131B = UIColor(hex: 0x14131B)
        static let hAC1393 = UIColor(hex: 0xAC1393)
        static let hA83D7F = UIColor(hex: 0xA83D7F)
        static let h0A0D26 = UIColor(hex: 0x0A0D26)
        static let h2E2C3C = UIColor(hex: 0x2E2C3C)
        static let h1C6EF2 = UIColor(hex: 0x1C6EF2)
    }
}

extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }

    convenience init(hex: String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
        }
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    func hexString() -> String {
        let components = self.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String.init(format: "%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
    }
}
