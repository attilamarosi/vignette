// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

class PaymentConfirmationRouter {
    
    // MARK: - Private Properties
    private let rootCordinator: NavigationCoordinator
    
    var id: UUID
    
    // MARK: - Passed items
    var purchaseItem: VignettePurchaseItem
    
    // MARK: - Initialization
    init(rootCordinator: NavigationCoordinator,
         id: UUID,
         purchaseItem: VignettePurchaseItem) {
        self.rootCordinator = rootCordinator
        self.id = id
        self.purchaseItem = purchaseItem
    }
    
    // MARK: - Routing to views
    func navigateToHighwayVignettes() {
        let router = HighwayVignetteRouter(rootCordinator: rootCordinator,
                                           id: UUID())
        rootCordinator.push(router)
    }
    
    func navigateToPaymentFinished() {
        let router = PaymentFinishedRouter(rootCordinator: rootCordinator,
                                           id: UUID())
        rootCordinator.push(router)
    }
    
    func navigateBack() {
        rootCordinator.popLast()
    }
}

// MARK: - View assembly
extension PaymentConfirmationRouter: Routable {
    func makeView() -> AnyView {
        let formatter = PaymentConfirmationFormatter()
        let repository = GlobalRepositoryImpl()
        let viewModel = PaymentConfirmationViewModel(formatter: formatter,
                                                     repository: repository,
                                                     router: self,
                                                     purchaseItem: purchaseItem)
        let view = PaymentConfirmationView(viewModel: viewModel)
        
        return AnyView(view)
    }
}

// MARK: - Hashing
extension PaymentConfirmationRouter {
    static func == (lhs: PaymentConfirmationRouter, rhs: PaymentConfirmationRouter) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

// MARK: - Mocking for preview
extension PaymentConfirmationRouter {
    static let mock: PaymentConfirmationRouter = PaymentConfirmationRouter(rootCordinator: AppRouter(),
                                                                           id: UUID(),
                                                                           purchaseItem: Mocks.purchaseItem)
}
