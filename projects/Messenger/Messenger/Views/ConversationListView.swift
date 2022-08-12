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
    @State private var otherUserName = ""
    @State private var showChat = false
    @State private var showSearch = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ForEach(model.conversations, id: \.self) { name in
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
                    NavigationLink(isActive: $showSearch) {
                        SearchView { name in
                            showSearch = false
                            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                                showChat = true
                                otherUserName = name
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
            .onAppear() {
                guard model.auth.currentUser != nil else {
                    return
                }
                
                model.getConversations()
            }
        }
    }
    
    func signOut() {
        model.signOut()
    }
}

struct ConversationListView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView()
    }
}
