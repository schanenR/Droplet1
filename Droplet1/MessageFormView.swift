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

    @EnvironmentObject var  session: SessionStore
    @ObservedObject var locationManager = LocationManager()
    @StateObject var note = TextEditorManager()
    @State private var showingAlert = false
    @State private var defaultAlert = false
    @State private var privateEmail = false
    @State var recipient: String = ""
    
    private var db = Firestore.firestore()
    
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
                VStack {
                    if session.session != nil {
                        Text("ADD USER EMAIL FOR PRIVATE MESSAGE")
                        HStack {
                            Spacer()
                            Text("To:")
                            TextField("PUBLIC", text: $recipient).multilineTextAlignment(.leading)
                                .padding(10)
                                .frame(maxWidth: 250)
                                .foregroundColor(.white)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 1))
                            Spacer()
                        }
                    }
                    TextEditor(text: $note.text)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 1))
                        .onAppear {
                            let notificationCenter = NotificationCenter.default
                            
                            notificationCenter.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                                withAnimation {
                                    print("DEBUG DEBUG - keyboard show")
                                    if note.text == "type message here..." {
                                        print(note.text)
                                        note.text = ""
                                        print(note.text)
                                    }
                                }
                            }
                            notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                                withAnimation {
                                    print("DEBUG DEBUG - keyboard away")
                                    if note.text == "" {
                                        print("DEBUG DEBUG - note is empty")
                                        note.text = "type message here..."
                                    }
                                }
                            }
                        }
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 320, height: 300)
                        .gesture(DragGesture().onEnded { value in
                            let deltaY = value.location.y - value.startLocation.y
                            if deltaY > 0 {
                                UIApplication.shared.endEditing(true)
                            }
                        })
                }.padding(.top, 150)
                Text("\(note.text.count)/200")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                HStack {
                    Button(action: {
                        if note.text == "" || note.text == "type message here..." {
                            showingAlert = true
                        } else {
                            let lowerRecipient = recipient.lowercased()
                            
                            db.collection("emails").whereField("email", isEqualTo: lowerRecipient)
                                .getDocuments() { (querySnapshot, err) in
                                    if let err = err {
                                        print(err)
                                    } else {
                                        if querySnapshot!.count > 0 {
                                            print("DEBUG: \(querySnapshot!.count) emails FOUND")
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.dateFormat = "MMM dd, YYYY  hh:mm a"
                                            let dateTime = Date()
                                            
                                            let lotusData = [
                                                "note": note.text,
                                                "latitude": locationManager.latitude,
                                                "longitude": locationManager.longitude,
                                                "date": dateFormatter.string(from: dateTime),
                                                "isPrivate": true,
                                                "recipient": lowerRecipient,
                                                "sender": session.session!.email!
                                            ] as [String : Any]
                                            
                                            let docRef = Firestore.firestore().document("Lotus/\(UUID().uuidString)")
                                            
                                            print("Setting data")
                                            docRef.setData(lotusData) { (error) in
                                                if let error = error {
                                                    print(error)
                                                } else {
                                                    print("LOTUS uploaded successfully")
                                                    note.text = ""
                                                    ViewRouter.shared.currentPage = .page2
                                                }
                                            }
                                        } else if privateEmail == false && recipient == "" {
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.dateFormat = "MMM dd, YYYY  hh:mm a"
                                            let dateTime = Date()
                                            
                                            let dropletData = [
                                                "note": note.text,
                                                "latitude": locationManager.latitude,
                                                "longitude": locationManager.longitude,
                                                "date": dateFormatter.string(from: dateTime),
                                                "isPrivate": false
                                            ] as [String : Any]
                                            
                                            let docRef = Firestore.firestore().document("droplets/\(UUID().uuidString)")
                                            
                                            print("Setting data")
                                            docRef.setData(dropletData) { (error) in
                                                if let error = error {
                                                    print(error)
                                                } else {
                                                    print("DROPLET uploaded successfully")
                                                    note.text = ""
                                                    ViewRouter.shared.currentPage = .page2
                                                }
                                            }
                                        } else {
                                            showingAlert = true
                                        }
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
                    Alert(title: Text("Message OR Email Error"), message: Text("Please fill in a message to submit. Recipient email must be valid or blank."), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}

class TextEditorManager: ObservableObject {
    
    var text = "type message here..." {
        willSet {
            objectWillChange.send()
        }
        didSet {
            if text.count > 200 && oldValue.count <= 200 {
                text = oldValue
                objectWillChange.send()
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

