//
//  ChatViewController.swift
//  Lowkey-Demo
//
//  Created by Eduard on 19.04.2023
//

import UIKit

protocol ChatViewProtocol: AnyObject {
}

class ChatViewController: UIViewController {
    // MARK: - Public
    var presenter: ChatPresenterProtocol?

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: - Private functions
private extension ChatViewController {
    func initialize() {
        navigationItem.titleView = ChatNavigationTitleView(title: "Lowkey Squad", subtitle: "1 member • 1 online")
    }
}

// MARK: - ChatViewProtocol
extension ChatViewController: ChatViewProtocol {
}
