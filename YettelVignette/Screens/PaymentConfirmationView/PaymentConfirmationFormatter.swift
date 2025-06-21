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
        
        let model = PaymentConfirmationUIModel(orderItems: orderItems,
                                               fee: formattedFee,
                                               platenumber: purchaseItem.plateNumber)
        return model
    }
}
