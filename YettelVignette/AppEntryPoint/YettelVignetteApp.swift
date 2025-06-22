// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

@main
struct YettelVignetteApp: App {
    
    @StateObject var appRouter = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            CustomNavigationView(appRouter: appRouter)
        }
    }
}
