// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct HighwayVignettePreviewAssembly {
    
    static func makePreview() -> some View {
        let formatter = HighwayVignetteFormatter()
        let repository = GlobalRepositoryImpl()
        let router = HighwayVignetteRouter.mock
        let viewModel = HighwayVignetteViewModel(formatter: formatter,
                                                 repository: repository,
                                                 router: router)
        
        return HighwayVignetteView(viewModel: viewModel)
    }
}
