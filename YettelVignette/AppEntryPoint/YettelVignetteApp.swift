// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

@main
struct YettelVignetteApp: App {
    
    @StateObject private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(router)
        }
    }
}
