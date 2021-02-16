//
//  ARViewContainer.swift
//  Droplet1
//
//  Created by Ada on 2/4/21.


import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {

    func makeUIView(context: Context) -> ARView {
        
            let arView = ARView(frame: .zero)
            
        if GoogleMapsView.userMessage.isPrivate == true {
            let dropletAnchor = try! PinkLotus.loadScene()

            arView.scene.addAnchor(dropletAnchor)
            dropletAnchor.actions.lotusTap.onAction = handleTapOnEntity(_:)
        } else {
            let dropletAnchor = try! ThreeDDroplet.loadScene()
            
            arView.scene.addAnchor(dropletAnchor)
            dropletAnchor.actions.dropletTapped.onAction = handleTapOnEntity(_:)
        }

        print("scene created")
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context){
    }
    
    func handleTapOnEntity(_: Entity?) {
        ViewRouter.shared.currentPage = .page4
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

