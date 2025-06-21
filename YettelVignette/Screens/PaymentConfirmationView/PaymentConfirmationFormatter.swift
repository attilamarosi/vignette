// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

struct PaymentConfirmationFormatter: BaseFormatter {
    
    func createUIModel(from purchaseItem: VignettePurchaseItem) -> PaymentConfirmationUIModel? {
        
        let orderItems: [VignetteOrderItemUIModel] = purchaseItem.vignette
            .compactMap { orderItem -> VignetteOrderItemUIModel in
                
                let formattedPrice = formatToHUF(Int(orderItem.cost))
                
                return VignetteOrderItemUIModel(name: orderItem.type,
                                                price: formattedPrice)
            }
        
        let formattedFee = formatToHUF(purchaseItem.fee)
        
        let vignettePrices = purchaseItem.vignette.compactMap({ $0.cost }).reduce(0, +)
        let prices = Int(vignettePrices)
        let total = calculateSum(amount: purchaseItem.fee, prices)
        
        let vignetteType = purchaseItem.vignette.first?.type
        let vignetteCategory = purchaseItem.vignette.first?.vignetteCategory
        
        let model = PaymentConfirmationUIModel(orderItems: orderItems,
                                               fee: formattedFee,
                                               productName: getProductName(for: vignetteType),
                                               platenumber: purchaseItem.plateNumber,
                                               summary: formatToHUF(total),
                                               vignetteCategory: getProductName(for: vignetteCategory))
        return model
    }
    
    private func calculateSum(amount: Int...) -> Int {
        amount.reduce(0, +)
    }
    
    private func getProductName(for value: String?) -> String? {
        guard let value else { return nil }
        
        // As we don't get hungarian names for day, week, month etc vignettes, a hardcoded localalized string will be displayed
        if value.contains("YEAR-") {
            return "vignette-year-nationwide"
        } else {
            return VignetteType(rawValue: value)?.localizedString
        }
    }
}
