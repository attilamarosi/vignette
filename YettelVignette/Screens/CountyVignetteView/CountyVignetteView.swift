// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct CountyVignetteView: View {
    
    @StateObject var viewModel: CountyVignetteViewModel
    
    var body: some View {
        AsyncContentView(viewModel: viewModel) {
            VStack {
                
                // Title
                HStack {
                    Text("vignette-one-year")
                        .font(.headingLarge)
                    Spacer()
                }
                .padding(.horizontal, .padding16)
                
                // Map
                CountryMapView(selectedIds: $viewModel.selectedIds)
                    .padding(.padding16)
                
                // List of available county vignettes
                ScrollView {
                    VStack {
                        if let uiModel = viewModel.uiModel {
                            ForEach(uiModel.counties.indices, id: \.self) { index in
                                let county = uiModel.counties[index]
                                let isSelected = Binding(
                                    get: { uiModel.counties[index].isSelected },
                                    set: { newValue in
                                        viewModel.selectVignette(at: index)
                                    }
                                )
                                
                                SelectableItemWithCheckboxView(isSelected: isSelected,
                                                               name: county.name,
                                                               price: county.formattedPrice)
                            }
                        }
                    }
                    .padding(.horizontal, .padding16)
                    .padding(.bottom, .padding8)
                    
                    // Sum
                    VStack {
                        HorizontalRulerView()
                        
                        Group {
                            HStack {
                                Text("amount_to_be_paid")
                                    .font(.headingSmall)
                                Spacer()
                            }
                            
                            HStack {
                                Text(viewModel.uiModel?.total ?? String(localized:"zero_huf"))
                                    .font(.headingExtraLarge)
                                Spacer()
                            }
                        }
                        .padding(.horizontal, .padding16)
                        
                        CTAButton(style: .primary,
                                  title: String(localized:"common_next")) {
                            viewModel.navigateToPaymentConfirmation()
                        }
                                  .disabled(viewModel.selectedIds.isEmpty)
                
                    }
                    .padding(.horizontal, .padding16)
                }
            }
            .background(.colorWhite)
            .padding(.top, .padding16)
        }
        .task {
            await viewModel.handleOnAppear()
        }
        .customNavigationTitle("e-vignette")
    }
}

// MARK: - Previews
#Preview {
    CountyVignettePreviewAssembly.makePreview()
}
