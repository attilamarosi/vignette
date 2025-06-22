// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct CustomNavigationView: View {
    
    @StateObject var appRouter: AppRouter
    
    var body: some View {
        NavigationStack(path: $appRouter.paths) {
            appRouter.resolveInitialRouter().makeView()
                .navigationDestination(for: AnyRoutable.self) { router in
                    router.makeView()
                }
        }
    }
}

// MARK: - Previews
#Preview {
    CustomNavigationView(appRouter: AppRouter())
}
