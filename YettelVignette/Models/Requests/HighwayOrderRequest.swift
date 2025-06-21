// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

struct HighwayOrderRequest: NetworkModel {
    var statusCode: String?
    var highwayOrders: [VignetteOrderItem]
}

struct VignetteOrderItem: Codable {
    let type: String
    let category: String
    let cost: Double
}
