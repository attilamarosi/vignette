// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

class HighwayVignetteRouter {
    
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
extension HighwayVignetteRouter: Routable {
    func makeView() -> AnyView {
        let formatter = HighwayVignetteFormatter()
        let repository = GlobalRepositoryImpl()
        let viewModel = HighwayVignetteViewModel(formatter: formatter,
                                                     repository: repository,
                                                     router: self)
        let view = HighwayVignetteView(viewModel: viewModel)
        
        return AnyView(view)
    }
    
    // MARK: - Routing to views
    func navigateToCountyVignette(vehicle: Vehicle,
                                  vignetteResponse: VignetteResponse?) {
        let router = CountyVignetteRouter(rootCordinator: rootCordinator,
                                          id: id,
                                          vehicle: vehicle,
                                          vignetteResponse: vignetteResponse)
        rootCordinator.push(router)
    }
    
    func navigateToPaymentConfirmation(purchaseItem: VignettePurchaseItem) {
        let router = PaymentConfirmationRouter(rootCordinator: rootCordinator,
                                               id: id,
                                               purchaseItem: purchaseItem)
        rootCordinator.push(router)
    }
}

// MARK: - Hashing
extension HighwayVignetteRouter {
    static func == (lhs: HighwayVignetteRouter, rhs: HighwayVignetteRouter) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

// MARK: - Mocking for preview
extension HighwayVignetteRouter {
    static let mock: HighwayVignetteRouter = HighwayVignetteRouter(rootCordinator: AppRouter(),
                                                                   id: UUID())
}
