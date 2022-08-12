//
//  SearchView.swift
//  Messenger
//
//  Created by Anvar Rahimov on 11.08.2022.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var model: AppStateModel

    @State private var text = ""
    
    @State private var usernames = [String]()
    
    let completion: (String) -> Void
    
    init(completion: @escaping (String) -> Void) {
        self.completion = completion
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("Username...", text: $text)
                    .modifier(CustomField())
                    .padding(.leading)
             
                Button {
                    searchUsers()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .modifier(CustomButtonImage())
                }
            }
            
            ForEach(usernames, id: \.self) { name in
                HStack {
                    Circle()
                        .frame(width: 55, height: 55)
                        .foregroundColor(Color.green)
                    
                    Text(name)
                        .font(.system(size: 24))
                    
                    Spacer()
                }
                .padding(.horizontal)
                .onTapGesture {
                    dismiss()
                    
                    completion(name)
                }
            }
            
            Spacer()
        }
        .navigationTitle("Search")
    }
    
    func searchUsers() {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        model.searchUsers(queryText: text) { usernames in
            self.usernames = usernames
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView() { _ in
            
        }
    }
}
