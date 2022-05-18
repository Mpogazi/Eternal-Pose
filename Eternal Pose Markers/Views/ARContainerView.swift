//
//  ARContainerView.swift
//  Eternal Pose Markers
//
//  Created by Bigabiro Mpogazi Fabrice on 5/6/22.
//

import SwiftUI
import ARKit
import RealityKit
import SceneKit

struct ARContainerView: UIViewRepresentable {
    @Binding var isNavigating: Bool
    @Binding var pathData: Path
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        let session = arView.session
        
        arView.automaticallyConfigureSession = false
        
        // add ARWorldTrackingConfiguration
        arView.setupWorldTracking()
        
        // add OverlayCoachingView
        arView.addCoaching()
        
        
        context.coordinator.view = arView
        context.coordinator.pathData = pathData
        session.delegate = context.coordinator
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        weak var view: ARView?
        weak var pathData: Path?
        
        
        func session(_ session: ARSession, didUpdate frame: ARFrame) {}
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let arImageAnchor = anchors.first as? ARImageAnchor else { return }
            
            if CONSTANTS.referenceImages.contains(arImageAnchor.name!) {
                if !pathData!.isRootNodeSet {
                    pathData?.setRootNode(location: arImageAnchor.transform)
                    
                    view!.addAnchorsFromNodes(nodes: pathData!.nodes)
                }
            }
        }
        
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {}
        
        func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {}
    }
}
