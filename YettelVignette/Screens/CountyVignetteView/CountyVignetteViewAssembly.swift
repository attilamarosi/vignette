// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct CountyVignetteViewAssembly {
    
    static func createView(vignettes: VignetteResponse?) -> some View {
        let formatter = CountyVignetteFormatter()
        let viewModel = CountyVignetteViewModel(formatter: formatter,
                                                vignettes: vignettes)
        
        return CountyVignetteView(viewModel: viewModel)
    }
}
