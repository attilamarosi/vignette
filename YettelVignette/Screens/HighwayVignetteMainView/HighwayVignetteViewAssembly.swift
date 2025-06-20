// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct HighwayVignetteViewAssembly {
    
    static func createView() -> some View {
        let formatter = HighwayVignetteMainFormatter()
        let repository = GlobalRepositoryImpl()
        let viewModel = HighwayVignetteMainViewModel(formatter: formatter,
                                                     repository: repository)
        
        return HighwayVignetteMainView(viewModel: viewModel)
    }
}
