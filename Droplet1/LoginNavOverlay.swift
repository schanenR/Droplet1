//
//  LoginNavOverlay.swift
//  Droplet1
//
//  Created by Ada on 2/11/21.
//

import SwiftUI

struct LoginNavOverlay: View {

    var body: some View {
        HStack {
            Button(action: {
                ViewRouter.shared.currentPage = .page1
            }) {
                Text("LOGIN")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .heavy))
                    .padding(20)
                    .padding(.top, 20)
                    .opacity(0.8)
            }
            Spacer()
            Button(action: {
                ViewRouter.shared.currentPage = .page1
            }) {
                Text("SIGN UP")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .heavy))
                    .padding(20)
                    .padding(.top, 20)
                    .opacity(0.8)
            }
        }
    }
}

struct LoginNavOverlay_Previews: PreviewProvider {
    static var previews: some View {
        LoginNavOverlay()
    }
}
