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
    
//    @State private var note = "Type message here..."

    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var note = TextEditorManager()

    init() {
            UITextView.appearance().backgroundColor = .clear
        }

    var body: some View {
        ZStack {
            Image("droplet-notext")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                Text("\(note.text.count)/200")
                    .font(.footnote)
                    .padding(.top, 250)
                    .multilineTextAlignment(.center)
                TextEditor(text: $note.text)
                    .onAppear {
                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                            withAnimation {
                                if note.text == "Type message here..." {
                                    note.text = ""
                                }
                            }
                        }
                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                            withAnimation {
                                if note.text == "" {
                                    note.text = "Type message here..."
                                }
                            }
                        }
                    }
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 320)
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
                                note.text = ""
                                ViewRouter.shared.currentPage = .page2
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
                        ViewRouter.shared.currentPage = .page1
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

class TextEditorManager: ObservableObject {
    @Published var text = "Type message here..." {
        didSet {
            if text.count > 200 && oldValue.count <= 200 {
                text = oldValue
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

