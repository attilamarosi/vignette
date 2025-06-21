// Copyright © 2025 Attila Marosi. All rights reserved.

import Combine

struct CountyVignetteUIModel {
    var counties: [CountyVignette]
    var total: String?
}

struct CountyVignette {
    let id: String
    let name: String
    let price: Int
    let formattedPrice: String
    var isSelected: Bool
}

class CountyVignetteViewModel: AsyncViewModel {
    
    // MARK: - Published Properties
    @Published var viewState: ViewState = .idle
    @Published var uiModel: CountyVignetteUIModel?
    
    @Published var selectedIds: Set<String> = []
    @Published var purchaseItem: VignettePurchaseItem?
    
    var showPopupSubject = PassthroughSubject<PopupModel, Never>()
    
    // MARK: - Private Properties
    private let formatter: CountyVignetteFormatter
    
    private let vehicle: Vehicle
    private var vignetteResponse: VignetteResponse?
    
    // MARK: - Initialization
    init(formatter: CountyVignetteFormatter,
         vehicle: Vehicle,
         vignetteResponse: VignetteResponse?) {
        self.formatter = formatter
        self.vehicle = vehicle
        self.vignetteResponse = vignetteResponse
    }
    
    // MARK: - Public Methods
    
    @MainActor
    func handleOnAppear() async {
        // We need to keep the selected items in case the user navigates back from payment confirmation screen
        guard uiModel == nil else { return }
        
        viewState = .loading
        uiModel = formatter.createUIModel(from: vignetteResponse)
        viewState = .finished
    }
    
    func selectVignette(at index: Int) {
        guard var vignettes = uiModel?.counties else { return }
        
        vignettes[index].isSelected.toggle()
        uiModel?.counties = vignettes
        updateSelectedIds(at: index)
        updatePurchaseItem()
        updateSum()
    }
    
    // MARK: - Private Methods
    private func updateSelectedIds(at index: Int) {
        guard let vignettes = uiModel?.counties, vignettes.isNonempty else { return }
        
        if vignettes[index].isSelected {
            selectedIds.insert(vignettes[index].id)
        } else {
            selectedIds.remove(vignettes[index].id)
        }
    }
    
    private func updateSum() {
        guard let vignettes = uiModel?.counties else { return }
        
        var total = 0
        
        vignettes.forEach { vignette in
            if vignette.isSelected {
                total += vignette.price
            }
        }
        
        uiModel?.total = formatter.formatToHUF(total)
    }
    
    private func updatePurchaseItem() {
        guard let vignettes = uiModel?.counties,
              let category = vignetteResponse?.payload.vehicleCategories.first,
              let vignetteCategory = vignetteResponse?.payload.counties.first?.id,
              let fee = vignetteResponse?.payload.highwayVignettes.first(where: { $0.vehicleCategory == vehicle.type.rawValue })?.trxFee else {
            return
        }
        
        // As all the vignettes IDs containing 'YEAR', we can identify the same product category
        
      
        let orderItems = vignettes
            .compactMap { vignette -> VignetteOrderItem? in
                guard selectedIds.contains(vignette.id) else {
                    return nil
                }
                
                let item = VignetteOrderItem(type: vignette.name,
                                             category: category.vignetteCategory,
                                             cost: Double(vignette.price),
                                             vignetteCategory: vignetteCategory)
                return item
            }
        
        purchaseItem = formatter.updatePurchaseItem(with: orderItems,
                                                    for: vehicle,
                                                    fee: fee)
    }
}
