// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

class AppRouter: ObservableObject {
    
    @Published var paths = NavigationPath()
    
    func resolveInitialRouter() -> any Routable {
        let rootView = RootViewRouter(rootCordinator: self, id: UUID())
        return rootView
    }
}

// MARK: - Push, Pop, Pop to root
extension AppRouter: NavigationCoordinator {
    func push(_ router: any Routable) {
        DispatchQueue.main.async { [weak self] in
            let wrappedRouter = AnyRoutable(router)
            self?.paths.append(wrappedRouter)
        }
    }
    
    func popLast() {
        DispatchQueue.main.async {
            self.paths.removeLast()
        }
    }
    
    func popToRoot() {
        DispatchQueue.main.async {
            self.paths.removeLast(self.paths.count)
        }
    }
}
