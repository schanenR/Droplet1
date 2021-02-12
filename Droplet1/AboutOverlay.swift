//
//  AboutOverlay.swift
//  Droplet1
//
//  Created by Ada on 2/11/21.
//

import SwiftUI

struct AboutOverlay: View {
    var body: some View {
        HStack {
            Button(action: {
                ViewRouter.shared.currentPage = .page1
            }) {
                Image(systemName: "x.circle")
                    .foregroundColor(.white)
                    .font(.system(size: 60))
                    .padding(20)
                    .padding(.bottom, 30)
                    .opacity(0.8)
            }
        }
    }
}

struct AboutOverlay_Previews: PreviewProvider {
    static var previews: some View {
        AboutOverlay()
    }
}
