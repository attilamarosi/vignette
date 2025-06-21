// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

public enum VignetteType: String, Codable, CaseIterable {
    case day    = "DAY"
    case week   = "WEEK"
    case month  = "MONTH"
    case year   = "YEAR"
    
    var localizedString: String {
        "vignette-\(self.rawValue.lowercased())"
    }
}
