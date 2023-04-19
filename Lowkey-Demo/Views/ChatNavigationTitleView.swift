//
//  ChatNavigationTitleView.swift
//  Lowkey-Demo
//
//  Created by Eduard on 19.04.2023.
//

import SnapKit
import UIKit

final class ChatNavigationTitleView: UIView {
    // MARK: - Init
    init(title: String, subtitle: String?) {
        super.init(frame: .zero)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private constants
    private enum UIConstatns {
        static let titleFontSize: CGFloat = 16
        static let subtitleFontSize: CGFloat = 12
    }

    // MARK: - Private properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .semibold, size: UIConstatns.titleFontSize)
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .regular, size: UIConstatns.subtitleFontSize)
        return label
    }()
}

// MARK: - Private methods
private extension ChatNavigationTitleView {
    func initialize() {
        
    }
}
