// Copyright © 2025 Attila Marosi. All rights reserved.

import Combine

class RootViewModel: AsyncViewModel {
    
    // MARK: - Published Properties
    @Published var viewState: ViewState = .idle
    
    var showPopupSubject = PassthroughSubject<PopupModel, Never>()
    
    // MARK: - Public Methods
    func handleOnAppear() {
        viewState = .finished
    }
    
}
