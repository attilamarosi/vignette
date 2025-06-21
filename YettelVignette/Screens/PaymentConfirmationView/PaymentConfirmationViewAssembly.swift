// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct PaymentConfirmationViewAssembly {
    
    static func createView(purchaseItem: VignettePurchaseItem) -> some View {
        let formatter = PaymentConfirmationFormatter()
        let repository = GlobalRepositoryImpl()
        let viewModel = PaymentConfirmationViewModel(formatter: formatter,
                                                     repository: repository,
                                                     purchaseItem: purchaseItem)
        
        return PaymentConfirmationView(viewModel: viewModel)
    }
}
