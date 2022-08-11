//
//  ChatRow.swift
//  Messenger
//
//  Created by Anvar Rahimov on 11.08.2022.
//

import SwiftUI

struct ChatRow: View {
    
    let type: MessageType
    let text: String
    
    var isSender: Bool {
        return type == .sent
    }
    
    var body: some View {
        HStack {
            
            if isSender { Spacer() }
            
            if !isSender {
                VStack {
                    Spacer()
                    Circle()
                        .frame(width: 44, height: 44)
                        .foregroundColor(Color.pink)
                }
            }
             
            HStack {
                Text(text)
                    .foregroundColor(isSender ? Color.white : Color(.label))
                    .padding()
            }
            .background(isSender ? Color.blue : Color(.systemGray4))
            .cornerRadius(16)
            .padding(isSender ? .leading : .trailing, isSender ? UIScreen.main.bounds.width / 4 : UIScreen.main.bounds.width / 6)
            
            if !isSender { Spacer() }
        }
        .padding(.horizontal)
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(type: .sent, text: "Hello, World!")
            .preferredColorScheme(.dark)
        ChatRow(type: .received, text: "Hello, World!")
            .preferredColorScheme(.dark)
    }
}
