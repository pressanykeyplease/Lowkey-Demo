//
//  TextMessageCell.swift
//  Lowkey-Demo
//
//  Created by Eduard on 19.04.2023.
//

import SnapKit
import UIKit

final class TextMessageCell: UITableViewCell {
    // MARK: - Public
    func configure(with info: TextMessageInfo) {
        
    }

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private constants
    private enum UIConstants {
        static let userpicSize: CGFloat = 40
        static let userpicCornerRadius: CGFloat = 12
        static let userpicTopInset: CGFloat = 6
        static let userpicLeadingInset: CGFloat = 15
        static let userpicToTextOffset: CGFloat = 15
        static let nameFontSize: CGFloat = 12
        static let messageFontSize: CGFloat = 15
    }
        
    // MARK: - Private properties
    private let userImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = UIConstants.userpicCornerRadius
        view.layer.cornerCurve = .continuous
        view.layer.masksToBounds = true
        return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .semibold, size: UIConstants.nameFontSize)
        label.textColor = .Chat.nameLabelColor
        return label
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .regular, size: UIConstants.messageFontSize)
        label.textColor = .Chat.messageLabelColor
        return label
    }()
}

// MARK: - Private methods
private extension TextMessageCell {
    func initialize() {
        
    }
}
