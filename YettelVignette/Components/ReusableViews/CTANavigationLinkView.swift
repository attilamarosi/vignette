// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct CTANavigationLinkView: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.headingLarge)
                Spacer()
                Image("icon-chevron-right")
            }
            .frame(height: .height72)
            .padding(.horizontal, .padding16)
            .background(.colorWhite)
            .cornerRadius(.cornerRadius16)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Previews
#Preview {
    CTANavigationLinkView(title: "Éves vármegyei matricák",
                          action: {})
}
