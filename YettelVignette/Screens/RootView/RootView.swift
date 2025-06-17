// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct RootView: View {
    var body: some View {
        VStack {
           Text("Hello")
                .font(.yettelFont(size: .displayLarge, type: .klavikaBold))
        }
    }
}

// MARK: - Previews
#Preview {
    RootView()
}
