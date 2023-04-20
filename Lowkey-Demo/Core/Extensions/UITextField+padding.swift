//
//  UITextField+padding.swift
//  Lowkey-Demo
//
//  Created by Eduard on 20.04.2023.
//

import UIKit

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: .zero, y: .zero, width: amount, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }

    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: .zero, y: .zero, width: amount, height: frame.size.height))
        rightView = paddingView
        rightViewMode = .always
    }
}
