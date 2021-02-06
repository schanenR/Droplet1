//
//  MessageFormView.swift
//  Droplet1
//
//  Created by Ada on 2/5/21.
//

import SwiftUI


struct MessageFormView: View {
    
    @State private var text = ""

        var body: some View {
            ZStack {
                Image("droplet-notext")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.top)
                VStack {
                    TextField("Type message here...", text: $text)
                      .padding(10)
                        .frame( width: 300, height: 200)
                      .font(Font.system(size: 20, weight: .medium, design: .serif))
                      .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                }
            }
        }
}

struct MessageFormView_Previews: PreviewProvider {
    static var previews: some View {
        MessageFormView()
    }
}
