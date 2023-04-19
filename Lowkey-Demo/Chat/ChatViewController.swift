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

    // MARK: - Private properties
    private let tableView = UITableView()
    private var messages: [MessageInfo] = []
}

// MARK: - Private functions
private extension ChatViewController {
    func initialize() {
        configureNavigationBar()
        configureTableView()
    }

    func configureNavigationBar() {
        navigationItem.titleView = ChatNavigationTitleView(title: "Lowkey Squad", subtitle: "1 member • 1 online")
        navigationItem.leftBarButtonItem = makeLeftBarButtonItem()
        navigationItem.rightBarButtonItem = makeRightBarButtonItem()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .Navigation.backgroundColor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    func configureTableView() {
        tableView.dataSource = self
        tableView.register(TextMessageCell.self, forCellReuseIdentifier: String(describing: TextMessageCell.self))
        tableView.register(PollCell.self, forCellReuseIdentifier: String(describing: PollCell.self))
    }

    func makeLeftBarButtonItem() -> UIBarButtonItem {
        let image = UIImage(systemName: "xmark")
        let leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showInProgressAlert))
        leftBarButtonItem.tintColor = .Navigation.tintColor
        return leftBarButtonItem
    }

    func makeRightBarButtonItem() -> UIBarButtonItem {
        let image = UIImage(named: "elon-musk")
        let userpicView = ChatUserpicView(imgae: image)
        let rightBarButtonItem = UIBarButtonItem(customView: userpicView)
        return rightBarButtonItem
    }

    @objc func showInProgressAlert() {
        let alert = UIAlertController(title: "In progress", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - ChatViewProtocol
extension ChatViewController: ChatViewProtocol {
}

// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        switch message {
        case .text(let info):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TextMessageCell.self), for: indexPath) as! TextMessageCell
            cell.configure(with: info)
            return cell
        case .poll(let info):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PollCell.self), for: indexPath) as! PollCell
            cell.configure(with: info)
            return cell
        }
    }
}
