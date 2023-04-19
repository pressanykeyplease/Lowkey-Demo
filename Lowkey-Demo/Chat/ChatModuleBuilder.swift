//
//  ChatModuleBuilder.swift
//  Lowkey-Demo
//
//  Created by Eduard on 19.04.2023
//

import UIKit

class ChatModuleBuilder {
    static func build() -> ChatViewController {
        let interactor = ChatInteractor()
        let router = ChatRouter()
        let presenter = ChatPresenter(interactor: interactor, router: router)
        let viewController = ChatViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
