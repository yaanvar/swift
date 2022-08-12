//
//  ChatView.swift
//  Messenger
//
//  Created by Anvar Rahimov on 11.08.2022.
//

import SwiftUI

struct CustomField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(16)
    }
}

struct ChatView: View {
    @EnvironmentObject var model: AppStateModel
    
    @State private var message: String = ""
    let otherUserName: String
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(model.messages, id: \.self) { message in
                    ChatRow(type: message.type,
                            text: message.text)
                        .padding(3)
                }
            }
            
            HStack {
                TextField("Message...", text: $message)
                    .modifier(CustomField())
                    .padding(.leading)
                
                SendButton(text: $message)
            }
        }
        .navigationTitle(otherUserName)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            model.otherUserName = otherUserName
            model.observeChat()
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(otherUserName: "Samantha")
    }
}
