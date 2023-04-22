//
//  ChatRouter.swift
//  Lowkey-Demo
//
//  Created by Eduard on 19.04.2023
//

import UIKit

protocol ChatRouterProtocol {
    func showPollCreation()
}

class ChatRouter: ChatRouterProtocol {
    weak var viewController: ChatViewController?

    func showPollCreation() {
        let vc = PollCreationModuleBuilder.build()
        vc.delegate = viewController
        let nvc = UINavigationController(rootViewController: vc)
        nvc.isModalInPresentation = true
        viewController?.present(nvc, animated: true)
    }
}
