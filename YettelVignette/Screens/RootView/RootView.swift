// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct RootView: View {
    
    @StateObject var viewModel: RootViewModel
    
    var body: some View {
        // Content
        AsyncContentView(viewModel: viewModel) {
            VStack {
                CTAButton(style: .primary,
                          title: String(localized: "purchase_vignette_title")) {
                    viewModel.navigateToHighwayVignettes()
                }
            }
            .padding(.padding16)
        }
        // Fires necessary tasks when view appears
        .task {
            viewModel.handleOnAppear()
        }
        .navigationTitle("Yettel")
    }
}

#Preview {
    RootView(viewModel: RootViewModel(router: .mock))
}
