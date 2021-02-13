//
//  LoginNavOverlay.swift
//  Droplet1
//
//  Created by Ada on 2/11/21.
//

import SwiftUI

struct LoginNavOverlay: View {
    
    @EnvironmentObject var  session: SessionStore
    
    func signOut() {
        session.signOut()
    }

    var body: some View {
        
        if session.session != nil {
            HStack {
                Button(action: signOut) {
                    Text("LOGOUT")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .heavy))
                        .padding(20)
                        .padding(.top, 20)
                }
                Spacer()
                Text(session.session!.email!)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .medium))
                    .padding(20)
                    .padding(.top, 20)
            }
        } else {
                HStack {
                    Button(action: {
                        ViewRouter.shared.currentPage = .page8
                    }) {
                        Text("LOGIN")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .heavy))
                            .padding(20)
                            .padding(.top, 20)
                    }
                    Spacer()
                    Button(action: {
                        ViewRouter.shared.currentPage = .page7
                    }) {
                        Text("SIGN UP")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .heavy))
                            .padding(20)
                            .padding(.top, 20)
                    }
                }
        }
    }
}

struct LoginNavOverlay_Previews: PreviewProvider {
    static var previews: some View {
        LoginNavOverlay()
    }
}
