//
//  SignInView.swift
//  Messenger
//
//  Created by Anvar Rahimov on 11.08.2022.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var model: AppStateModel
    
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                
                Text("Messenger")
                    .bold()
                    .font(.system(size: 34))
                
                VStack {
                    TextField("Username", text: $username)
                        .modifier(CustomField())
                    SecureField("Password", text: $password)
                        .modifier(CustomField())
                    
                    Button {
                        
                    } label: {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .frame(width: 220, height: 58)
                            .background(Color.blue)
                            .cornerRadius(16)
                    }
                }
                .padding(.vertical)
                
                Spacer()
                
                HStack {
                    Text("New to Messenger?")
                    NavigationLink("Create Account", destination: SignUpView())
                }
            }
        }
        .navigationTitle("Sign In")
        .padding()
    }
    
    func signIn() {
        guard !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              password.count >= 6 else { return }
        
        model.signIn(username: username, password: password)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .preferredColorScheme(.dark)
    }
}
