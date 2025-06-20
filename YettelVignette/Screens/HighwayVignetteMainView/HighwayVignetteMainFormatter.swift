// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

struct HighwayVignetteMainFormatter {
    
    func createUIModel(from vehicleResponse: VehicleResponse,
                       vignetteResponse: NationWideVignetteResponse) -> HighwayVignetteUIModel? {
        let country = Country(hu: vehicleResponse.country.hu,
                              en: vehicleResponse.country.en)
        
        let vehicle = Vehicle(country: country,
                              name: vehicleResponse.name,
                              plateNumber: makePurePlateNumber(vehicleResponse.plate),
                              registrationCode: vehicleResponse.internationalRegistrationCode,
                              type: VehicleCategoryType(rawValue: vehicleResponse.type) ?? .car)
        
        let availableVignettes = vignetteResponse.payload.highwayVignettes.filter({ $0.vehicleCategory == vehicle.type.rawValue })
        
        let highwayVignettes = availableVignettes.compactMap { vignette -> VignetteModel in
            var productName = ""
            if let vignetteType = vignette.vignetteType.first {
                productName = VignetteType(rawValue: vignetteType)?.localizedString ?? ""
            }
            
            return VignetteModel(id: vignette.vignetteType.joined(separator: "-"),
                                 productName: productName,
                                 price: formatToHUF(vignette.sum))
        }
      
        return HighwayVignetteUIModel(vehicle: vehicle,
                                      highwayVignettes: highwayVignettes)
    }
    
    private func makePurePlateNumber(_ plateNumber: String) -> String {
        plateNumber
            .uppercased()
            .replacingOccurrences(of: "-", with: " ")
            .replacingOccurrences(of: "[^A-Z0-9 ]+", with: "", options: .regularExpression)
    }
    
    private func formatToHUF(_ amount: Int) -> String {
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
