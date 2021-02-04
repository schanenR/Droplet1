//
//  ContentView.swift
//  Droplet1
//
//  Created by Ada on 2/3/21.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let dropletAnchor = try! ModelProjectDroplet.loadScene()
        
        // Add the box anchor to the scene
        arView.scene.addAnchor(dropletAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context){
//        if uiView.notifications.dropletTapped.post() {
    }
    
//    arView.scene.notifications.dropletTapped.post() = isTapped()
//    
//    func isTapped() {}

}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
