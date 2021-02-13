//
//  HomeView.swift
//  Droplet1
//
//  Created by Ada on 2/4/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        Image("droplettouchup")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.top)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
