//
//  ContentView.swift
//  TestingCombine
//
//  Created by Anvar Rahimov on 13.08.2022.
//

import SwiftUI

// Model

struct User: Codable, Identifiable {
    let name: String
    let id: Int
}


// ViewModel
import Combine

private class ViewModel: ObservableObject {
    @Published var time = ""
    @Published var users = [User]()
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        setupTimePublisher()
        setupDataTaskPublisher()
    }
    
    let formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
    
    private func setupDataTaskPublisher() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { users in
                self.users = users
            }).store(in: &cancellables)
    }
    
    private func setupTimePublisher() {
        Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .receive(on: RunLoop.main)
            .sink { date in
                self.time = self.formatter.string(from: date)
            }.store(in: &cancellables)
    }
    
}

// View

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.time)
            
            List {
                ForEach(viewModel.users, id: \.id) { user in
                    Text(user.name)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
