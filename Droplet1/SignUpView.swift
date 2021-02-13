//
//  SignUpView.swift
//  Droplet1
//
//  Created by Ada on 2/12/21.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var  session: SessionStore
    @State var password: String = ""
    @State var email: String = ""
    @State var error: String = ""
    
    func signUp() {
        session.signUp(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
                ViewRouter.shared.currentPage = .page1
            }
        }
    }
    
    var body: some View {
        ZStack {
            Image("dropletupdateblank")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                TextField("email", text: $email)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.orange)
                        .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .keyboardType(.default)
                    .disableAutocorrection(true)
                SecureField("password", text:
                            $password)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.orange)
                        .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .keyboardType(.default)
                    .disableAutocorrection(true)
                Button(action: signUp) {
                    Text("SIGN UP")
                        .foregroundColor(.orange)
                        .font(.system(size: 20, weight: .heavy))
                        .padding(20)
                        .opacity(0.8)
                        .frame(width: 220, height: 60)
                        .background(Color.white)
                        .cornerRadius(35)
                }
                
                if (error != "") {
                    Text(error)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.red)
                        .padding()
                }
            }.padding()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
