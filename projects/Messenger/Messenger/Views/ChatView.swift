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
    @State private var message: String = ""
    let otherUserName: String
    
    var body: some View {
        VStack {
            ScrollView {
                ChatRow(type: .sent, text: "Hello, World!")
                    .padding(3)
                ChatRow(type: .received, text: "Hello, Bob!")
                    .padding(3)
                ChatRow(type: .sent, text: "Hello!")
                    .padding(3)
            }
            
            HStack {
                TextField("Message...", text: $message)
                    .modifier(CustomField())
                    .padding(.leading)
                
                SendButton(text: $message)
            }
        }
        .navigationTitle(otherUserName)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(otherUserName: "Samantha")
    }
}
