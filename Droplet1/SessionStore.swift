//
//  SessionStore.swift
//  Droplet1
//
//  Created by Ada on 2/12/21.
//

import SwiftUI
import Firebase
import Combine

class SessionStore: ObservableObject {
    
    static var shared = SessionStore()
    
    @Published var session: User? {didSet {self.didChange.send(self) }}
    @Published var isAnon: Bool = false
    
    var didChange = PassthroughSubject<SessionStore, Never>()
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                self.isAnon = false
                self.session = User(uid: user.uid, email: user.email)
            } else {
                self.session = nil
                self.isAnon = true
            }
        })
    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
        let casedEmail = email.lowercased()
        
        let newEmail = [
            "email": casedEmail
        ] as [String : Any]
        
        let docRef = Firestore.firestore().document("emails/\(UUID().uuidString)")
        
        print("Setting data")
        
        docRef.setData(newEmail) { (error) in
            if let error = error {
                print(error)
            } else {
                print("data uploaded successfully")
            }
        }
        
    }
    
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.session = nil
        } catch {
            print("Error signing out")
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
}

struct User {
    var uid: String
    var email: String?
    
    init(uid: String, email: String?) {
        self.uid = uid
        self.email = email
    }
}
