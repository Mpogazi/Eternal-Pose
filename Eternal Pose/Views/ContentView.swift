//
//  ContentView.swift
//  Eternal Pose Markers
//
//  Created by Bigabiro Mpogazi Fabrice on 5/6/22.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @State var isNavigating: Bool = true
    @State var pathData: Path = .pathFromRoutingService(routingServicePath: sampleRoutingServicePath)
    @State var showSearchControl: Bool = false
    @State var showMapControl: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARContainerView(isNavigating: $isNavigating, pathData: $pathData)
            
            ControlView(isNavigating: $isNavigating,
                        showSearchControl: $showSearchControl,
                        showMapControl: $showMapControl)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
