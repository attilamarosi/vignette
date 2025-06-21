// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

struct HighwayVignetteMainFormatter: BaseFormatter {
    
    func createUIModel(from vehicleResponse: VehicleResponse,
                       vignetteResponse: VignetteResponse) -> HighwayVignetteUIModel? {
        let country = Country(hu: vehicleResponse.country.hu,
                              en: vehicleResponse.country.en)
        
        let vehicle = Vehicle(country: country,
                              name: vehicleResponse.name,
                              plateNumber: makePurePlateNumber(vehicleResponse.plate),
                              registrationCode: vehicleResponse.internationalRegistrationCode,
                              type: VehicleCategoryType(rawValue: vehicleResponse.type) ?? .car,
                              vignetteType: vehicleResponse.vignetteType)
        
        let availableVignettes = vignetteResponse.payload.highwayVignettes
            .filter { $0.vehicleCategory == vehicle.type.rawValue } // Filter out all the vignettes that are not applied for the user's vehicle category
            .filter { $0.vignetteType.count == 1 }                  // Filter out all the county vignettes
        
        // Update the vignettes with the formatted price and product name
        let highwayVignettes = availableVignettes
            .compactMap { vignette -> VignetteModel in
                var productName = ""
                var detailedName = ""
                
                if let vignetteType = vignette.vignetteType.first {
                    detailedName = String(localized: "vignette-\(vignetteType.lowercased())")
                    productName = "\(vehicle.vignetteType ?? "")"
                }
                
                return VignetteModel(id: vignette.vignetteType.joined(separator: "-"),
                                     productName: productName,
                                     detailedName: detailedName,
                                     price: formatToHUF(vignette.sum),
                                     vignetteType: vignette.vignetteType.first,
                                     selected: false)
            }
        
        return HighwayVignetteUIModel(vehicle: vehicle,
                                      highwayVignettes: highwayVignettes)
    }
    
    func updatePurchaseItem(with vignette: [VignetteOrderItem],
                            for vehicle: Vehicle,
                            fee: Int) -> VignettePurchaseItem {
        VignettePurchaseItem(fee: fee,
                             plateNumber: vehicle.plateNumber,
                             vehicleCategory: vehicle.type,
                             vignette: vignette)
    }
    
    private func makePurePlateNumber(_ plateNumber: String) -> String {
        plateNumber
            .uppercased()
            .replacingOccurrences(of: "-", with: " ")
            .replacingOccurrences(of: "[^A-Z0-9 ]+", with: "", options: .regularExpression)
    }
    
}
