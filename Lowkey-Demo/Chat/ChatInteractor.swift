//
//  ChatInteractor.swift
//  Lowkey-Demo
//
//  Created by Eduard on 19.04.2023
//

protocol ChatInteractorProtocol: AnyObject {
}

class ChatInteractor: ChatInteractorProtocol {
    weak var presenter: ChatPresenterProtocol?
}
