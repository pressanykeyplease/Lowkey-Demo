//
//  GradientView.swift
//  Lowkey-Demo
//
//  Created by Eduard on 20.04.2023.
//

import UIKit

final class GradientView : UIView {
    // MARK: - Init
    init(colors: [UIColor]) {
        self.colors = colors
        super.init(frame: .zero)
    }

    // MARK: - Override
    override init(frame: CGRect) {
        super.init(frame: frame)
        gradientLayer.startPoint = CGPoint(x: -0.5, y: -0.5)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.8)
        gradientLayer.type = .axial
        gradientLayer.colors = [
            UIColor.Chat.pollGradientStartColor.cgColor,
            UIColor.Chat.pollGradientEndColor.cgColor
        ]
        layer.addSublayer(gradientLayer)
        gradientLayer.cornerRadius = cornerRadius
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSublayers(of layer: CALayer) {
        assert(layer === self.layer)
        gradientLayer.frame = layer.bounds
    }

    // MARK: - Private properties
    private let gradientLayer = CAGradientLayer()
    private var colors: [UIColor] = []
    private let cornerRadius: CGFloat = 18
}
