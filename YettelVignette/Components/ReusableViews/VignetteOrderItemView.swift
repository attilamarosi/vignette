// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct VignetteOrderItemView: View {
    
    let name: String
    let price: String
    
    var body: some View {
        HStack {
            Text(name)
                .font(.headingMain)
            Spacer()
            Text(price)
                .font(.paragraphMain)
                .foregroundStyle(.colorDarkerGrey)
        }
    }
}

// MARK: - Previews
#Preview {
    VignetteOrderItemView(name: "Győr-Moson-Sopron",
                          price: "5280 Ft")
}
