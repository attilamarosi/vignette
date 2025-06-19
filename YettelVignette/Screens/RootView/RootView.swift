// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject private var router: Router
    @StateObject private var viewModel = RootViewModel()
    
    var body: some View {
        YettelNavigationBarContainerView(path: $router.navigationPath) {
            
            // Content
            AsyncContentView(viewModel: viewModel) {
                ScrollView {
                    VStack {
                        Button {
                            router.push(to: .order)
                        } label: {
                            Text("go")
                        }

                    }
                    .padding(.padding16)
                }
                
                
            }
            // Fires necessary tasks when view appears
            .task {
                viewModel.handleOnAppear()
            }
            // Handles navigation destinations
            .navigationDestination(for: Routes.self) { route in
                switch route {
                case .order:
                    VignetteOrderDetailView()
                }
            }
            
        }
    }
}

// MARK: - Previews
#Preview {
    RootView()
        .environmentObject(Router())
        .environmentObject(RootViewModel())
}
