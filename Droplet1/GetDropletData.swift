//
//  GetDropletData.swift
//  Droplet1
//
//  Created by Ada on 2/7/21.
//

//import Firebase
//import FirebaseFirestore
//
//class getDroletData: ObservableObject {
//
//    @Published var droplets = [Droplet]()
//
//    init() {
//
//        let db = Firestore.firestore()
//
//        db.collection("droplets").addSnapshotListener { (snap, err) in
//
//            if err != nil {
//
//                print((err?.localizedDescription)!)
//                return
//            }
//
//            for i in snap!.documentChanges {
//
//                let id = i.document.documentID
//                let note = i.document.get("note") as! String
//                let latitude = i.document.get("latitude") as! Double
//                let longitude = i.document.get("longitude") as! Double
//
//                self.droplets.append(Droplet(id: id, note: note, latitude: latitude, longitude: longitude))
//            }
//        }
//    }
//}
//import Firebase
//
//class getDropletData: ObservableObject {
//    
//    @Published var droplets = [Droplet]()
//    
//    init() {
//        
//        let db = Firestore.firestore()
//        
//        db.collection("droplets").addDocument(data: ["note": "Howdy, does this app work?", "latitude": 47.671421767307756, "longitude": -122.30893498408551])
//    }
//}


