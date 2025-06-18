// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject private var router: Router
    @StateObject private var viewModel = RootViewModel()
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            
          EmptyView()
            
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
