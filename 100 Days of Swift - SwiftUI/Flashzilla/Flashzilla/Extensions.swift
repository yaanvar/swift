//
//  Extensions.swift
//  Flashzilla
//
//  Created by Anvar Rahimov on 07.08.2022.
//

import Foundation
import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset *  10)
    }
}
