// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

struct VehicleResponse: Codable {
    let requestId: Int
    let statusCode: String
    let internationalRegistrationCode: String
    let type: String
    let name: String
    let plate: String
    let country: LocalizedCountry
    let vignetteType: String
}

struct LocalizedCountry: Codable {
    let hu: String
    let en: String
}
