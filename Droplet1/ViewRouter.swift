//
//  ViewRouter.swift
//  Droplet1
//
//  Created by Ada on 2/4/21.
//

import SwiftUI

class ViewRouter: ObservableObject {
    
    static let shared = ViewRouter()
    
    @Published var currentPage: Page = .page1
}
