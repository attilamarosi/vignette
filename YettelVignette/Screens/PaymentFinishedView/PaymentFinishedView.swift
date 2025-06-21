// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct PaymentFinishedView: View {
    
    @StateObject var viewModel: PaymentFinishedViewModel
    
    var body: some View {
        AsyncContentView(viewModel: viewModel) {
            ZStack(alignment: .top) {
                // Background color
                Color.colorLime.ignoresSafeArea()
                
                // Confetti image
                Image("confetti")
                
                // Text & graphics
                VStack {
                    Spacer()
                    Text("payment_success_title")
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                        .font(.headingExtraLarge)
                    HStack {
                        Spacer()
                        Image("payment_finish")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: .height300)
                    }
                    // Button
                    CTAButton(style: .primary,
                              title: String(localized: "common_ok_long")) {
                        
                    }
                }
                .padding(.padding16)
            }
        }
        .task {
            viewModel.handleOnAppear()
        }
    }
}

// MARK: - Previews
#Preview {
    PaymentFinishedViewAssembly.createView()
        .environment(\.locale, .init(identifier: "hu_HU"))
}
