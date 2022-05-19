//
//  Entity+Indicators.swift
//  Eternal Pose Markers
//
//  Created by Bigabiro Mpogazi Fabrice on 5/18/22.
//

import Foundation
import RealityKit
import ARKit

extension Entity {
    static func generateSphericalIndicator(title: String) -> Entity {
        let indicatorEntity: Entity = .init()
        let sphere: ModelEntity = .blueSphere.clone(recursive: true)
        
        indicatorEntity.addChild(sphere)
        
        return indicatorEntity
    }
    
    static func generateArrowIndicator() -> Entity {
        let arrowEntity: Entity = .init()
        let arrow: ModelEntity = .arrow.clone(recursive: true)
        arrowEntity.addChild(arrow)
        return arrowEntity
    }
}
