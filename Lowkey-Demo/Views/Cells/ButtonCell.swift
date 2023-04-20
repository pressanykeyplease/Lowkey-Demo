//
//  ButtonCell.swift
//  Lowkey-Demo
//
//  Created by Eduard on 20.04.2023.
//

import SnapKit
import UIKit

protocol ButtonCellDelegate: AnyObject {
    func didTapButton()
}

final class ButtonCell: UITableViewCell {
    // MARK: - Public
    weak var delegate: ButtonCellDelegate?

    func configure(with title: String) {
        button.setTitle(title, for: .normal)
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
        static let cornerRadius: CGFloat = 12
        static let insetY: CGFloat = 4
        static let insetX: CGFloat = 20
        static let height: CGFloat = 51
        static let contentInset: CGFloat = 15
    }
        
    // MARK: - Private properties
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.titleLabel?.apply(style: .regular, size: UIConstants.fontSize)
        button.titleLabel?.textColor = .Navigation.activeButtonColor
        button.layer.cornerRadius = UIConstants.cornerRadius
        button.backgroundColor = .Chat.textFieldColor
        button.contentHorizontalAlignment = .leading
        button.contentEdgeInsets = UIEdgeInsets(top: .zero,
                                                left: UIConstants.contentInset,
                                                bottom: .zero,
                                                right: UIConstants.contentInset)
        return button
    }()
}

// MARK: - Private methods
private extension ButtonCell {
    func initialize() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIConstants.insetX)
            make.top.bottom.equalToSuperview().inset(UIConstants.insetY)
            make.height.equalTo(UIConstants.height)
        }
    }

    @objc func didTapButton() {
        delegate?.didTapButton()
    }
}
