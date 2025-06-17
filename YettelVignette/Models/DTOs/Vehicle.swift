// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

struct Vehicle: Codable {
    var country: Country
    var name: String
    var plateNumber: String
    var registrationCode: String
    var type: VehicleCategoryType
    var vignetteType: String?
    
    private enum CodingKeys: String, CodingKey {
        case registrationCode = "internationalRegistrationCode"
        case plateNumber = "plate"
        case country, name, type, vignetteType
    }
}
