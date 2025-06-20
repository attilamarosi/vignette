// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

struct CountyVignetteFormatter {
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
    
    func formatToHUF(_ amount: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.alwaysShowsDecimalSeparator = false
        formatter.groupingSeparator = " "
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        formatter.locale = Locale(identifier: "hu_HU")
        
        return formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
    }
}
