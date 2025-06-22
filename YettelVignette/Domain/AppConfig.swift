// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

/// App Configuration uses the BASE_URL and BASE_PORT properties stored in the .xcconfig files associated with the various schemes to build the application’s base URL.
struct AppConfig {
    
    private let baseURL: String
    private let basePort: Int
    
    var apiBaseURL: URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = baseURL
        components.port = basePort
        return components.url
    }
    
    // MARK: - Initialization
    init?(bundle: Bundle = .main) {
        guard let baseURL = bundle.object(forInfoDictionaryKey: "BASE_URL") as? String,
              let portString = bundle.object(forInfoDictionaryKey: "BASE_PORT") as? String,
              let basePort = Int(portString) else {
            return nil
        }
        
        self.baseURL = baseURL
        self.basePort = basePort
    }
}
