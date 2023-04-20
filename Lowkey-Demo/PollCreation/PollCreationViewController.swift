//
//  PollCreationViewController.swift
//  Super easy dev
//
//  Created by Eduard on 19.04.2023
//

import UIKit

protocol PollCreationViewProtocol: AnyObject {
}

class PollCreationViewController: UIViewController {
    // MARK: - Public
    var presenter: PollCreationPresenterProtocol?

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: - Private functions
private extension PollCreationViewController {
    func initialize() {
        view.backgroundColor = .Chat.backgroundColor
        navigationItem.titleView = ChatNavigationTitleView(title: "New Poll", subtitle: nil)
        navigationItem.leftBarButtonItem = makeLeftBarButtonItem()
        navigationItem.rightBarButtonItem = makeRightBarButtonItem()
    }

    func makeLeftBarButtonItem() -> UIBarButtonItem {
        let image = UIImage(systemName: "xmark")
        let leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(didTapDismissButton))
        leftBarButtonItem.tintColor = .Navigation.tintColor
        return leftBarButtonItem
    }

    func makeRightBarButtonItem() -> UIBarButtonItem {
        let customView = BarButtonItem()
        customView.configure(with: "Create")
        customView.set(isActive: false)
        let item = UIBarButtonItem(customView: customView)
        return item
    }

    @objc func didTapDismissButton() {
        dismiss(animated: true)
    }
}

// MARK: - PollCreationViewProtocol
extension PollCreationViewController: PollCreationViewProtocol {
}
