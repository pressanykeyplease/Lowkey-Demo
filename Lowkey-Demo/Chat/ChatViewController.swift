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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
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
        static let navigationBarDefaultHeight: CGFloat = 44
    }

    // MARK: - Private properties
    private let tableView = UITableView()
    private let toolbar = ChatToolbar()

    private var messages: [MessageInfo] = [
        .text(TextMessageInfo(userpic: UIImage(named: "elon-musk"), name: "Elon Musk", message: "I’m in also! Mike’s Diner would be a good choice 🔥🔥🔥 how about everyone else? Any ideas?")),
        .text(TextMessageInfo(userpic: UIImage(named: "elon-musk"), name: "Elon Musk", message: "Sounds good to me!!!")),
        .text(TextMessageInfo(userpic: UIImage(named: "elon-musk"), name: "Elon Musk", message: "@kellyhodges are you in???")),
        .text(TextMessageInfo(userpic: UIImage(named: "elon-musk"), name: "Elon Musk", message: "Nice! 12 ppl in total. Let’s gather at the metro station!🚆🚆🚆")),
        .text(TextMessageInfo(userpic: UIImage(named: "elon-musk"), name: "Elon Musk", message: "Okie dokie!!")),
        .poll(PollInfo(userpic: UIImage(named: "elon-musk"), pollType: "Public Poll", username: "Elon Musk", message: "What is the greatest NBA team in the history?", numberOfVotes: 3, options: ["Los Angeles Lakers", "Golden State Warriors", "Chicago Bulls", "Boston Celtics"], selectedOption: nil))
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
        let navigationBarHeight = navigationController?.navigationBar.bounds.height ?? UIConstants.navigationBarDefaultHeight
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(navigationBarHeight)
            make.leading.trailing.equalToSuperview()
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
        let userpicView = ChatUserpicView(image: image)
        let rightBarButtonItem = UIBarButtonItem(customView: userpicView)
        return rightBarButtonItem
    }

    @objc func showInProgressAlert() {
        let alert = UIAlertController(title: "In progress", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func scrollToBottomMessage() {
        guard !messages.isEmpty else { return }
        let bottomMessageIndex = IndexPath(row: messages.count - 1, section: .zero)
        tableView.scrollToRow(at: bottomMessageIndex, at: .bottom, animated: true)
    }

    func send(message: MessageInfo) {
        messages.append(message)
        tableView.reloadData()
        scrollToBottomMessage()
    }

    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification {
            tableView.contentInset = .zero
        } else {
            tableView.contentInset = UIEdgeInsets(top: .zero, left: .zero, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: .zero)
        }
        tableView.scrollIndicatorInsets = tableView.contentInset
        scrollToBottomMessage()
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
            cell.delegate = self
            cell.configure(with: info)
            return cell
        }
    }
}

// MARK: - ChatToolbarDelegate
extension ChatViewController: ChatToolbarDelegate {
    func didTapOptionsButton() {
        presenter?.didTapCreatePoll()
    }

    func didTapSendButton() {
        guard let text = toolbar.getText(), !text.isEmpty else { return }
        toolbar.clearTextfield()
        let info = TextMessageInfo(userpic: UIImage(named: "elon-musk"),
                                   name: "Elon Musk",
                                   message: text)
        send(message: .text(info))
    }
}

// MARK: - PollCreationViewDelegate
extension ChatViewController: PollCreationViewDelegate {
    func didCreatePoll(with info: PollInfo) {
        send(message: .poll(info))
    }
}

// MARK: - PollCellDelegate
extension ChatViewController: PollCellDelegate {
    func didTapVote(from cell: PollCell, index: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        guard case var .poll(info) = messages[indexPath.row] else { return }
        if let _ = info.selectedOption { return }
        info.selectedOption = index
        info.numberOfVotes += 1
        messages[indexPath.row] = .poll(info)
        cell.vote(at: index)
    }
}
