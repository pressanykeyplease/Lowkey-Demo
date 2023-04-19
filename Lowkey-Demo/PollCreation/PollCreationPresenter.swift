//
//  PollCreationPresenter.swift
//  Super easy dev
//
//  Created by Eduard on 19.04.2023
//

protocol PollCreationPresenterProtocol: AnyObject {
}

class PollCreationPresenter {
    weak var view: PollCreationViewProtocol?
    var router: PollCreationRouterProtocol
    var interactor: PollCreationInteractorProtocol

    init(interactor: PollCreationInteractorProtocol, router: PollCreationRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension PollCreationPresenter: PollCreationPresenterProtocol {
}
