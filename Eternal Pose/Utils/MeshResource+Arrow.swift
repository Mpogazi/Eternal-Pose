//
//  MeshResource+Arrow.swift
//  Eternal Pose Markers
//
//  Created by Bigabiro Mpogazi Fabrice on 5/18/22.
//

import Foundation
import RealityKit

extension MeshResource {
    // generates an Arrow that's scaled in meters
    static func generateArrow(scale: Float = 0.5) -> MeshResource {
        
        let positions: [SIMD3<Float>] = [[0.00, 1.00, 0.00], [-1.0, 0.00, 0.00], [-0.75, 0.0, 0.00],
                                         [0.00, 0.75, 0.00], [0.75, 0.00, 0.00], [1.00, 0.00, 0.00]]
        let indices: [UInt32] = [0, 1, 2, 3, 4, 5]
        
        var meshDescriptor: MeshDescriptor = .init(name: "Arrow")
        meshDescriptor.positions = .init(positions)
        meshDescriptor.primitives = .polygons([6], indices)
        
        return try! self.generate(from: [meshDescriptor])
    }
}
