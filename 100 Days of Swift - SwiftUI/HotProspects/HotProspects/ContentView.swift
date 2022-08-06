//
//  ContentView.swift
//  HotProspects
//
//  Created by Anvar Rahimov on 06.08.2022.
//

import SwiftUI
import UserNotifications
import SamplePackage

@MainActor class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

@MainActor class DelayedUpdater: ObservableObject {
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct EditView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }
}

struct ContentView: View {
    
    @StateObject var user = User()
    @State private var selectedTab = "One"

    @StateObject private var updater = DelayedUpdater()

    @State private var output = ""

    @State private var backgroundColor = Color.red
    
    let possibleNumber = Array(1...60)
    
    var results: String {
        let selected = possibleNumber.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }

    var body: some View {

        Text(results)
        
//        VStack {
//            Button("Request Permission") {
//                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//                    if success {
//                        print("All set!")
//                    } else if let error = error {
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//
//            Button("Schedule Notification") {
//                let content = UNMutableNotificationContent()
//                content.title = "Feed the dogs"
//                content.subtitle = "They look hungry"
//                content.sound = UNNotificationSound.default
//
//                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//
//                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//                UNUserNotificationCenter.current().add(request)
//            }
//        }
//
//        List {
//            Text("Taylor Swift")
//                .swipeActions {
//                    Button(role: .destructive) {
//                        print("hi")
//                    } label: {
//                        Label("Delete", systemImage: "minus.circle")
//                    }
//                }
//                .swipeActions(edge: .leading) {
//                    Button {
//                        print("Pinning")
//                    } label: {
//                        Label("Pin", systemImage: "pin")
//                    }
//                    .tint(.orange)
//                }
//        }
        
        
//        VStack {
//            Text("Hello, World")
//                .padding()
//                .background(backgroundColor)
//
//            Text("Change Color")
//                .padding()
//                .contextMenu {
//                    Button {
//                        backgroundColor = .red
//                    } label: {
//                        if backgroundColor == .red {
//                            Label("Red", systemImage: "checkmark.circle.fill")
//                        } else {
//                            Label("Red", systemImage: "circle")
//                        }
//                    }
//                    Button {
//                        backgroundColor = .green
//                    } label: {
//                        if backgroundColor == .green {
//                            Label("Green", systemImage: "checkmark.circle.fill")
//                        } else {
//                            Label("Green", systemImage: "circle")
//                        }
//                    }
//                    Button {
//                        backgroundColor = .blue
//                    } label: {
//                        if backgroundColor == .blue {
//                            Label("Blue", systemImage: "checkmark.circle.fill")
//                        } else {
//                            Label("Blue", systemImage: "circle")
//                        }
//                    }
//                }
//        }
//
        
        
//        Image("example")
//            .interpolation(.none)
//            .resizable()
//            .scaledToFit()
//            .frame(maxHeight: .infinity)
//            .background(.black)
//            .ignoresSafeArea()

        
//        Text(output)
//            .task {
//                await fetchReadings()
//            }
        
//        Text("Value is \(updater.value)")
        
//        TabView(selection: $selectedTab) {
//            Text("Tab 1")
//                .onTapGesture {
//                    selectedTab = "Two"
//                }
//                .tabItem {
//                    Label("One", systemImage: "star")
//                }
//            Text("Tab 2")
//                .tabItem {
//                    Label("Two", systemImage: "circle")
//                }
//        }
    }
    
    func fetchReadings() async {
        let fetchTask = Task { () -> String in
           let url = URL(string: "https://hws.dev/readings.json")!
           let (data, _) = try await URLSession.shared.data(from: url)
           let readings = try JSONDecoder().decode([Double].self, from: data)
           return "Found \(readings.count) readings"
       }
        
        
        let result = await fetchTask.result
        
        do {
            output = try result.get()
        } catch {
            print("Download error")
        }
        
        switch result {
        case .success(let str):
            output = str
        case .failure(let error):
            output = "Download error: \(error.localizedDescription)"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
