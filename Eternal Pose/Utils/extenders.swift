//
//  extenders.swift
//  Eternal Pose Markers
//
//  Created by Bigabiro Mpogazi Fabrice on 5/10/22.
//

import Foundation
import RealityKit
import ARKit
import SceneKit

extension ARView: ARCoachingOverlayViewDelegate {
    func addCoaching() {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = self.session
        coachingOverlay.goal = .horizontalPlane
        self.addSubview(coachingOverlay)
    }
    
    func setupWorldTracking() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        
        // object occlusion if it exists on the device
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
            self.environment.sceneUnderstanding.options.insert(.occlusion)
        } else {
            print("Object Occlusion not supported on your device")
        }
        
        // People occlusion
        if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
            config.frameSemantics = .personSegmentationWithDepth
        } else {
            print("People occlusion is not supported on your device")
        }
        
        // Image tracking
        if let ARImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main) {
            config.detectionImages = ARImages
        } else {
            print("Image could not be detected.")
        }
        self.session.run(config)
        
    }
     
    func addAnchorFromNode(node: Node, isFiller: Bool) {
        let anchor = ARAnchor(name: node.nodeName, transform: node.transformMatrix)
        self.session.add(anchor: anchor)
        
        let anchorEntity = AnchorEntity(world: anchor.transform)
        anchorEntity.addChild(Entity.generateSphericalIndicator(title: node.nodeName))
        
        // Moving the text up a  little bit
        if !isFiller {
            let textEntity = ModelEntity.textDescriptionsEntity(title: node.nodeName)
            textEntity.position.y += 0.3
            textEntity.position.x += 0.3
            anchorEntity.addChild(textEntity)
        }
        
        self.scene.addAnchor(anchorEntity)
    }
    
    func addAnchorsFromNodes(nodes: [Node]) {
        
        for node in nodes {
            let anchor = ARAnchor(name: node.nodeName, transform: node.transformMatrix)
            self.session.add(anchor: anchor)
            
            let anchorEntity = AnchorEntity(world: anchor.transform)
            //anchorEntity.addChild(Entity.generateSphericalIndicator(title: node.nodeName))
            anchorEntity.addChild(.generateArrowIndicator())
            
            self.scene.addAnchor(anchorEntity)
        }
    }
}

extension Entity {
    static func generateSphericalIndicator(title: String) -> Entity {
        let indicatorEntity = Entity()
        let sphere = ModelEntity.blueSphere.clone(recursive: true)
        
        indicatorEntity.addChild(sphere)
        
        return indicatorEntity
    }
    
    static func generateArrowIndicator() -> Entity {
        let arrowEntity = Entity()
        let arrow: ModelEntity = .arrow.clone(recursive: true)
        arrowEntity.addChild(arrow)
        return arrowEntity
    }
    
}

extension ModelEntity {
    static let blueSphere = ModelEntity(mesh: MeshResource.generateSphere(radius: 0.1),
                                        materials: [SimpleMaterial(color: .blue, isMetallic: false)])
    static let arrow = ModelEntity(mesh: .generateArrow(), materials: [SimpleMaterial(color: .green, isMetallic: false)])
    
    static func textDescriptionsEntity(title: String) -> ModelEntity {
        let text = MeshResource.generateText(title, extrusionDepth: 0.0, font: .systemFont(ofSize: 0.3),
                                             containerFrame: .zero, alignment: .center, lineBreakMode: CTLineBreakMode.byWordWrapping)
        
        let material = UnlitMaterial(color: .red)
        let textEntity = ModelEntity(mesh: text, materials: [material])
        
        return textEntity
    }
    

}
