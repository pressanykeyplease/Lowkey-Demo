//
//  PollInfo.swift
//  Lowkey-Demo
//
//  Created by Eduard on 19.04.2023.
//

import UIKit

struct PollInfo {
    let userpic: UIImage?
    let pollType: String
    let username: String
    let message: String
    let numberOfVotes: Int
    let options: [String]
    let selectedOption: Int?
}
