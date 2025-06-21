// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

protocol GlobalRepository {
    func fetchVignettes() async throws -> VignetteResponse
    func fetchUserVehicle() async throws -> VehicleResponse
    func makeOrder(_ order: HighwayOrderRequest) async throws -> VignetteOrderResponse
}

struct GlobalRepositoryImpl: GlobalRepository, NetworkService {
    
    func fetchVignettes() async throws -> VignetteResponse {
        try await request(endpoint: .info)
    }
    
    func fetchUserVehicle() async throws -> VehicleResponse {
        try await request(endpoint: .vehicle)
    }
    
    func makeOrder(_ order: HighwayOrderRequest) async throws -> VignetteOrderResponse {
        try await request(endpoint: .order,
                          method: .post,
                          body: order)
    }
}
