//
//  Node.swift
//  Eternal Pose Markers
//
//  Created by Bigabiro Mpogazi Fabrice on 5/10/22.
//

import Foundation
import simd
import ARKit

enum NodeType: String, Decodable {
    case root
    case destination
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Node {
    var nodeType: NodeType?
    var transformMatrix: simd_float4x4 = matrix_identity_float4x4
    var coordinates: CLLocationCoordinate2D = .init()
    var nodeName: String = "node"
    
    var XYCoordinates: Point {
        get {
            let x: Double = CONSTANTS.earthRadius * self.coordinates.longitude * cos(
                (CONSTANTS.Floor7ReferenceCoordinates.latitude1 + CONSTANTS.Floor7ReferenceCoordinates.latitude2) / 2)
            let y: Double = CONSTANTS.earthRadius * self.coordinates.latitude
            return Point(x: x, y: y)
        }
    }
    
    public mutating func setTransform(transform: simd_float4x4) {
        self.transformMatrix = transform
    }
    
    public mutating func moveRightOrLeft(distance: Float) {
        self.transformMatrix.columns.3.x = self.transformMatrix.columns.3.x + distance
    }
    
    public mutating func moveUpOrDown(distance: Float) {
        self.transformMatrix.columns.3.y = self.transformMatrix.columns.3.y + distance
    }
    
    public mutating func moveToOrFromCamera(distance: Float) {
        self.transformMatrix.columns.3.z = self.transformMatrix.columns.3.z + distance
    }
}
