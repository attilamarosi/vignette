// Copyright © 2025 Attila Marosi. All rights reserved.

import Combine

class PaymentConfirmationViewModel: AsyncViewModel {
    
    // MARK: - Published Properties
    @Published var viewState: ViewState = .idle
    @Published var uiModel: HighwayVignetteUIModel?
    
    var showPopupSubject = PassthroughSubject<PopupModel, Never>()
    
    // MARK: - Private Properties
    private let formatter: PaymentConfirmationFormatter
    private let repository: GlobalRepository
    
    // MARK: - Initialization
    init(formatter: PaymentConfirmationFormatter,
         repository: GlobalRepository) {
        self.formatter = formatter
        self.repository = repository
    }
}
