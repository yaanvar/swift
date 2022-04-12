//
//  Person+print.swift
//  FRApp
//
//  Created by n.gundorin on 03.04.2022.
//

import Foundation

extension Person {

    func printDescription() {
        guard let position = position,
              let salary = salary?.stringValue
        else { fatalError() }

        print("\(position) - $\(salary)")
    }
}
