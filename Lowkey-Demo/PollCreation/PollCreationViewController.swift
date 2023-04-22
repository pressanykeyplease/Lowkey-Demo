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
    private let questionMaxLength = 140
    private let defaultSection = 0
    private let optionsMaxAmount = 8
    private let questionHeaderTitle = "Question"
    private let questionFieldPlaceholder = "Ask a question"
    private let optionsHeaderTitle = "Options"
    private let optionPlaceholder = "Add an option"
    private let addButtonTitle = "Add an option"

    private enum Row: Hashable {
        case questionHeader
        case questionField
        case optionsHeader
        case option(Int)
        case addOptionButton
    }

    // MARK: - Private properties
    private let tableView = UITableView()
    private lazy var rows: [Row] = [
        .questionHeader,
        .questionField,
        .optionsHeader,
        .addOptionButton
    ]

    private var questionInputCount: Int = .zero
    private var question = String()
    private lazy var options = [String]()
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
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .Navigation.presentedViewNavigationBarColor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
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

    func makeQuestionHeaderInfo() -> SectionHeaderInfo {
        .init(title: questionHeaderTitle, secondaryTitle: "\(questionInputCount)/\(questionMaxLength)")
    }

    func makeQuestionFieldInfo() -> TextFieldCellInfo {
        .init(placeholder: questionFieldPlaceholder, text: question, lengthLimit: questionMaxLength)
    }

    func makeOptionsHeaderInfo() -> SectionHeaderInfo {
        .init(title: optionsHeaderTitle, secondaryTitle: "\(options.count)/\(optionsMaxAmount)")
    }

    func makeOptionCellInfo(index: Int) -> TextFieldCellInfo {
        .init(placeholder: optionPlaceholder, text: options[index], lengthLimit: nil)
    }

    func updateHeaderCellInput(with count: Int) {
        guard let row = rows.firstIndex(of: .questionHeader) else { return }
        questionInputCount = count
        let indexPath = IndexPath(row: row, section: defaultSection)
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
        case .questionHeader:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SectionHeaderCell.self), for: indexPath) as! SectionHeaderCell
            cell.configure(with: makeQuestionHeaderInfo())
            return cell
        case .questionField:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TextInputCell.self), for: indexPath) as! TextInputCell
            cell.configure(with: makeQuestionFieldInfo())
            cell.delegate = self
            return cell
        case .optionsHeader:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SectionHeaderCell.self), for: indexPath) as! SectionHeaderCell
            cell.configure(with: makeOptionsHeaderInfo())
            return cell
        case .option(let index):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PollOptionCell.self), for: indexPath) as! PollOptionCell
            cell.delegate = self
            cell.configure(with: makeOptionCellInfo(index: index))
            return cell
        case .addOptionButton:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ButtonCell.self), for: indexPath) as! ButtonCell
            cell.configure(with: addButtonTitle)
            cell.delegate = self
            return cell
        }
    }
}

// MARK: - TextInputCellDelegate
extension PollCreationViewController: TextInputCellDelegate {
    func didUpdateInputCount(from cell: TextInputCell, with text: String?) {
        guard let text else { return }
        updateHeaderCellInput(with: text.count)
        question = text
    }
}

// MARK: - ButtonCellDelegate
extension PollCreationViewController: ButtonCellDelegate {
    func didTapButton() {
        guard let optionsHeaderRow = rows.firstIndex(of: .optionsHeader) else { return }
        options.append(.empty)
        let optionRow = optionsHeaderRow + options.count
        rows.insert(.option(options.count - 1), at: optionRow)
        tableView.reloadData()
        if let cell = tableView.cellForRow(at: IndexPath(row: optionRow, section: defaultSection)) as? PollOptionCell {
            cell.startEditing()
        }
    }
}

// MARK: - PollOptionCellDelegate
extension PollCreationViewController: PollOptionCellDelegate {
    func didUpdateInput(from cell: PollOptionCell, with text: String?) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        guard let optionsFirstRow = rows.firstIndex(of: .option(.zero)) else { return }
        
        let optionIndex = indexPath.row - optionsFirstRow
        options[optionIndex] = text ?? .empty
    }
}
