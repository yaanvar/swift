//
//  ContentView.swift
//  Friendface
//
//  Created by Anvar Rahimov on 16.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var friends = [Friend]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(friends) { friend in
                    FriendRow(friend: friend)
                }
            }
            .navigationTitle("Friendface")
            .onAppear(perform: fetchFriends)
        }
    }
    
    func fetchFriends() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                   print("Invalid URL")
                   return
               }

               let request = URLRequest(url: url)

               URLSession.shared.dataTask(with: request) { data, response, error in
                   if let data = data {
                       let decoder = JSONDecoder()
                       decoder.dateDecodingStrategy = .iso8601

                       if let decodedResponse = try? decoder.decode([Friend].self, from: data) {
                           friends = decodedResponse
                           return
                       }
                   }

                   print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
               }
               .resume()
    }
}

struct FriendRow: View {
    let friend: Friend
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .scaleEffect(2)
                .frame(width: 60, height: 60)
            VStack(alignment: .leading) {
                Text(friend.name)
                Text(friend.isActive ? "Online" : "Offline")
                    .foregroundColor(friend.isActive ? .green : .secondary)
            }
        }
    }
}

struct FriendDetailView: View {
    let friend: Friend
    
    var body: some View {
        Form {
            Section(header: Text("Personal Details")) {
                Detail(image: "mail", detail: friend.address)
                Detail(image: "building", detail: friend.company)
                Detail(image: "envelope", detail: friend.email)
                Detail(image: "calendar", detail: "\(friend.age) years old")
            }

            Section(header: Text("About")) {
                VStack(alignment: .leading) {
                    Text(friend.about.trimmingCharacters(in: .whitespacesAndNewlines))
                        .padding(.bottom)
                    Text("Since: \(formattedDate(from: friend.registered))")
                }
            }
        }
        .navigationBarTitle("\(friend.name)\(friend.isActive ? "" : " (inactive)")", displayMode: .inline)
    }
    
    func formattedDate(from date: Date) -> String {
          let formatter = DateFormatter()
          formatter.dateStyle = .medium
          formatter.timeStyle = .short
          return formatter.string(from: date)
      }
}

struct Detail: View {
    let image: String
    let detail: String

    var body: some View {
        HStack {
            Image(systemName: image)
                .frame(width: 30)
            Text(detail)
        }
        .font(.subheadline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
