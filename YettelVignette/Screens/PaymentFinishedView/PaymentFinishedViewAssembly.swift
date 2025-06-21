// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct PaymentFinishedViewAssembly {
    
    static func createView() -> some View {
        
        let viewModel = PaymentFinishedViewModel()
        
        return PaymentFinishedView(viewModel: viewModel)
    }
}
