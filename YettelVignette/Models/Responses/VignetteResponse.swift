// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

struct VignetteResponse: Codable {
    let requestId: Int
    let statusCode: String
    let payload: Payload
    let dataType: String
}

struct Payload: Codable {
    let highwayVignettes: [HighwayVignette]
    let vehicleCategories: [VehicleCategory]
    let counties: [County]
}

struct HighwayVignette: Codable {
    let cost: Int
    let sum: Int
    let trxFee: Int
    let vehicleCategory: String
    let vignetteType: [String]
}

struct VehicleCategory: Codable {
    let category: String
    let vignetteCategory: String
    let name: LocalizedName
}

struct LocalizedName: Codable {
    let hu: String
    let en: String
}
