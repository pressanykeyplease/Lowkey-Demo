//
//  PollCell.swift
//  Lowkey-Demo
//
//  Created by Eduard on 19.04.2023.
//

import SnapKit
import UIKit

protocol PollCellDelegate: AnyObject {
    func didTapVote(from cell: PollCell, index: Int)
}

final class PollCell: UITableViewCell {
    // MARK: - Public
    weak var delegate: PollCellDelegate?

    func configure(with info: PollInfo) {
        userpicView.image = info.userpic
        pollTypeLabel.text = info.pollType
        nameLabel.text = info.username
        messageLabel.text = info.message
        votesCountLabel.text = String(info.numberOfVotes)
        votesLabel.text = getVotesLabelText(amount: info.numberOfVotes)
        options = info.options
        configureOptionsStack()
        setVote(at: info.selectedOption)
    }

    func vote(at index: Int) {
        startVoteAnimation(at: index)
        increaseVotesCounter()
    }

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private constants
    private enum UIConstants {
        static let userpicSize: CGFloat = 36
        static let userpicCornerRadius: CGFloat = 12
        static let pollTypeFontSize: CGFloat = 10
        static let nameFontSize: CGFloat = 12
        static let messageFontSize: CGFloat = 15
        static let votesCountFontSize: CGFloat = 16
        static let votesFontSize: CGFloat = 10
        static let optionFontSize: CGFloat = 12
        static let frameViewInsetX: CGFloat = 15
        static let frameViewInsetY: CGFloat = 7
        static let gradientViewCornerRadius: CGFloat = 20
        static let votesViewSize: CGFloat = 50
        static let votesInfoInsetY: CGFloat = 8
        static let stackTopInset: CGFloat = 12
        static let stackBottomInset: CGFloat = 20
        static let stackInsetX: CGFloat = 20
        static let headerStackSpacing: CGFloat = 10
        static let stackSpacing: CGFloat = 12
        static let optionsStackSpacing: CGFloat = 8
        static let optionViewCornerRadius: CGFloat = 15
        static let pollOptionFontSize: CGFloat = 12
        static let optionTextInsetX: CGFloat = 15
        static let optionViewHeight: CGFloat = 40
        static let optionAlpha: CGFloat = 0.15
        static let voteInitialWidth: CGFloat = 0
        static let voteAnimationDuration: CGFloat = 0.3
        static let voteAnimationDelay: CGFloat = 0.1
    }

    private let votesLabelIdentifier = "chatPollVotesCountLabel"
        
    // MARK: - Private properties
    private let userpicView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = UIConstants.userpicCornerRadius
        view.layer.cornerCurve = .continuous
        view.layer.masksToBounds = true
        return view
    }()

    private let pollTypeLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .regular, size: UIConstants.pollTypeFontSize)
        label.textColor = .Chat.textColor
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .semibold, size: UIConstants.nameFontSize)
        label.textColor = .Chat.textColor
        return label
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .medium, size: UIConstants.messageFontSize)
        label.textColor = .Chat.textColor
        label.numberOfLines = .zero
        return label
    }()

    private let votesCountLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .semibold, size: UIConstants.votesCountFontSize)
        label.textColor = .Chat.textColor
        return label
    }()

    private let votesLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .semibold, size: UIConstants.votesFontSize)
        label.textColor = .Chat.textColor
        label.text = "Votes"
        return label
    }()

    private let optionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = UIConstants.optionsStackSpacing
        return stackView
    }()

    private var options: [String] = []
}

