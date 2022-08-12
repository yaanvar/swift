//
//  Message.swift
//  Messenger
//
//  Created by Anvar Rahimov on 11.08.2022.
//

import Foundation

enum MessageType: String {
    case sent
    case received
}

struct Message: Hashable {
    let text: String
    let type: MessageType
    let created: Date
}
