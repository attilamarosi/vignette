// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

struct CountyVignetteFormatter: BaseFormatter {
    func createUIModel(from vignettes: VignetteResponse?) -> CountyVignetteUIModel? {
        guard let vignettes else {
            return nil
        }
        
        let counties = vignettes.payload.counties
        
        let models: [CountyVignette] = vignettes.payload.highwayVignettes.flatMap { highwayVignette in
            counties
                .filter { county in
                    highwayVignette.vignetteType.contains(county.id)
                }
                .map { county in
                    CountyVignette(id: county.id,
                                   name: county.name,
                                   price: highwayVignette.sum,
                                   formattedPrice: formatToHUF(highwayVignette.sum),
                                   isSelected: false)
                }
        }
        
        return CountyVignetteUIModel(counties: models)
    }

}
