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
            Image("dropletupdateblank")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("TIPS")
                    .padding()
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 60)
                Text("+ tap AR object to reveal message")
                    .frame(width: 300, alignment: .leading)
                    .font(.headline)
                Text("+  in AR mode, point phone toward the ground to orient object with horizontal plane")
                    .frame(width: 300, alignment: .leading)
                    .font(.headline)
                Text("+ sign up with email to send and recieve private messages")
                    .frame(width: 300, alignment: .leading)
                    .font(.headline)
                Text("MAP KEY")
                    .padding()
                    .font(.largeTitle)
                    .foregroundColor(.white)
                HStack {
                    Image("pngdropletsmall")
                    Text("- PUBLIC MESSAGE")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                HStack {
                    Image("pinklotuspng")
                    Text("- PRIVATE MESSAGE")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                Text("THANKS!")
                    .padding()
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Text("Ada, thank you so much for supporting me through this incredible experience! Thank you to C14, Earth class, instructor, tutors, & friends! I counldn't have done this without you.")
                    .frame(width: 300, alignment: .center)
                    .font(.headline)
                Spacer()
            }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
