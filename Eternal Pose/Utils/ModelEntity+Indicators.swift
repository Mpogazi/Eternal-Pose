//
//  ModelEntity+Indicators.swift
//  Eternal Pose
//
//  Created by Bigabiro Mpogazi Fabrice on 5/18/22.
//

import Foundation
import RealityKit
import ARKit

extension ModelEntity {
    static let blueSphere: ModelEntity = .init(mesh: .generateSphere(radius: 0.1), materials: [SimpleMaterial(color: .blue, isMetallic: false)])
    static let arrow: ModelEntity = .init(mesh: .generateArrow(), materials: [SimpleMaterial(color: .green, isMetallic: false)])
    
    
    static func textDescriptionsEntity(title: String) -> ModelEntity {
        let text: MeshResource = .generateText(title, extrusionDepth: 0.0, font: .systemFont(ofSize: 0.3), containerFrame: .zero, alignment: .center, lineBreakMode: .byWordWrapping)
        
        let material: UnlitMaterial = .init(color: .red)
        let textEntity: ModelEntity = .init(mesh: text, materials: [material])
        
        return textEntity
    }
}
