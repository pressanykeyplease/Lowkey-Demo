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
        titleLabel.text = title
        subtitleLabel.text = subtitle
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private constants
    private enum UIConstatns {
        static let titleFontSize: CGFloat = 16
        static let subtitleFontSize: CGFloat = 12
        static let width: CGFloat = 160
        static let height: CGFloat = 50
    }

    // MARK: - Private properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .semibold, size: UIConstatns.titleFontSize)
        label.textColor = .Navigation.titleColor
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .regular, size: UIConstatns.subtitleFontSize)
        label.textColor = .Navigation.subtitleColor
        return label
    }()
}

// MARK: - Private methods
private extension ChatNavigationTitleView {
    func initialize() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.addArrangedSubview(titleLabel)
        if let _ = subtitleLabel.text {
            stackView.addArrangedSubview(subtitleLabel)
        }
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(UIConstatns.width)
            make.height.equalTo(UIConstatns.height)
        }
    }
}
