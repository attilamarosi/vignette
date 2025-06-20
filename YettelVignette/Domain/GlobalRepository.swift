// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

protocol GlobalRepository {
    func getHighwayVignettes() async throws -> NationWideVignetteResponse
    func getUserVehicle() async throws -> VehicleResponse
}

struct GlobalRepositoryImpl: GlobalRepository, NetworkService {
    
    func getHighwayVignettes() async throws -> NationWideVignetteResponse {
        try await request(endpoint: .info)
    }
    
    func getUserVehicle() async throws -> VehicleResponse {
        try await request(endpoint: .vehicle)
    }
}
