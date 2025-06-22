// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct CustomNavigationView: View {
    
    @StateObject var appRouter: AppRouter

    var body: some View {
        NavigationStack(path: $appRouter.paths) {
            appRouter.resolveInitialRouter()
                .makeView()
                .wrapWithYettelNavigation(canGoBack: false, onBack: nil)
                .navigationDestination(for: AnyRoutable.self) { route in
                    route.makeView()
                        .wrapWithYettelNavigation(canGoBack: true) {
                            appRouter.paths.removeLast()
                        }
                        .navigationBarHidden(true) // Hide the factory nav bar
                }
        }
    }
}

// MARK: - Wrapper extension
extension View {
    func wrapWithYettelNavigation(canGoBack: Bool, onBack: (() -> Void)?) -> some View {
        YettelNavigationBarContainerView(canGoBack: canGoBack, onBack: onBack) {
            self
        }
    }
}

// MARK: - Previews
#Preview {
    CustomNavigationView(appRouter: AppRouter())
}