// MARK: - Private methods
private extension PollCell {
    func initialize() {
        selectionStyle = .none
        backgroundColor = .clear

        let gradientView = GradientView()
        gradientView.layer.cornerRadius = UIConstants.gradientViewCornerRadius
        contentView.addSubview(gradientView)

        let frameView = UIView()
        contentView.addSubview(frameView)
        frameView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIConstants.frameViewInsetX)
            make.top.bottom.equalToSuperview().inset(UIConstants.frameViewInsetY)
        }
        gradientView.snp.makeConstraints { make in
            make.edges.equalTo(frameView)
        }

        userpicView.snp.makeConstraints { make in
            make.size.equalTo(UIConstants.userpicSize)
        }

        let typeAndNameStack = UIStackView()
        typeAndNameStack.axis = .vertical
        typeAndNameStack.alignment = .leading
        typeAndNameStack.addArrangedSubview(pollTypeLabel)
        typeAndNameStack.addArrangedSubview(nameLabel)
        
        let votesView = UIView()
        votesView.layer.cornerRadius = UIConstants.votesViewSize / 2
        votesView.backgroundColor = .Chat.votesViewColor
        votesView.snp.makeConstraints { make in
            make.size.equalTo(UIConstants.votesViewSize)
        }

        let votesInfoStack = UIStackView()
        votesInfoStack.axis = .vertical
        votesInfoStack.alignment = .center
        votesInfoStack.addArrangedSubview(votesCountLabel)
        votesInfoStack.addArrangedSubview(votesLabel)
        votesView.addSubview(votesInfoStack)
        votesInfoStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(UIConstants.votesInfoInsetY)
        }

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = UIConstants.stackSpacing

        let headerStackView = UIStackView()
        headerStackView.axis = .horizontal
        headerStackView.alignment = .center
        headerStackView.spacing = UIConstants.headerStackSpacing
        headerStackView.addArrangedSubview(userpicView)
        headerStackView.addArrangedSubview(typeAndNameStack)
        headerStackView.addArrangedSubview(votesView)

        stackView.addArrangedSubview(headerStackView)
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(optionsStackView)

        frameView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.stackTopInset)
            make.bottom.equalToSuperview().inset(UIConstants.stackBottomInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.stackInsetX)
        }
    }

    func configureOptionsStack() {
        optionsStackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        for (index, option) in options.enumerated() {
            let view = makeOptionView(with: option, index: index)
            optionsStackView.addArrangedSubview(view)
        }
    }

    func makeOptionView(with option: String, index: Int) -> UIView {
        let view = UIView()
        view.layer.cornerRadius = UIConstants.optionViewCornerRadius
        view.backgroundColor = .Chat.pollOptionColor.withAlphaComponent(UIConstants.optionAlpha)
        let button = UIButton(type: .system)
        button.tag = index
        button.addTarget(self, action: #selector(didTapOptionButton), for: .touchUpInside)
        button.backgroundColor = .clear
        button.tintColor = .Chat.textColor
        button.contentHorizontalAlignment = .leading
        button.titleLabel?.apply(style: .regular, size: UIConstants.pollOptionFontSize)
        button.setTitle(option, for: .normal)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIConstants.optionTextInsetX)
            make.centerY.equalToSuperview()
        }
        view.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.optionViewHeight)
        }
        return view
    }

    @objc func didTapOptionButton(sender: UIButton) {
        delegate?.didTapVote(from: self, index: sender.tag)
    }

    func startVoteAnimation(at index: Int) {
        let optionView = optionsStackView.subviews[index]
        guard let voteButton = optionView.subviews.first as? UIButton else { return }
        let voteView = makeVoteView()
        optionView.insertSubview(voteView, belowSubview: voteButton)
        voteView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
        }
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + UIConstants.voteAnimationDelay) {
            voteView.snp.makeConstraints { make in
                make.width.equalTo(optionView.bounds.width)
            }
            UIView.animate(withDuration: UIConstants.voteAnimationDuration) {
                self.layoutIfNeeded()
            }
        }
    }

    func makeVoteView() -> UIView {
        let voteView = UIView()
        voteView.backgroundColor = .Chat.pollOptionColor
        voteView.layer.cornerRadius = UIConstants.optionViewCornerRadius
        return voteView
    }

    func increaseVotesCounter() {
        guard let votesCount = Int(votesCountLabel.text ?? .empty) else { return }
        votesCountLabel.text = "\(votesCount + 1)"
        votesLabel.text = getVotesLabelText(amount: votesCount + 1)
    }

    func setVote(at index: Int?) {
        guard let index else { return }
        let optionView = optionsStackView.subviews[index]
        guard let voteButton = optionView.subviews.first as? UIButton else { return }
        let voteView = makeVoteView()
        optionView.insertSubview(voteView, belowSubview: voteButton)
        voteView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }

    func getVotesLabelText(amount: Int) -> String {
        let formatString = NSLocalizedString(votesLabelIdentifier, comment: .empty)
        let resultString = String.localizedStringWithFormat(formatString, amount)
        return resultString
    }
}
