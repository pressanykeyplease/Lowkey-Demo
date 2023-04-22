//
//  ChatPresenter.swift
//  Lowkey-Demo
//
//  Created by Eduard on 19.04.2023
//

protocol ChatPresenterProtocol: AnyObject {
    func didTapCreatePoll()
}

class ChatPresenter {
    weak var view: ChatViewProtocol?
    var router: ChatRouterProtocol
    var interactor: ChatInteractorProtocol

    init(interactor: ChatInteractorProtocol, router: ChatRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension ChatPresenter: ChatPresenterProtocol {
    func didTapCreatePoll() {
        router.showPollCreation()
    }
}
