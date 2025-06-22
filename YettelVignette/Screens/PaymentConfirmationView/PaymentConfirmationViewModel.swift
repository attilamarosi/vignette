// Copyright © 2025 Attila Marosi. All rights reserved.

import Combine

struct PaymentConfirmationUIModel {
    let orderItems: [VignetteOrderItemUIModel]
    let fee: String
    let productName: String?
    let platenumber: String
    let summary: String
    let vignetteCategory: String?
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
    private let router: PaymentConfirmationRouter
    
    private let purchaseItem: VignettePurchaseItem
    
    // MARK: - Initialization
    init(formatter: PaymentConfirmationFormatter,
         repository: GlobalRepository,
         router: PaymentConfirmationRouter,
         purchaseItem: VignettePurchaseItem) {
        self.formatter = formatter
        self.repository = repository
        self.router = router
        self.purchaseItem = purchaseItem
    }
    
    // MARK: - Public Methods
    
    @MainActor
    func createOrderSummary() {
        viewState = .loading
        uiModel = formatter.createUIModel(from: purchaseItem)
        viewState = .finished
    }
    
    @MainActor
    func processPayment() async {
        viewState = .loading
        
        do {
            
            let request = HighwayOrderRequest(highwayOrders: purchaseItem.vignette)
            let response = try await repository.makeOrder(request)
            viewState = .finished
            
            // Basic validation only for demonstration purposes
            if let statusCode = response.statusCode, statusCode.lowercased() == "ok" {
                router.navigateToPaymentFinished()
            } else {
                // Handle errors
            }
            
        } catch {
            guard let error = error as? APIError else {
                return
            }
            
            let errorModel = ErrorModel(error: error) {
                Task {
                    // weak self not needed, because it's not applicable in Task
                    await self.processPayment()
                }
            }
            
            viewState = .error(errorModel)
        }
    }
    
    // MARK: - Routing
    func navigateBack() {
        router.navigateBack()
    }
}
