//
//  SignUpView.swift
//  Messenger
//
//  Created by Anvar Rahimov on 11.08.2022.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var model: AppStateModel
    
    @State private var username = ""
    @State private var emailAddress = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
            
            Text("Create Account")
                .bold()
                .font(.system(size: 34))
            
            VStack {
                TextField("Email address", text: $emailAddress)
                    .modifier(CustomField())
                TextField("Username", text: $username)
                    .modifier(CustomField())
                SecureField("Password", text: $password)
                    .modifier(CustomField())
                
                Button {
                    
                } label: {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .frame(width: 220, height: 58)
                        .background(Color.green)
                        .cornerRadius(16)
                }
            }
            .padding(.vertical)
            
            Spacer()
        }
        .padding()
    }
    
    func signUp() {
        guard !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !emailAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              password.count >= 6 else { return }
        
        model.signUp(emailAddress: emailAddress, username: username, password: password)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
