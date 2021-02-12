//
//  AboutView.swift
//  Droplet1
//
//  Created by Ada on 2/11/21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            Image("droplet-notext")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
