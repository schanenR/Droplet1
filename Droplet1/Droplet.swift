//
//  Droplet.swift
//  Droplet1
//
//  Created by Ada on 2/4/21.
//

import SwiftUI

struct Droplet : Identifiable {
    var id: String
    var note: String
    var latitude: Double
    var longitude: Double
}

#if DEBUG

let testData = [
    Droplet(id: "000", note: "Hello - I just wanted to let know that your dog escaped the fence earlier!", latitude: 47.05487674228555, longitude: -122.88365710236887),
    
    Droplet(id: "001", note: "Hi Trav, I stopped by to say hi but nobody was home. Miss you. : )", latitude: 47.05593478624946, longitude: -122.88456905343476),
    
    Droplet(id: "002", note: "Please be red!", latitude: 47.06195938506906, longitude: -122.88471856024981),
    Droplet(id: "003", note: "Thank you so much for the LOX bagel, : D Loving my ethiopian take-out diet but I never say no to lox. Yum!", latitude: 47.671421767307756, longitude: -122.30893498408551),
    Droplet(id: "004", note: "Thank you so much for the LOX bagel, : D Loving my ethiopian take-out diet but I never say no to lox. Yum!", latitude: 47.67061960500426, longitude: -122.30960520102539),
    Droplet(id: "005", note: "Hey Reeky boo!", latitude: 47.62786458663793, longitude: -122.35509375072131),
    Droplet(id: "005", note: "Oh heyy!", latitude: 47.60338477136267, longitude: -122.31226185452594)
]

#endif
