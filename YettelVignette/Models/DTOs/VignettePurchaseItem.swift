// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

/// Represents the data of the vehicle and the selected vignette(s) to be purchased
struct VignettePurchaseItem {
    var fee: Int
    var plateNumber: String
    var vehicleCategory: VehicleCategoryType
    var vignette: [VignetteOrderItem]
}
