// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

class CountyVignetteRouter {
    
    // MARK: - Properties
    private let rootCordinator: NavigationCoordinator
    
    var id: UUID
    
    // MARK: - Properties that are passed from  another view
    var vehicle: Vehicle
    var vignetteResponse: VignetteResponse?
    
    // MARK: - Initialization
    init(rootCordinator: NavigationCoordinator,
         id: UUID,
         vehicle: Vehicle,
         vignetteResponse: VignetteResponse?) {
        self.rootCordinator = rootCordinator
        self.id = id
        self.vehicle = vehicle
        self.vignetteResponse = vignetteResponse
    }
}

// MARK: - View assembly
extension CountyVignetteRouter: Routable {
    
    func makeView() -> AnyView {
        let formatter = CountyVignetteFormatter()
        let viewModel = CountyVignetteViewModel(formatter: formatter,
                                                router: self,
                                                vehicle: vehicle,
                                                vignetteResponse: vignetteResponse)
        let view = CountyVignetteView(viewModel: viewModel)
        
        return AnyView(view)
    }
    
    // MARK: - Routing to views
    func navigateToPaymentConfirmation(purchaseItem: VignettePurchaseItem) {
        let router = PaymentConfirmationRouter(rootCordinator: rootCordinator,
                                               id: id,
                                               purchaseItem: purchaseItem)
        rootCordinator.push(router)
    }
}

// MARK: - Hashing
extension CountyVignetteRouter {
    static func == (lhs: CountyVignetteRouter, rhs: CountyVignetteRouter) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

// MARK: - Mocking for preview
extension CountyVignetteRouter {
    static let mock: CountyVignetteRouter = CountyVignetteRouter(rootCordinator: AppRouter(),
                                                                 id: UUID(),
                                                                 vehicle: Mocks.vehicle,
                                                                 vignetteResponse: nil)
}
