// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct PaymentConfirmationView: View {
    
    @ObservedObject var viewModel: PaymentConfirmationViewModel
    
    var body: some View {
        AsyncContentView(viewModel: viewModel) {
            Text("")
        }
    }
}

// MARK: - Previews
#Preview {
    PaymentConfirmationViewAssembly.createView()
}
