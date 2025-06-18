// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct HorizontalRulerView: View {
    var body: some View {
        Rectangle()
            .frame(height: .height1)
            .foregroundStyle(.colorGrey)
            .padding(.horizontal, .padding16)
        
    }
}

// MARK: - Previews
#Preview {
    HorizontalRulerView()
}
