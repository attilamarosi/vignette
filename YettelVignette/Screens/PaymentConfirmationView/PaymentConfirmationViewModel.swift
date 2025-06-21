// Copyright © 2025 Attila Marosi. All rights reserved.

import Combine

struct PaymentConfirmationUIModel {
    let orderItems: [VignetteOrderItemUIModel]
    let fee: String
    let platenumber: String
}

struct VignetteOrderItemUIModel {
    let name: String
    let price: String
}

class PaymentConfirmationViewModel: AsyncViewModel {
    
    // MARK: - Published Properties
    @Published var viewState: ViewState = .idle
    @Published var uiModel: PaymentConfirmationUIModel?
    
    var showPopupSubject = PassthroughSubject<PopupModel, Never>()
    
    // MARK: - Private Properties
    private let formatter: PaymentConfirmationFormatter
    private let repository: GlobalRepository
    
    private let purchaseItem: VignettePurchaseItem
    
    // MARK: - Initialization
    init(formatter: PaymentConfirmationFormatter,
         repository: GlobalRepository,
         purchaseItem: VignettePurchaseItem) {
        self.formatter = formatter
        self.repository = repository
        self.purchaseItem = purchaseItem
    }
    
    // MARK: - Public Methods
    
    @MainActor
    func createOrderSummary() {
        viewState = .finished
    }
}
