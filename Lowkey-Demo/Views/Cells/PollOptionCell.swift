//
//  PollOptionCell.swift
//  Lowkey-Demo
//
//  Created by Eduard on 20.04.2023.
//

import SnapKit
import UIKit

final class PollOptionCell: UITableViewCell {
    // MARK: - Public
    func configure(with info: TextFieldCellInfo) {
        textField.attributedPlaceholder = NSAttributedString(
            string: info.placeholder,
            attributes: [.foregroundColor: UIColor.Chat.placeholderColor]
        )
        textField.text = info.text
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
        static let fontSize: CGFloat = 15
        static let textFieldPadding: CGFloat = 20
        static let textFieldCornerRadius: CGFloat = 12
        static let insetY: CGFloat = 4
        static let insetX: CGFloat = 20
        static let fieldHeight: CGFloat = 51
        static let buttonViewAlpha: CGFloat = 0.1
        static let buttonViewCornerRadius: CGFloat = 12
        static let buttonViewWidth: CGFloat = 50
    }
        
    // MARK: - Private properties
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .Chat.textFieldColor
        field.layer.cornerRadius = UIConstants.textFieldCornerRadius
        field.font = .applying(style: .regular, size: UIConstants.fontSize)
        field.attributedPlaceholder = NSAttributedString(
            string: "",
            attributes: [.foregroundColor: UIColor.Chat.placeholderColor]
        )
        field.textColor = .Chat.textColor
        field.setLeftPaddingPoints(UIConstants.textFieldPadding)
        field.setRightPaddingPoints(UIConstants.textFieldPadding)
        return field
    }()
}

// MARK: - Private methods
private extension PollOptionCell {
    func initialize() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIConstants.insetX)
            make.top.bottom.equalToSuperview().inset(UIConstants.insetY)
            make.height.equalTo(UIConstants.fieldHeight)
        }

        let buttonView = UIView()
        buttonView.backgroundColor = .Chat.pollOptionColor.withAlphaComponent(UIConstants.buttonViewAlpha)
        buttonView.layer.cornerRadius = UIConstants.buttonViewCornerRadius
        buttonView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        contentView.addSubview(buttonView)
        buttonView.snp.makeConstraints { make in
            make.trailing.top.bottom.equalTo(textField)
            make.width.equalTo(UIConstants.buttonViewWidth)
        }
    }
}
