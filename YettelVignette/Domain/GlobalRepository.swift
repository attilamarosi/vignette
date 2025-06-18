// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

protocol GlobalRepository {
    
}

struct GlobalRepositoryImpl: GlobalRepository, NetworkService {
    
    func getOrders() async throws -> [County] {
        try await request(apiVersion: .v1, endpoint: .order, method: .get, query: nil, body: nil)
    }
}
