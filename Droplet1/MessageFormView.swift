//
//  MessageFormView.swift
//  Droplet1
//
//  Created by Ada on 2/5/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct MessageFormView: View {
    
    @State private var note = ""
    @EnvironmentObject var viewRouter: ViewRouter
    @ObservedObject var locationManager = LocationManager()



        var body: some View {
            ZStack {
                Image("droplet-notext")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.top)
                VStack {
                    TextField("Type message here...", text: $note)
                      .padding(10)
                        .frame( width: 350, height: 600)
                      .font(.largeTitle)
                    HStack {
                        Button(action: {
                            let dropletData = [
                                "note": self.note,
                                "latitude": locationManager.latitude,
                                "longitude": locationManager.longitude
                            ] as [String : Any]
                            
                            let docRef = Firestore.firestore().document("droplets/\(UUID().uuidString)")
                            
                            print("Setting data")
                            docRef.setData(dropletData) { (error) in
                                if let error = error {
                                    
                                } else {
                                    print("data uploaded successfully")
                                    self.note = ""
                                    viewRouter.currentPage = .page2

                                }
                                
                                
                            }
                            
                        }) {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .padding(20)
                                .padding(.bottom, 30)
                                .opacity(0.8)
                        }
                        Button(action: {
                            viewRouter.currentPage = .page1
                        }) {
                            Image(systemName: "x.circle")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .padding(20)
                                .padding(.bottom, 30)
                                .opacity(0.8)
                        }
                    }
                }
            }
        }
}

struct MessageFormView_Previews: PreviewProvider {
    static var previews: some View {
        MessageFormView()
    }
}

