// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

enum Endpoint: String {
    case info       // Retrieve highway vignette information
    case order      // Place an order for highway vignettes
    case vehicle    // Retrieve vehicle information
    
    var urlSuffix: String {
        "/highway/\(self.rawValue)"
    }
}
