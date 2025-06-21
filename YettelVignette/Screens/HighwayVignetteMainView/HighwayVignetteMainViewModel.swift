// Copyright © 2025 Attila Marosi. All rights reserved.

import Combine

/// Represents the UI model presented on the screen
struct HighwayVignetteUIModel {
    let vehicle: Vehicle
    var highwayVignettes: [VignetteModel]
}

struct VignetteModel: Identifiable {
    let id: String
    let productName: String
    let detailedName: String
    let price: String
    let vignetteType: String?
    var selected: Bool
}

class HighwayVignetteMainViewModel: AsyncViewModel {
    
    // MARK: - Published Properties
    @Published var viewState: ViewState = .idle
    @Published var uiModel: HighwayVignetteUIModel?
    @Published var vignetteSelected = false
    
    var showPopupSubject = PassthroughSubject<PopupModel, Never>()
    
    private(set) var purchaseItem: VignettePurchaseItem?
    private var apiVehicleResponse: VehicleResponse?
    
    var apiVignetteResponse: VignetteResponse?
        
    // MARK: - Private Properties
    private let formatter: HighwayVignetteMainFormatter
    private let repository: GlobalRepository
    
    // MARK: - Initialization
    init(formatter: HighwayVignetteMainFormatter,
         repository: GlobalRepository) {
        self.formatter = formatter
        self.repository = repository
    }
    
    // MARK: - Public Methods
    @MainActor
    func handleOnAppear() async {
        do {
            viewState = .loading
            
            async let vehicleResponse = repository.fetchUserVehicle()
            async let vignetteResponse = repository.fetchVignettes()
            
            let (vehicle, vignettes) = try await (vehicleResponse, vignetteResponse)
            
            uiModel = formatter.createUIModel(from: vehicle,
                                              vignetteResponse: vignettes)
            apiVignetteResponse = vignettes
            apiVehicleResponse = vehicle
            
            viewState = .finished
            
        } catch let error as APIError {
            let errorModel = ErrorModel(error: error) {
                Task {
                    await self.handleOnAppear()
                }
            }
            
            viewState = .error(errorModel)
        } catch {
            // TODO: Handle errors
        }
    }
    
    func selectVignette(at index: Int) {
        guard var vignettes = uiModel?.highwayVignettes else { return }
        
        for i in vignettes.indices {
            vignettes[i].selected = (i == index)
        }
        
        vignetteSelected = true
        uiModel?.highwayVignettes = vignettes
        updatePurchaseItem()
    }
    
    private func updatePurchaseItem() {
        guard let vehicle = uiModel?.vehicle,
              let vignettes = uiModel?.highwayVignettes,
              let category = apiVignetteResponse?.payload.vehicleCategories.first,
              let vignetteCategory = apiVignetteResponse?.payload.counties.first?.id,
              let selectedVignetteModel = uiModel?.highwayVignettes.first(where: { $0.selected }),
              let identifiedVignette = apiVignetteResponse?.payload.highwayVignettes.first(where: { $0.vignetteType.first == selectedVignetteModel.id }) else {
            return
        }
      
        let fee = identifiedVignette.trxFee
        let cost = identifiedVignette.cost
        
        let orderItem = vignettes
            .compactMap { vignette -> VignetteOrderItem? in
                VignetteOrderItem(type: vignette.productName,
                                  category: category.vignetteCategory,
                                  cost: Double(cost),
                                  vignetteCategory: vignetteCategory)
            }

        purchaseItem = formatter.updatePurchaseItem(with: orderItem,
                                                    for: vehicle,
                                                    fee: fee)
    }
}
