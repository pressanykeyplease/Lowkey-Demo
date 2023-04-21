//
//  TextInputCell.swift
//  Lowkey-Demo
//
//  Created by Eduard on 20.04.2023.
//

import SnapKit
import UIKit

protocol TextInputCellDelegate: AnyObject {
    func didUpdateInputCount(from cell: TextInputCell, with count: Int)
}

final class TextInputCell: UITableViewCell {
    // MARK: - Public
    weak var delegate: TextInputCellDelegate?

    func configure(with info: TextFieldCellInfo) {
        textField.attributedPlaceholder = NSAttributedString(
            string: info.placeholder,
            attributes: [.foregroundColor: UIColor.Chat.placeholderColor]
        )
        textField.text = info.text
        lengthLimit = info.lengthLimit
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
    }

    // MARK: - Private properties
    private var lengthLimit: Int? = nil

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
}

// MARK: - Private methods
private extension TextInputCell {
    func initialize() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIConstants.insetX)
            make.top.bottom.equalToSuperview().inset(UIConstants.insetY)
            make.height.equalTo(UIConstants.fieldHeight)
        }
    }
}

// MARK: - UITextFieldDelegate
extension TextInputCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let lengthLimit else { return true }
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        guard count <= lengthLimit else { return false }
        delegate?.didUpdateInputCount(from: self, with: count)
        return true
    }
}
