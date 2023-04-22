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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Private constants
    private let questionMaxLength = 140
    private let optionsMaxAmount = 8
    private let numberOfRowsInButtonSection = 1
    private let animationDuration: CGFloat = 0.2
    private let questionHeaderTitle = "Question"
    private let questionFieldPlaceholder = "Ask a question"
    private let optionsHeaderTitle = "Options"
    private let optionPlaceholder = "Add an option"
    private let addButtonTitle = "Add an option"

    private enum TopSectionRow: Hashable {
        case questionHeader
        case questionField
        case optionsHeader
    }

    private enum Sections: Int, CaseIterable {
        case top
        case options
        case addOptionButton
    }

    // MARK: - Private properties
    private let tableView = UITableView()
    private lazy var topSectionRows: [TopSectionRow] = [
        .questionHeader,
        .questionField,
        .optionsHeader
    ]

    private var questionInputCount: Int = .zero
    private var question = String()
    private lazy var options = [String]()
    private var shouldShowAddButton = true
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
            make.leading.trailing.top.bottom.equalToSuperview()
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

    @objc func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size.height
            tableView.contentInset = UIEdgeInsets(top: .zero, left: .zero, bottom: keyboardHeight, right: .zero)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: animationDuration) {
            self.tableView.contentInset = UIEdgeInsets.zero
        }
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
        guard let row = topSectionRows.firstIndex(of: .questionHeader) else { return }
        questionInputCount = count
        let indexPath = IndexPath(row: row, section: Sections.top.rawValue)
        tableView.reloadRows(at: [indexPath], with: .none)
    }

    func updateOptionsHeader() {
        guard let optionsHeaderRow = topSectionRows.firstIndex(of: .optionsHeader) else { return }
        let optionsHeaderIndexPath = IndexPath(row: optionsHeaderRow,
                                               section: Sections.top.rawValue)
        tableView.reloadRows(at: [optionsHeaderIndexPath], with: .none)
    }

    func updateAddButtonVisibility() {
        let addButtonIndexPath = IndexPath(row: .zero, section: Sections.addOptionButton.rawValue)
        if options.count == optionsMaxAmount, shouldShowAddButton {
            shouldShowAddButton = false
            tableView.deleteRows(at: [addButtonIndexPath], with: .fade)
        }
        if options.count < optionsMaxAmount, !shouldShowAddButton {
            shouldShowAddButton = true
            tableView.insertRows(at: [addButtonIndexPath], with: .fade)
        }
    }
}

// MARK: - PollCreationViewProtocol
extension PollCreationViewController: PollCreationViewProtocol {
}

// MARK: - UITableViewDataSource
extension PollCreationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Sections.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Sections(rawValue: section) {
        case .top:
            return topSectionRows.count
        case .options:
            return options.count
        case .addOptionButton:
            return shouldShowAddButton ? numberOfRowsInButtonSection : .zero
        default:
            fatalError("Can't find section for index: \(section)")
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Sections(rawValue: indexPath.section) {
        case .top:
            let row = topSectionRows[indexPath.row]
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
            }
        case .options:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PollOptionCell.self), for: indexPath) as! PollOptionCell
            cell.delegate = self
            cell.configure(with: makeOptionCellInfo(index: indexPath.row))
            return cell
        case .addOptionButton:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ButtonCell.self), for: indexPath) as! ButtonCell
            cell.configure(with: addButtonTitle)
            cell.delegate = self
            return cell
        case .none:
            fatalError("Can't find section for indexPath: \(indexPath)")
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
        options.append(.empty)
        tableView.reloadSections(IndexSet(integer: Sections.options.rawValue), with: .fade)
        let indexPath = IndexPath(row: options.count - 1, section: Sections.options.rawValue)
        updateOptionsHeader()
        updateAddButtonVisibility()
        if let cell = tableView.cellForRow(at: indexPath) as? PollOptionCell {
            cell.startEditing()
        }
    }
}

// MARK: - PollOptionCellDelegate
extension PollCreationViewController: PollOptionCellDelegate {
    func didUpdateInput(from cell: PollOptionCell, with text: String?) {
        guard let text,
              let indexPath = tableView.indexPath(for: cell) else { return }
        options[indexPath.row] = text
    }

    func didTapRemoveButton(from cell: PollOptionCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        options.remove(at: indexPath.row)
        tableView.reloadSections(IndexSet(integer: Sections.options.rawValue), with: .fade)
        updateOptionsHeader()
        updateAddButtonVisibility()
    }

    func didTapReturnButton(from cell: PollOptionCell) {
    }
}
