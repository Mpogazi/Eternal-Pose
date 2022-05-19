//
//  ARView+AnchorNodes.swift
//  Eternal Pose Markers
//
//  Created by Bigabiro Mpogazi Fabrice on 5/18/22.
//

import Foundation
import RealityKit
import ARKit

extension ARView {
    func addAnchorsFromNodes(nodes: [Node]) {
        
        for node in nodes {
            let anchor = ARAnchor(name: node.nodeName, transform: node.transformMatrix)
            self.session.add(anchor: anchor)
            
            let anchorEntity = AnchorEntity(world: anchor.transform)
            anchorEntity.addChild(Entity.generateSphericalIndicator(title: node.nodeName))
            //anchorEntity.addChild(.generateArrowIndicator())
            
            let textEntity = ModelEntity.textDescriptionsEntity(title: node.nodeName)
            textEntity.position.y += 0.3
            textEntity.position.x += 0.3
            
            anchorEntity.addChild(textEntity)
            
            
            self.scene.addAnchor(anchorEntity)
        }
    }
}
