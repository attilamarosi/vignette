// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

protocol GlobalRepository {
    func fetchVignettes() async throws -> VignetteResponse
    func fetchUserVehicle() async throws -> VehicleResponse
}

struct GlobalRepositoryImpl: GlobalRepository, NetworkService {
    
    func fetchVignettes() async throws -> VignetteResponse {
        try await request(endpoint: .info)
    }
    
    func fetchUserVehicle() async throws -> VehicleResponse {
        try await request(endpoint: .vehicle)
    }
}
