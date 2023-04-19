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
    }
        
    // MARK: - Private properties
    private let userImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = UIConstants.userpicCornerRadius
        view.layer.cornerCurve = .continuous
        view.layer.masksToBounds = true
        return view
    }()
}

// MARK: - Private methods
private extension TextMessageCell {
    func initialize() {
        
    }
}
