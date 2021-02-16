//
//  GetDropletData.swift
//  Droplet1
//
//  Created by Ada on 2/7/21.


import Firebase
import FirebaseFirestore


class GetDropletData: ObservableObject {

    init() {
    }

    @Published var droplets = [Droplet]()
    @Published var allLotus = [Lotus]()

    private var db = Firestore.firestore()
    
    
    func fetchDropletData() {

        db.collection("droplets").addSnapshotListener { (snap, err) in
            guard let documents = snap?.documents else {
                print("No documents")
                return
            }
            
            self.droplets = documents.map { (snap) -> Droplet in
                let data = snap.data()
                
                let id = data["id"] as? String ?? ""
                let note = data["note"] as? String ?? ""
                let latitude = data["latitude"] as? Double ?? 0
                let longitude = data["longitude"] as? Double ?? 0
                let date = data["date"] as? String ?? ""

                return Droplet(id: id, note: note, latitude: latitude, longitude: longitude, date: date)

            }
        }
    }
    
    func fetchLotusData(email: String) {
        
        db.collection("Lotus").whereField("recipient", isEqualTo: email).addSnapshotListener { (snap, err) in
            guard let documents = snap?.documents else {
                print("No documents")
                return
            }
            
            self.allLotus = documents.map { (snap) -> Lotus in
                let data = snap.data()
                
                let id = data["id"] as? String ?? ""
                let note = data["note"] as? String ?? ""
                let latitude = data["latitude"] as? Double ?? 0
                let longitude = data["longitude"] as? Double ?? 0
                let date = data["date"] as? String ?? ""
                let sender = data["sender"] as? String ?? ""
                let recipient = data["recipient"] as? String ?? ""
 
                return Lotus(id: id, note: note, latitude: latitude, longitude: longitude, date: date, senderEmail: sender, recipientEmail: recipient)
            }
        
        }
    }
}
