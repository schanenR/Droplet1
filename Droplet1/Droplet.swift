//
//  Droplet.swift
//  Droplet1
//
//  Created by Ada on 2/4/21.
//

import SwiftUI

struct Droplet {
    var note: String
    var latitude: Double
    var longitude: Double
}

#if DEBUG

let testData = [
    Droplet(note: "Hello - I just wanted to let know that your dog escaped the fence earlier!", latitude: 47.05487674228555, longitude: -122.88365710236887),
    
    Droplet(note: "Hi Trav, I stopped by to say hi but nobody was home. Miss you. : )", latitude: 47.05593478624946, longitude: -122.88456905343476),
    
    Droplet(note: "Please be red!", latitude: 47.06195938506906, longitude: -122.88471856024981),
    
]

#endif
