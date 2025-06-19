// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct YettelNavigationView: View {
    var showBackButton: Bool = true
    var topInset: CGFloat = 0 // Passed from parent
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.colorLime)
                .frame(height: .height72 + topInset)
                .clipShape(RoundedCornerShape(corners: [.bottomLeft, .bottomRight],
                                              radius: .cornerRadius24))
                .overlay(
                    VStack {
                        Spacer()
                        HStack {
                            if showBackButton {
                                Button {
                                    // Action
                                } label: {
                                    Image("icon-arrow-back")
                                }

                                Text("E-matrica")
                                    .font(.headingMain)
                                    .foregroundStyle(.colorNavy)
                            }
                            Spacer()
                        }
                        .padding()
                        .padding(.top, topInset) // Ensure content isn’t under notch
                    }
                )
        }
        .background(.colorGrey)
    }
}

// MARK: - Previews
#Preview {
    YettelNavigationView()
}
