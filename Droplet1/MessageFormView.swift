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
    @State private var recipient: String = ""
    @State private var showingAlert = false
    @State private var defaultAlert = false
  
    init() {
            UITextView.appearance().backgroundColor = .clear
        }

    var body: some View {
        ZStack {
            Image("dropletupdateblank")
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
                        if note.text == "" || note.text == "Type message here..." {
                            showingAlert = true
                        } else {
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "MMM dd, YYYY  hh:mm a"
                            let dateTime = Date()
                            
                            let dropletData = [
                                "note": note.text,
                                "latitude": locationManager.latitude,
                                "longitude": locationManager.longitude,
                                "date": dateFormatter.string(from: dateTime)
                            ] as [String : Any]
                            
                            let docRef = Firestore.firestore().document("droplets/\(UUID().uuidString)")
                            
                            print("Setting data")
                            docRef.setData(dropletData) { (error) in
                                if let error = error {
                                    print(error)
                                } else {
                                    print("data uploaded successfully")
                                    note.text = ""
                                    ViewRouter.shared.currentPage = .page2
                                }
                            }
                        }
                    }) {
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.white)
                            .font(.system(size: 60))
                            .padding(20)
                            .padding(.bottom, 30)
                            .opacity(0.8)
                    }
                    Button(action: {
                        ViewRouter.shared.currentPage = .page2
                    }) {
                        Image(systemName: "x.circle")
                            .foregroundColor(.white)
                            .font(.system(size: 60))
                            .padding(20)
                            .padding(.bottom, 30)
                            .opacity(0.8)
                    }
                }
                .alert(isPresented: $showingAlert) {
                    () -> Alert in
                    Alert(title: Text("Message can't be blank or default"), message: Text("Please fill in a message to submit."), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}

class TextEditorManager: ObservableObject {
    @Published var text = "" {
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

