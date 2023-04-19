//
//  PollCreationInteractor.swift
//  Super easy dev
//
//  Created by Eduard on 19.04.2023
//

protocol PollCreationInteractorProtocol: AnyObject {
}

class PollCreationInteractor: PollCreationInteractorProtocol {
    weak var presenter: PollCreationPresenterProtocol?
}
