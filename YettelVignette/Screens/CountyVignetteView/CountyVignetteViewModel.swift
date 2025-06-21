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
    
    var showPopupSubject = PassthroughSubject<PopupModel, Never>()
    
    // MARK: - Private Properties
    private let formatter: CountyVignetteFormatter
    
    private var vignettes: VignetteResponse?
    
    // MARK: - Initialization
    init(formatter: CountyVignetteFormatter,
        vignettes: VignetteResponse?) {
        self.formatter = formatter
        self.vignettes = vignettes
    }
    
    // MARK: - Public Methods
    
    @MainActor
    func handleOnAppear() async {
        viewState = .loading
        
        uiModel = formatter.createUIModel(from: vignettes)
        
        viewState = .finished
    }
    
    func selectVignette(at index: Int) {
        guard var vignettes = uiModel?.counties else { return }
        vignettes[index].isSelected.toggle()
        uiModel?.counties = vignettes
        updateSelectedIds(at: index)
        updateSum()
    }
    
    private func updateSelectedIds(at index: Int) {
        guard var vignettes = uiModel?.counties else { return }
        
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
}
