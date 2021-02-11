//
//  Message.swift
//  Droplet1
//
//  Created by Ada on 2/5/21.
//

import SwiftUI

class Message: ObservableObject {
    @Published var message: String?
    @Published var date: Date?
}
