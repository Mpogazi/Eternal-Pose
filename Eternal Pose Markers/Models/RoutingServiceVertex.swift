//
//  routingVertexModel.swift
//  Eternal Pose Markers
//
//  Created by Bigabiro Mpogazi Fabrice on 5/16/22.
//

import Foundation

struct Vertex: Decodable {
    //var vertexType: Int
    //var y: Int
    var latitude: Double
    var longitude: Double
}

// A vertex from the routing service
// This service is independent of this app
//
struct RoutingServiceVertex: Decodable {
    var vertex: Vertex
    var distance: Int
}
