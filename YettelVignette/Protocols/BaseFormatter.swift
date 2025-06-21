// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

protocol BaseFormatter {
    func formatToHUF(_ amount: Int) -> String
}

// Default implementation
extension BaseFormatter {
    func formatToHUF(_ amount: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.alwaysShowsDecimalSeparator = false
        formatter.groupingSeparator = " "
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        formatter.locale = Locale(identifier: "hu_HU")
        
        return formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
    }
}
