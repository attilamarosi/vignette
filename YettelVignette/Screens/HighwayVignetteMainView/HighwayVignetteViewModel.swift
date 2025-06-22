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

class HighwayVignetteViewModel: AsyncViewModel {
    
    // MARK: - Published Properties
    @Published var viewState: ViewState = .idle
    @Published var uiModel: HighwayVignetteUIModel?
    @Published var vignetteSelected = false
    
    var showPopupSubject = PassthroughSubject<PopupModel, Never>()
    
    // MARK: - Properties required for the view
    private(set) var purchaseItem: VignettePurchaseItem?
    private var apiVehicleResponse: VehicleResponse?
    
    var apiVignetteResponse: VignetteResponse?
        
    // MARK: - Private Properties
    private let formatter: HighwayVignetteFormatter
    private let repository: GlobalRepository
    private let router: HighwayVignetteRouter
    
    // MARK: - Initialization
    init(formatter: HighwayVignetteFormatter,
         repository: GlobalRepository,
         router: HighwayVignetteRouter) {
        self.formatter = formatter
        self.repository = repository
        self.router = router
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
            // Handle errors
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
              let selectedVignetteModel = uiModel?.highwayVignettes.first(where: { $0.selected }),
              let selectedVignetteType = selectedVignetteModel.vignetteType else {
            return
        }
        
        let vignettePayload: HighwayVignette? = apiVignetteResponse?.payload.highwayVignettes
            .filter { $0.vignetteType.contains(selectedVignetteType) }
            .first
            
        guard let vignettePayload else {
            return
        }
        
        let fee = vignettePayload.trxFee
        let cost = vignettePayload.cost
      
        let orderItem = VignetteOrderItem(type: selectedVignetteModel.detailedName,
                                          category: selectedVignetteModel.productName,
                                          cost: Double(cost),
                                          vignetteCategory: selectedVignetteType)
        
        purchaseItem = formatter.updatePurchaseItem(with: [orderItem],
                                                    for: vehicle,
                                                    fee: fee)
    }
    
    // MARK: - Routing
    func navigateToCountyVignette() {
        guard let vehicle = uiModel?.vehicle else {
            return
        }
        
        router.navigateToCountyVignette(vehicle: vehicle,
                                        vignetteResponse: apiVignetteResponse)
    }
    
    func navigateToPaymentConfirmation() {
        guard let purchaseItem else {
            return
        }
        
        router.navigateToPaymentConfirmation(purchaseItem: purchaseItem)
    }
}
