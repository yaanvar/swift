//
//  Extensions.swift
//  TriviaGame
//
//  Created by Anvar Rahimov on 27.09.2022.
//

import Foundation
import SwiftUI

extension Text {
    func lilacTitle() -> some View {
        self
            .font(.title)
            .fontWeight(.heavy)
            .foregroundColor(Color("AccentColor"))
    }
}
