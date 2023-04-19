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
    }
}

// MARK: - PollCreationViewProtocol
extension PollCreationViewController: PollCreationViewProtocol {
}
