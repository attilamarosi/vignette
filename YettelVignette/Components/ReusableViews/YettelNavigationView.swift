// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct YettelNavigationView: View {
    
    @Binding var title: String
    var topInset: CGFloat = 0 // Passed from parent
    
    let canGoBack: Bool
    let onBack: (() -> Void)?
    
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
                            if canGoBack {
                                Button {
                                    // Action
                                    onBack?()
                                } label: {
                                    Image("icon-arrow-back")
                                }

                                // Title
                                Text(title)
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
        .background(.colorWhite)
    }
}

// MARK: - Previews
#Preview {
    YettelNavigationView(title: .constant("Yettel"),
                         canGoBack: false,
                         onBack: {})
}
