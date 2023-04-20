//
//  ChatToolbar.swift
//  Lowkey-Demo
//
//  Created by Eduard on 20.04.2023.
//

import SnapKit
import UIKit

protocol ChatToolbarDelegate: AnyObject {
    func didTapOptionsButton()
    func didTapSendButton()
}

final class ChatToolbar: UIView {
    // MARK: - Public
    weak var delegate: ChatToolbarDelegate?

    // MARK: - Init
    init() {
        super.init(frame: .zero)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private constants
    private enum UIConstatns {
        static let stackSpacing: CGFloat = 10
        static let buttonSize: CGFloat = 25
        static let textFieldHeight: CGFloat = 35
        static let stackInsetX: CGFloat = 20
        static let stackInsetY: CGFloat = 5
        static let textFieldCornerRadius: CGFloat = 10
        static let fontSize: CGFloat = 15
        static let textFieldPadding: CGFloat = 15
    }

    // MARK: - Private properties
    private lazy var optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.Chat.optionsButtonIcon, for: .normal)
        button.addTarget(self, action: #selector(didTapOptionsButton), for: .touchUpInside)
        return button
    }()

    private let textField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .Chat.textFieldBackgroundColor
        field.layer.cornerRadius = UIConstatns.textFieldCornerRadius
        field.font = .applying(style: .regular, size: UIConstatns.fontSize)
        field.attributedPlaceholder = NSAttributedString(
            string: "Message",
            attributes: [.foregroundColor: UIColor.Chat.placeholderColor]
        )
        field.setLeftPaddingPoints(UIConstatns.textFieldPadding)
        field.setRightPaddingPoints(UIConstatns.textFieldPadding)
        return field
    }()

    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.Chat.sendButtonIcon, for: .normal)
        button.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        return button
    }()
}

// MARK: - Private methods
private extension ChatToolbar {
    func initialize() {
        optionsButton.snp.makeConstraints { make in
            make.size.equalTo(UIConstatns.buttonSize)
        }
        sendButton.snp.makeConstraints { make in
            make.size.equalTo(UIConstatns.buttonSize)
        }
        textField.snp.makeConstraints { make in
            make.height.equalTo(UIConstatns.textFieldHeight)
        }
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = UIConstatns.stackSpacing
        stackView.addArrangedSubview(optionsButton)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(sendButton)
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIConstatns.stackInsetX)
            make.top.bottom.equalToSuperview().inset(UIConstatns.stackInsetY)
        }
    }

    @objc func didTapOptionsButton() {
        delegate?.didTapOptionsButton()
    }

    @objc func didTapSendButton() {
        delegate?.didTapSendButton()
    }
}
