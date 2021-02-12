//
//  MessageView.swift
//  Droplet1
//
//  Created by Ada on 2/6/21.
//


import SwiftUI


struct MessageView: View {
    
    let dateFormatter = DateFormatter()
        
    var body: some View {
        ZStack {
            Image("dropletupdateblank")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.top)
            VStack {
                Text(GoogleMapsView.userMessage.message!)
                    .frame(width: 325)
                    .foregroundColor(Color.white)
                    .font(.largeTitle)
                Text(GoogleMapsView.userMessage.date!)
                    .foregroundColor(Color.white)
                    .italic()
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
