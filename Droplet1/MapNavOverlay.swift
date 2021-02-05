//
//  MapNavOverlay.swift
//  Droplet1
//
//  Created by Ada on 2/4/21.
//


import SwiftUI

struct MapNavOverlay: View {
    
    @EnvironmentObject var viewRouter: ViewRouter

    
    var body: some View {
        HStack {
            Button(action: {
                viewRouter.currentPage = .page3
            }) {
                Image(systemName: "drop")
                    .foregroundColor(.green)
                    .font(.largeTitle)
                    .padding(20)
                    .padding(.bottom, 30)
                    .opacity(0.8)
            }
            Button(action: {
                viewRouter.currentPage = .page1
            }) {
                Image(systemName: "square.and.pencil")
                    .foregroundColor(.green)
                    .font(.largeTitle)
                    .padding(20)
                    .padding(.bottom, 30)
                    .opacity(0.8)
            }
            Button(action: {
                viewRouter.currentPage = .page1
            }) {
                Image(systemName: "house")
                    .foregroundColor(.green)
                    .font(.largeTitle)
                    .padding(20)
                    .padding(.bottom, 30)
                    .opacity(0.8)
            }
        }
    }
}

struct MapNavOverlay_Previews: PreviewProvider {
    static var previews: some View {
        MapNavOverlay()
    }
}
