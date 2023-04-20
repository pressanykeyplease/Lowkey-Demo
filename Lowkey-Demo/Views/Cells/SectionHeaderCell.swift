//
//  SectionHeaderCell.swift
//  Lowkey-Demo
//
//  Created by Eduard on 20.04.2023.
//

import SnapKit
import UIKit

final class SectionHeaderCell: UITableViewCell {
    // MARK: - Public
    func configure(with info: SectionHeaderInfo) {
        titleLabel.text = info.title
        secondaryTitleLabel.text = info.secondaryTitle
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
        static let fontSize: CGFloat = 12
        static let topInset: CGFloat = 21
        static let bottomInset: CGFloat = 6
        static let insetX: CGFloat = 20
    }
        
    // MARK: - Private properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .regular, size: UIConstants.fontSize)
        label.textColor = .Navigation.sectionHeaderTextColor
        return label
    }()

    private let secondaryTitleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .regular, size: UIConstants.fontSize)
        label.textColor = .Navigation.sectionHeaderTextColor
        return label
    }()
}

// MARK: - Private methods
private extension SectionHeaderCell {
    func initialize() {
        selectionStyle = .none
        backgroundColor = .clear
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(secondaryTitleLabel)
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.topInset)
            make.bottom.equalToSuperview().inset(UIConstants.bottomInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.insetX)
        }
    }
}
