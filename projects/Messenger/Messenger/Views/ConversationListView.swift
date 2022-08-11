//
//  ConversationListView.swift
//  Messenger
//
//  Created by Anvar Rahimov on 11.08.2022.
//

import SwiftUI

struct ConversationListView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var model: AppStateModel
    
    let userNames = ["Joe", "Jill", "Bob"]
    
    @State private var otherUserName = ""
    @State private var showChat = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ForEach(userNames, id: \.self) { name in
                    NavigationLink {
                        ChatView(otherUserName: name)
                    } label: {
                        HStack {
                            Circle()
                                .foregroundColor(.pink)
                                .frame(width: 65, height: 65)
                            
                            Text(name)
                                .bold()
                                .font(.system(size: 32))
                                .foregroundColor(Color(.label))
                            
                            Spacer()
                        }
                        .padding()
                    }
                }
                
                if !otherUserName.isEmpty {
                    NavigationLink("",
                                   destination: ChatView(otherUserName: otherUserName),
                                   isActive: $showChat)
                }
            }
            .navigationTitle("Conversations")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        signOut()
                    } label: {
                        Text("Sign Out")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SearchView { name in
                            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                                otherUserName = name
                                showChat = true
                            }
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
            .fullScreenCover(isPresented: $model.showingSignIn) {
                SignInView()
            }
        }
    }
    
    func signOut() {
        
    }
}

struct ConversationListView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView()
    }
}
