//
//  MessageView.swift
//  Droplet1
//
//  Created by Ada on 2/6/21.
//


import SwiftUI


struct MessageView: View {
        
    var body: some View {
        ZStack {
            Image("droplet-notext")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.top)
            VStack {
                Text(GoogleMapsView.userMessage.message!)
                    .frame(width: 325)
                    .foregroundColor(Color.white)
                    .font(.largeTitle)
                Text(Date(), style: .date)
                    .foregroundColor(Color.white)
                    .italic()
                Text(Date(), style: .time)
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
