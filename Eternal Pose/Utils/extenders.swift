//
//  extenders.swift
//  Eternal Pose Markers
//
//  Created by Bigabiro Mpogazi Fabrice on 5/10/22.
//

import Foundation
import RealityKit
import ARKit

extension ARView {
    func addCoaching() {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = self.session
        coachingOverlay.goal = .horizontalPlane
        self.addSubview(coachingOverlay)
    }
}
