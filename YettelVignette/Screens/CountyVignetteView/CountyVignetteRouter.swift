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


extension CountyVignetteRouter: Routable {
    
    func makeView() -> AnyView {
        let formatter = CountyVignetteFormatter()
        let viewModel = CountyVignetteViewModel(formatter: formatter,
                                                vehicle: vehicle,
                                                vignetteResponse: vignetteResponse)
        let view = CountyVignetteView(viewModel: viewModel)
        
        return AnyView(view)
    }
}

extension CountyVignetteRouter {
    static func == (lhs: CountyVignetteRouter, rhs: CountyVignetteRouter) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
