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
        var descr = MeshDescriptor(name: "Arrow")
        descr.positions = MeshBuffers.Positions([
            [0.00, 1.00, 0.00],
            [-1.0, 0.00, 0.00],
            [-0.75, 0.0, 0.00],
            [0.00, 0.75, 0.00],
            [0.75, 0.00, 0.00],
            [1.00, 0.00, 0.00]
        ])
        descr.primitives = .polygons([0,1,2,3,4,5],[])
        return try! self.generate(from: [descr])
    }
}
