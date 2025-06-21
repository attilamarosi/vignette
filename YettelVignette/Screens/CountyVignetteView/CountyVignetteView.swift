// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct CountyVignetteView: View {
    
    @StateObject var viewModel: CountyVignetteViewModel
    @State private var navigateToPaymentConfirmation = false
    
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
                            navigateToPaymentConfirmation = true
                        }
                                  .disabled(viewModel.selectedIds.isEmpty)
                
                    }
                    .padding(.horizontal, .padding16)
                }
            }
            .background(.colorWhite)
        }
        .task {
            await viewModel.handleOnAppear()
        }
        .navigationDestination(isPresented: $navigateToPaymentConfirmation) {
            if let purchaseItem = viewModel.purchaseItem {
                PaymentConfirmationViewAssembly.createView(purchaseItem: purchaseItem)
            }
        }
    }
}

// MARK: - Previews
#Preview {
    CountyVignetteViewAssembly.createView(vignetteResponse: nil,
                                          vehicle: Mocks.vehicle)
}
