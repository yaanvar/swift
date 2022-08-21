//
//  ThemeManager.swift
//  NewNews(SwiftUI)
//
//  Created by Anvar Rahimov on 14.08.2022.
//

import Foundation
import UIKit

class ThemeManager {
    
    static let shared = ThemeManager()
    
    func handleTheme(darkMode: Bool, system: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            
                guard !system else {
                    UIApplication.keyWindow?.overrideUserInterfaceStyle = .unspecified
                    return
                }
                
                UIApplication.keyWindow?.overrideUserInterfaceStyle = darkMode ? .dark : .light
            }
    }
}

extension UIApplication {
    
    static var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
    
}
