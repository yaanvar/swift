//
//  Contacts.swift
//  Contacts
//
//  Created by Anvar Rahimov on 02.10.2021.
//

import Foundation

protocol ContactProtocol {
    /// имя
    var title: String { get set }
    /// номер телефона
    var phone: String { get set }
}
struct Contact: ContactProtocol {
    var title: String
    var phone: String
}
