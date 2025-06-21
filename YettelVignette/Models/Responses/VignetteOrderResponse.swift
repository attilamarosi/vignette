// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

struct VignetteOrderResponse: NetworkModel {
    let statusCode: String?
    let receivedOrders: [VignetteOrderItem]?
}
