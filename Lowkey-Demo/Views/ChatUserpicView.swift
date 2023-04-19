//
//  ChatUserpicView.swift
//  Lowkey-Demo
//
//  Created by Eduard on 19.04.2023.
//

import SnapKit
import UIKit

final class ChatUserpicView: UIView {
    // MARK: - Init
    init(imgae: UIImage?) {
        super.init(frame: .zero)
        imageView.image = imgae
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private constants
    private enum UIConstatns {
        static let cornerRadius: CGFloat = 12
        static let size: CGFloat = 35
    }

    // MARK: - Private properties
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = UIConstatns.cornerRadius
        view.layer.cornerCurve = .continuous
        view.layer.masksToBounds = true
        return view
    }()
}

// MARK: - Private methods
private extension ChatUserpicView {
    func initialize() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.size.equalTo(UIConstatns.size)
        }
    }
}
