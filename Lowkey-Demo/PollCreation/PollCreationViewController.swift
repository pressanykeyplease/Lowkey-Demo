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

    // MARK: - Private constants
    private let titleMaxLength = 140

    // MARK: - Private properties
    private let tableView = UITableView()
    private lazy var rows: [PollRowType] = [
        .header(.init(title: "Question", secondaryTitle: "0/\(titleMaxLength)")),
        .textField(.init(placeholder: "Ask a question", text: nil, lengthLimit: titleMaxLength)),
        .header(.init(title: "Options", secondaryTitle: "0/8")),
        .option(.init(placeholder: "Place some text here", text: nil, lengthLimit: nil)),
        .option(.init(placeholder: "Place some text here", text: nil, lengthLimit: nil)),
        .option(.init(placeholder: "Place some text here", text: nil, lengthLimit: nil)),
        .button("Add an option")
    ]
}

// MARK: - Private functions
private extension PollCreationViewController {
    func initialize() {
        configureNavigationBar()
        configureTableView()
    }

    func configureNavigationBar() {
        view.backgroundColor = .Chat.backgroundColor
        navigationItem.titleView = ChatNavigationTitleView(title: "New Poll", subtitle: nil)
        navigationItem.leftBarButtonItem = makeLeftBarButtonItem()
        navigationItem.rightBarButtonItem = makeRightBarButtonItem()
        navigationController?.navigationBar.backgroundColor = .Navigation.presentedViewNavigationBarColor
    }

    func configureTableView() {
        tableView.keyboardDismissMode = .interactive
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(SectionHeaderCell.self, forCellReuseIdentifier: String(describing: SectionHeaderCell.self))
        tableView.register(TextInputCell.self, forCellReuseIdentifier: String(describing: TextInputCell.self))
        tableView.register(PollOptionCell.self, forCellReuseIdentifier: String(describing: PollOptionCell.self))
        tableView.register(ButtonCell.self, forCellReuseIdentifier: String(describing: ButtonCell.self))
        tableView.backgroundColor = .Chat.backgroundColor
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
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

    func updateHeaderCellInput(with count: Int) {
        // In a real situation we would calculate that header's IndexPath
        let indexPath = IndexPath(row: .zero, section: .zero)
        guard case .header(var info) = rows[.zero] else { return }
        info.secondaryTitle = "\(count)/\(titleMaxLength)"
        rows[.zero] = .header(info)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

// MARK: - PollCreationViewProtocol
extension PollCreationViewController: PollCreationViewProtocol {
}

// MARK: - UITableViewDataSource
extension PollCreationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        switch row {
        case .header(let info):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SectionHeaderCell.self), for: indexPath) as! SectionHeaderCell
            cell.configure(with: info)
            return cell
        case .textField(let info):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TextInputCell.self), for: indexPath) as! TextInputCell
            cell.configure(with: info)
            cell.delegate = self
            return cell
        case .option(let info):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PollOptionCell.self), for: indexPath) as! PollOptionCell
            cell.configure(with: info)
            return cell
        case .button(let title):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ButtonCell.self), for: indexPath) as! ButtonCell
            cell.configure(with: title)
            return cell
        }
    }
}

// MARK: - TextInputCellDelegate
extension PollCreationViewController: TextInputCellDelegate {
    func didUpdateInputCount(from cell: TextInputCell, with count: Int) {
        updateHeaderCellInput(with: count)
    }
}
