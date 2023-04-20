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

    // MARK: - Override
    override var canBecomeFirstResponder: Bool {
        true
    }

    override var inputAccessoryView: UIView? {
        toolbar
    }

    // MARK: - Private constants
    private enum UIConstants {
        static let tableViewBottomInset: CGFloat = 45
    }

    // MARK: - Private properties
    private let tableView = UITableView()
    private let toolbar = ChatToolbar()

    private var messages: [MessageInfo] = [
        .text(TextMessageInfo(userpic: UIImage(named: "elon-musk"), name: "Elon Musk", message: "Nice! 12 ppl in total. Let’s gather at the metro station!🚆🚆🚆")),
        .text(TextMessageInfo(userpic: UIImage(named: "elon-musk"), name: "Elon Musk", message: "Nice! 12 ppl in total. Let’s gather at the metro station!🚆🚆🚆")),
        .text(TextMessageInfo(userpic: UIImage(named: "elon-musk"), name: "Elon Musk", message: "Nice! 12 ppl in total. Let’s gather at the metro station!🚆🚆🚆")),
        .text(TextMessageInfo(userpic: UIImage(named: "elon-musk"), name: "Elon Musk", message: "Nice! 12 ppl in total. Let’s gather at the metro station!🚆🚆🚆")),
        .poll(PollInfo(userpic: UIImage(named: "elon-musk"), pollType: "Public Poll", username: "Elon Musk", message: "What is the greatest NBA team in the history?", numberOfVotes: 3, options: ["Los Angeles Lakers", "Golden State Warriors", "Chicago Bulls", "Boston Celtics"], selectedOption: 0))
    ]
}

// MARK: - Private functions
private extension ChatViewController {
    func initialize() {
        configureNavigationBar()
        configureTableView()
        configureToolbar()
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
        view.backgroundColor = .Chat.backgroundColor
        tableView.keyboardDismissMode = .interactive
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(TextMessageCell.self, forCellReuseIdentifier: String(describing: TextMessageCell.self))
        tableView.register(PollCell.self, forCellReuseIdentifier: String(describing: PollCell.self))
        tableView.backgroundColor = .Chat.backgroundColor
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(UIConstants.tableViewBottomInset)
        }
    }

    func configureToolbar() {
        view.addSubview(toolbar)
        toolbar.delegate = self
        toolbar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
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

// MARK: - ChatToolbarDelegate
extension ChatViewController: ChatToolbarDelegate {
    func didTapOptionsButton() {
//        textField.resignFirstResponder()
//        showInProgressAlert()
    }

    func didTapSendButton() {
//        textField.resignFirstResponder()
//        showInProgressAlert()
    }
}
