//
//  ARViewContainer.swift
//  Droplet1
//
//  Created by Ada on 2/4/21.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let dropletAnchor = try! ModelProjectDroplet.loadScene()
        
        // Add the box anchor to the scene
        arView.scene.addAnchor(dropletAnchor)
        
        dropletAnchor.actions.dropletTapped.onAction = handleTapOnEntity(_:)

        print("scene created")
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context){
    }
    
    func handleTapOnEntity(_: Entity?) {
        print("What up?")
    }

}

#if DEBUG
struct ARViewContainer_Previews : PreviewProvider {
    static var previews: some View {
        ARViewContainer()
    }
}
#endif

