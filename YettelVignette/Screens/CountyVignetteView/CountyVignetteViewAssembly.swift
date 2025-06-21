// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct CountyVignetteViewAssembly {
    
    static func createView(vignetteResponse: VignetteResponse?,
                           vehicle: Vehicle) -> some View {
        let formatter = CountyVignetteFormatter()
        let viewModel = CountyVignetteViewModel(formatter: formatter,
                                                vehicle: vehicle,
                                                vignetteResponse: vignetteResponse)
        
        return CountyVignetteView(viewModel: viewModel)
    }
}
