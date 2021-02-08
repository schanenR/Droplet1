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
    
    @State private var note = "Type message here..."
    
    @EnvironmentObject var viewRouter: ViewRouter
    @ObservedObject var locationManager = LocationManager()

    init() {
            UITextView.appearance().backgroundColor = .clear
        }

        var body: some View {
            ZStack {
                Image("droplet-notext")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack {
//                    Text("New Droplet")
//                        .padding(.top, 50)
//                        .padding(.bottom, 60)
//                        .font(.largeTitle)
//                        .foregroundColor(.white)
                    TextEditor(text: self.$note)
                        
                        .onAppear {
                            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                                withAnimation {
                                    if self.note == "Type message here..." {
                                        self.note = ""
                                    }
                                }
                            }
                         
                            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                                withAnimation {
                                    if self.note == "" {
                                        self.note = "Type message here..."
                                    }
                                }
                            }
                        }
                        .font(.title)
                        .padding(.top, 250)
                        .foregroundColor(.white)
                        .frame(width: 300)
                        .gesture(DragGesture().onEnded { value in
                            let deltaY = value.location.y - value.startLocation.y
                            if deltaY > 0 {
                                UIApplication.shared.endEditing(true)
                            }
                        })
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

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter { $0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct MessageFormView_Previews: PreviewProvider {
    static var previews: some View {
        MessageFormView()
    }
}

