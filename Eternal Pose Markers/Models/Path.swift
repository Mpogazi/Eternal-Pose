//
//  Path.swift
//  Eternal Pose Markers
//
//  Created by Bigabiro Mpogazi Fabrice on 5/10/22.
//

import Foundation
import simd

// This path assumes the initial location of the root node
// is the first element in the array
// Also it assumes that the last element is the destination node
class Path {
    var nodes: [Node] = []
    var isRootNodeSet: Bool = false
    
    public func setRootNode(location: simd_float4x4) {
        if !nodes.isEmpty {
            nodes[0].setTransform(transform: location)
            
            // Setting up the first node as the root/start
            nodes[0].nodeName = "Start"
            nodes[0].nodeType = .root
        }
        self.isRootNodeSet.toggle()
        
        // updating the transform of other nodes
        self.updateRestWithReferenceToRoot()
        
        // Setting up the last node as the destination
        nodes[nodes.count - 1].nodeName = "Destination"
        nodes[nodes.count - 1].nodeType = .destination
    }
    
    private func updateRestWithReferenceToRoot() {
        let root = nodes[0]
        let z_offset = nodes[0].transformMatrix.columns.3.z
        
        // updating the XY transforms for the nodes
        for i in 1..<nodes.count {
            let x_offset = Float(nodes[i].XYCoordinates.x - root.XYCoordinates.x)
            // Scaling back the y_offset to meters
            let y_offset = Float((nodes[i].XYCoordinates.y - root.XYCoordinates.y) / CONSTANTS.meterScalingFactor)
            
            nodes[i].moveToOrFromCamera(distance: y_offset)
            nodes[i].moveRightOrLeft(distance: x_offset)
            nodes[i].moveUpOrDown(distance: z_offset)
        }
    }
    
    public func addNode(node: Node) -> Void {
        nodes.append(node)
    }
    
    public func rootNode() -> Node? { nodes.first }
    
    class func pathFromRoutingService(routingServicePath: [RoutingServiceVertex]) -> Path {
        let path = Path()
        
        for vertex in routingServicePath {
            var node: Node = Node()
            
            node.coordinates.latitude = vertex.vertex.latitude
            node.coordinates.longitude = vertex.vertex.longitude
            
            path.addNode(node: node)
        }
        return path
    }
}
