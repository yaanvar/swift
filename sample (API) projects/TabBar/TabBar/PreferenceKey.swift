//
//  PreferenceKey.swift
//  TabBar
//
//  Created by Anvar on 11.04.2023.
//

import SwiftUI

struct TabPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
