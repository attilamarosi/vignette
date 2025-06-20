// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

public enum VignetteType: String, Codable {
    case day    = "DAY"
    case week   = "WEEK"
    case month  = "MONTH"
    case year   = "YEAR"
    
    var localizedString: String {
        let lowercased = self.rawValue.lowercased()
        return String(localized: "vignette-\(lowercased)")
//        String(localized: "vignette-\(self.rawValue.lowercased())")
    }
}
