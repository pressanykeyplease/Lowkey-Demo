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

    // MARK: - Private constants
    private enum UIConstants {
        
    }
}

// MARK: - Private functions
private extension ChatViewController {
    func initialize() {
        configureNavigationBar()
    }

    func configureNavigationBar() {
        navigationItem.titleView = ChatNavigationTitleView(title: "Lowkey Squad", subtitle: "1 member • 1 online")
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: nil)
        leftBarButtonItem.tintColor = .Navigation.tintColor
        navigationItem.leftBarButtonItem = leftBarButtonItem
        let userpicView = ChatUserpicView(imgae: UIImage(named: "elon-musk"))
        let rightBarButtonItem = UIBarButtonItem(customView: userpicView)
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}

// MARK: - ChatViewProtocol
extension ChatViewController: ChatViewProtocol {
}
