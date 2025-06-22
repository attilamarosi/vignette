// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct HighwayVignetteView: View {
    
    @StateObject var viewModel: HighwayVignetteViewModel
    
    var body: some View {
        AsyncContentView(viewModel: viewModel) {
            ScrollView {
                // Vehicle
                if let vehicle = viewModel.uiModel?.vehicle {
                    VehicleItemView(vehicle: vehicle)
                        .padding(.bottom, .padding8)
                }
                
                // Nation-wide highway vignettes
                VStack {
                    
                    // Section title
                    HStack {
                        Text("nation-wide-highway-vignettes")
                            .font(.headingLarge)
                        Spacer()
                    }
                        
                    // List of available vignettes
                    VStack {
                        if let uiModel = viewModel.uiModel {
                            ForEach(uiModel.highwayVignettes.indices, id: \.self) { index in
                                let vignette = uiModel.highwayVignettes[index]
                                let isSelected = Binding(
                                    get: { vignette.selected },
                                    set: { newValue in
                                        if newValue {
                                            viewModel.selectVignette(at: index)
                                        }
                                    })
                                
                                SelectableListItemView(selected: isSelected,
                                                       title: vignette.productName,
                                                       detailedName: vignette.detailedName,
                                                       price: vignette.price)
                            }
                            
                        }
                    }.padding(.bottom, .padding8)
                    
                    // Purchase button
                    CTAButton(style: .primary,
                              title: String(localized:"purchase_title")) {
                        viewModel.navigateToPaymentConfirmation()
                    }
                              .disabled(!viewModel.vignetteSelected)
                    
                }
                .padding(.padding16)
                .background(.colorWhite)
                .cornerRadius(.cornerRadius16)
                
                
                // Navigation link view
                VStack {
                    CTANavigationLinkView(title: String(localized: "vignette-one-year")) {
                        viewModel.navigateToCountyVignette()
                    }
                        
                }
                .padding(.top, .padding8)

            }
            .background(.colorGrey)
            .padding(.padding16)
        }
        .background(.colorGrey)
        // Handle on appear
        .task {
            await viewModel.handleOnAppear()
        }
    }
}

// MARK: - Previews
#Preview {
    HighwayVignettePreviewAssembly.makePreview()
        .environment(\.locale, .init(identifier: "hu_HU"))
}
