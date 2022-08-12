//
//  SendButton.swift
//  Messenger
//
//  Created by Anvar Rahimov on 11.08.2022.
//

import SwiftUI

struct CustomButtonImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 28))
            .aspectRatio(contentMode: .fit)
            .frame(width: 44, height: 44)
            .foregroundColor(Color.white)
            .background(.blue)
            .clipShape(Circle())
            .padding(.trailing)
    }
}

struct SendButton: View {
    @EnvironmentObject var model: AppStateModel
    
    @Binding var text: String
    
    var body: some View {
        Button {
            sendMessage()
        } label: {
            Image(systemName: "paperplane")
                .modifier(CustomButtonImage())
        }
    }
    
    func sendMessage() {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        model.sendMessage(text: text)
        
        text = ""
    }
}
