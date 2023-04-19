//
//  PollCreationModuleBuilder.swift
//  Super easy dev
//
//  Created by Eduard on 19.04.2023
//

import UIKit

class PollCreationModuleBuilder {
    static func build() -> PollCreationViewController {
        let interactor = PollCreationInteractor()
        let router = PollCreationRouter()
        let presenter = PollCreationPresenter(interactor: interactor, router: router)
        let viewController = PollCreationViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
