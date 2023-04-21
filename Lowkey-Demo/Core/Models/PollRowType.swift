//
//  PollRowType.swift
//  Lowkey-Demo
//
//  Created by Eduard on 20.04.2023.
//

enum PollRowType {
    case header(SectionHeaderInfo)
    case textField(TextFieldCellInfo)
    case option(TextFieldCellInfo)
    case button(String)
}

extension PollRowType: Equatable {
    static func == (lhs: PollRowType, rhs: PollRowType) -> Bool {
        switch (lhs, rhs) {
        case (.header, .header):
            return true
        case (.textField, .textField):
            return true
        case (.option, .option):
            return true
        case (.button, .button):
            return true
        default:
            return false
        }
    }
}
