//
//  HomeView.swift
//  NewNews(SwiftUI)
//
//  Created by Anvar Rahimov on 13.08.2022.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false
    @AppStorage("systemThemeEnabled") private var systemThemeEnabled = false
    
    var body: some View {
        TabView {
            NewsFeedView()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("News")
                }
            SettingsView(darkModeEnabled: $darkModeEnabled,
                         systemThemeEnabled: $systemThemeEnabled)
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
        .onAppear {
            ThemeManager
                .shared
                .handleTheme(darkMode: darkModeEnabled,
                             system: systemThemeEnabled)
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
