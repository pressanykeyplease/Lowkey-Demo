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
