//
//  PollCell.swift
//  Lowkey-Demo
//
//  Created by Eduard on 19.04.2023.
//

import SnapKit
import UIKit

final class PollCell: UITableViewCell {
    // MARK: - Public
    func configure(with info: PollInfo) {
        
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
        static let userpicSize: CGFloat = 36
        static let userpicCornerRadius: CGFloat = 12
        static let pollTypeFontSize: CGFloat = 10
        static let nameFontSize: CGFloat = 12
        static let messageFontSize: CGFloat = 15
        static let votesCountFontSize: CGFloat = 16
        static let votesFontSize: CGFloat = 10
        static let optionFontSize: CGFloat = 12
    }
        
    // MARK: - Private properties
    private let userpicView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = UIConstants.userpicCornerRadius
        view.layer.cornerCurve = .continuous
        view.layer.masksToBounds = true
        return view
    }()

    private let pollTypeLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .regular, size: UIConstants.pollTypeFontSize)
        label.textColor = .Chat.nameLabelColor
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .semibold, size: UIConstants.nameFontSize)
        label.textColor = .Chat.nameLabelColor
        return label
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .medium, size: UIConstants.messageFontSize)
        label.textColor = .Chat.messageLabelColor
        label.numberOfLines = .zero
        return label
    }()

    private let votesCountLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .semibold, size: UIConstants.votesCountFontSize)
        label.textColor = .Chat.nameLabelColor
        return label
    }()

    private let votesLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .semibold, size: UIConstants.votesFontSize)
        label.textColor = .Chat.nameLabelColor
        return label
    }()
}

// MARK: - Private methods
private extension PollCell {
    func initialize() {
        selectionStyle = .none
        backgroundColor = .clear
        
    }
}
