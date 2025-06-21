// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI
import Combine

// MARK: - Async View States
enum ViewState {
    case idle
    case loading
    case finished
    case error(ErrorModel)

    // Unique Identifier required for animation purposes
    var id: Int {
        switch self {
        case .idle:
            return 0
        case .loading:
            return 1
        case .finished:
            return 2
        case .error(_):
            return 3
        }
    }
}

extension ViewState: Equatable {
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        lhs.id == rhs.id
    }
}

protocol AsyncViewModel: ObservableObject {
    var viewState: ViewState { get set }
    var showPopupSubject: PassthroughSubject<PopupModel, Never> { get set }
}

// MARK: - Async Content View
struct AsyncContentView<ViewModel: AsyncViewModel, Content: View>: View {
    
    @ObservedObject var viewModel: ViewModel
    var content: () -> Content
    
    // MARK: - Popup Handling
    
    @State private var showPopup: Bool = false
    @State private var popupModel: PopupModel?
    
    // Computed property to control when the fullScreenCover should be shown
    private var isPopupPresented: Binding<Bool> {
        Binding(get: { self.showPopup && self.popupModel != nil },
                set: { newValue in
            self.showPopup = newValue
            if !newValue {
                self.popupModel = nil
            }
        })
    }
    
    // MARK: - Initialization
    init(viewModel: ViewModel,
         @ViewBuilder content: @escaping () -> Content) {
        self.viewModel = viewModel
        self.content = content
    }
    
    var body: some View {
        ZStack {
            switch viewModel.viewState {
            case .idle:
                EmptyView()
            case .loading:
                YettelProgressView()
            case .finished:
                content()
            case .error(let model):
                ErrorView(model: model)
            }
            
            if showPopup, let popupModel {
                PopupView(dismiss: $showPopup,
                          model: popupModel)
            }
        }
        .animation(.easeInOut, value: viewModel.viewState)
        .transition(.asymmetric(insertion: .opacity, removal: .identity))
        // Popup Related
        .onReceive(viewModel.showPopupSubject, perform: { receivedPopupModel in
            // Reset before setting a new popup
            if showPopup {
                showPopup = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    popupModel = receivedPopupModel
                    showPopup = true
                }
            } else {
                popupModel = receivedPopupModel
                showPopup = true
            }
        })
    }
}
