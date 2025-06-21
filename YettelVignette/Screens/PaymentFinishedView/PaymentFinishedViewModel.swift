// Copyright © 2025 Attila Marosi. All rights reserved.

import Combine

class PaymentFinishedViewModel: AsyncViewModel {
    
    // MARK: - Published Properties
    @Published var viewState: ViewState = .idle
    
    var showPopupSubject = PassthroughSubject<PopupModel, Never>()
    
    // MARK: - Public Methods
    @MainActor
    func handleOnAppear() {
        // As there's no any special api call, formatting, etc needed, we simple change the state of the view
        viewState = .finished
    }
}
