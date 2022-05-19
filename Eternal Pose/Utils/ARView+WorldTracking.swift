//
//  ARView+WorldTracking.swift
//  Eternal Pose Markers
//
//  Created by Bigabiro Mpogazi Fabrice on 5/18/22.
//

import Foundation
import RealityKit
import ARKit

extension ARView: ARCoachingOverlayViewDelegate {
    
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
}
