// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

class PaymentFinishedRouter {
    
    // MARK: - Properties
    private let rootCordinator: NavigationCoordinator
    
    var id: UUID
    
    // MARK: - Initialization
    init(rootCordinator: NavigationCoordinator,
         id: UUID) {
        self.rootCordinator = rootCordinator
        self.id = id
    }
}

// MARK: - View assembly
extension PaymentFinishedRouter: Routable {
    
    func makeView() -> AnyView {
        let viewModel = PaymentFinishedViewModel(router: self)
        let view = PaymentFinishedView(viewModel: viewModel)
        
        return AnyView(view)
    }
    
    // MARK: - Routing to views
    func navigateBackToRoot() {
        rootCordinator.popToRoot()
    }
}

// MARK: - Hashing
extension PaymentFinishedRouter {
    static func == (lhs: PaymentFinishedRouter, rhs: PaymentFinishedRouter) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

// MARK: - Mocking for preview
extension PaymentFinishedRouter {
    static let mock: PaymentFinishedRouter = PaymentFinishedRouter(rootCordinator: AppRouter(),
                                                                   id: UUID())
}
