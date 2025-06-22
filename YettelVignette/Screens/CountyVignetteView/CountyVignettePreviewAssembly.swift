// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct CountyVignettePreviewAssembly {
    
    static func makePreview() -> some View {
        let formatter = CountyVignetteFormatter()
        let router = CountyVignetteRouter.mock
        let viewModel = CountyVignetteViewModel(formatter: formatter,
                                                router: router,
                                                vehicle: Mocks.vehicle,
                                                vignetteResponse: nil)
        return CountyVignetteView(viewModel: viewModel)
    }
}
