//
//  HomeNavOverlay.swift
//  Droplet1
//
//  Created by Ada on 2/4/21.
//

import SwiftUI

struct HomeNavOverlay: View {

    var body: some View {
        HStack {
            Button(action: {
                ViewRouter.shared.currentPage = .page5
            }) {
                Image(systemName: "pencil.circle")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(20)
                    .padding(.bottom, 30)
                    .opacity(0.8)
            }
            Button(action: {
                ViewRouter.shared.currentPage = .page2
            }) {
                Image(systemName: "mappin.circle")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(20)
                    .padding(.bottom, 30)
                    .opacity(0.8)
            }
            Button(action: {
                ViewRouter.shared.currentPage = .page1
            }) {
                Image(systemName: "questionmark.circle")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(20)
                    .padding(.bottom, 30)
                    .opacity(0.8)
            }
        }
    }
}


struct HomeNavOverlay_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavOverlay()
    }
}
