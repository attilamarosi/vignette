// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

public enum VignetteType: String, Codable {
    case day    = "DAY"
    case week   = "WEEK"
    case month  = "MONTH"
    case year   = "YEAR"
    
    var localizedString: String {
        String(localized: "vignette-\(self.rawValue.lowercased())")
    }
}
