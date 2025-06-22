// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

class RootViewRouter {
    
    // MARK: - Private Properties
    private let rootCordinator: NavigationCoordinator
    
    var id: UUID
    
    // MARK: - Initialization
    init(rootCordinator: NavigationCoordinator,
         id: UUID) {
        self.rootCordinator = rootCordinator
        self.id = id
    }
    
    // MARK: - Routing to views
    func navigateToHighwayVignettes() {
        let router = HighwayVignetteRouter(rootCordinator: rootCordinator,
                                           id: UUID())
        rootCordinator.push(router)
    }
}

// MARK: - View assembly
extension RootViewRouter: Routable {
    func makeView() -> AnyView {
        let viewModel = RootViewModel(router: self)
        let rootView = RootView(viewModel: viewModel)
        return AnyView(rootView)
    }
}

// MARK: - Hashing
extension RootViewRouter {
    static func == (lhs: RootViewRouter, rhs: RootViewRouter) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

// MARK: - Mocking for preview
extension RootViewRouter {
    static let mock: RootViewRouter = RootViewRouter(rootCordinator: AppRouter(),
                                                     id: UUID())
}
