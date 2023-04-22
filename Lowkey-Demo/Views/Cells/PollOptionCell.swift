//
//  PollOptionCell.swift
//  Lowkey-Demo
//
//  Created by Eduard on 20.04.2023.
//

import SnapKit
import UIKit

protocol PollOptionCellDelegate: AnyObject {
    func didUpdateInput(from cell: PollOptionCell, with text: String?)
}

final class PollOptionCell: UITableViewCell {
    // MARK: - Public
    weak var delegate: PollOptionCellDelegate?

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
        static let textFieldPadding: CGFloat = 15
        static let textFieldCornerRadius: CGFloat = 12
        static let insetY: CGFloat = 4
        static let insetX: CGFloat = 20
        static let fieldHeight: CGFloat = 51
        static let buttonViewAlpha: CGFloat = 0.1
        static let buttonViewCornerRadius: CGFloat = 12
        static let buttonViewWidth: CGFloat = 50
        static let removeButtonSize: CGFloat = 30
        static let buttonContentInset: CGFloat = 8
    }
        
    // MARK: - Private properties
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.delegate = self
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

    private lazy var removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.contentEdgeInsets = UIEdgeInsets(top: UIConstants.buttonContentInset,
                                                left: UIConstants.buttonContentInset,
                                                bottom: UIConstants.buttonContentInset,
                                                right: UIConstants.buttonContentInset)
        return button
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

        buttonView.addSubview(removeButton)
        removeButton.snp.makeConstraints { make in
            make.size.equalTo(UIConstants.removeButtonSize)
            make.center.equalTo(buttonView)
        }
    }
}

// MARK: - UITextFieldDelegate
extension PollOptionCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let replacementRange = Range(range, in: textFieldText) else { return true }
       
        let text = textFieldText.replacingCharacters(in: replacementRange, with: string)
        delegate?.didUpdateInput(from: self, with: text)
        return true
    }
}
