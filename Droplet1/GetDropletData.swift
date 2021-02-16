//
//  GetDropletData.swift
//  Droplet1
//
//  Created by Ada on 2/7/21.


import Firebase
import FirebaseFirestore

class GetDropletData: ObservableObject {

    @Published var droplets = [Droplet]()

    private var db = Firestore.firestore()
    
    func fetchData() {

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
        
        db.collection("Lotus").addSnapshotListener { (snap, err) in
            guard let documents = snap?.documents else {
                print("No documents")
                return
            }
            
            self.allLotus = documents.map { (snap) -> Droplet in
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
}
