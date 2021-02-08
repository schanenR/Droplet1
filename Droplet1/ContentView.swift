//
//  ContentView.swift
//  Droplet1
//
//  Created by Ada on 2/3/21.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {

        @EnvironmentObject var viewRouter: ViewRouter
        
        var body: some View {
            switch viewRouter.currentPage {
            case .page1:
                HomeView()
                    .overlay(HomeNavOverlay(), alignment: .bottom)
            case .page2:
                HStack {
                    GoogleMapsView()
                        .edgesIgnoringSafeArea(.top)
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               minHeight: 0,
                               maxHeight: .infinity,
                               alignment: .topLeading)
                        .overlay(MapNavOverlay(), alignment: .bottom)
                        .edgesIgnoringSafeArea(.all)
                }
            case .page3:
                ARViewContainer().edgesIgnoringSafeArea(.all)
                    .transition(.scale)
            case .page4:
                MessageView()
            case .page5:
                MessageFormView()
            }
           
        }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

