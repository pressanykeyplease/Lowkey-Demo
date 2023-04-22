//
//  BarButtonItem.swift
//  Lowkey-Demo
//
//  Created by Eduard on 20.04.2023.
//

import SnapKit
import UIKit

protocol BarButtonItemDelegate: AnyObject {
    func didTapBarButton()
}

final class BarButtonItem: UIView {
    // MARK: - Public
    func configure(with title: String) {
        button.setTitle(title, for: .normal)
    }

    func set(isActive: Bool) {
        isActive ? configureForActiveState() : configureForInactiveState()
    }

    weak var delegate: BarButtonItemDelegate?

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
        static let fontSize: CGFloat = 14
    }

    // MARK: - Private properties
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.titleLabel?.apply(style: .medium, size: UIConstatns.fontSize)
        return button
    }()
}

// MARK: - Private methods
private extension BarButtonItem {
    func initialize() {
        addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configureForActiveState() {
        button.tintColor = .Navigation.activeButtonColor
        button.isEnabled = true
    }

    func configureForInactiveState() {
        button.tintColor = .Navigation.inactiveButtonColor
        button.isEnabled = false
    }

    @objc func didTapButton() {
        delegate?.didTapBarButton()
    }
}
