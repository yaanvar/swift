//
//  SettingsView.swift
//  NewNews(SwiftUI)
//
//  Created by Anvar Rahimov on 14.08.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var darkModeEnabled: Bool
    @Binding var systemThemeEnabled: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Display"),
                        footer: Text("System settings will override Dark mode and use the current device theme ")) {
                    Toggle(isOn: $darkModeEnabled) {
                        Text("Dark mode")
                    }
                    .onChange(of: darkModeEnabled) { newValue in
                        ThemeManager
                            .shared
                            .handleTheme(darkMode: darkModeEnabled,
                                         system: systemThemeEnabled)
                    }
                    Toggle(isOn: $systemThemeEnabled) {
                        Text("Use system settings")
                    }
                    .onChange(of: systemThemeEnabled) { newValue in
                        ThemeManager
                            .shared
                            .handleTheme(darkMode: darkModeEnabled,
                                         system: systemThemeEnabled)
                    }
                }
                
                Section("Contacts") {
                    Link(destination: Contacts.githubUrl) {
                        Label("Follow me on GitHub @yaanvar", systemImage: "link")
                    }
                    Link(destination: Contacts.emailUrl) {
                        Label("Contact me via email", systemImage: "envelope")
                    }
                    Link(destination: Contacts.phoneUrl) {
                        Label("Call me", systemImage: "phone")
                    }
                }
                .font(.subheadline.bold())
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(darkModeEnabled: .constant(false),
                     systemThemeEnabled: .constant(false))
    }
}
