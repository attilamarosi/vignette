// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct HighwayVignetteMainView: View {
    
    @ObservedObject var viewModel: HighwayVignetteMainViewModel
    
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
                                                       price: vignette.price)
                            }
                            
                        }
                    }.padding(.bottom, .padding8)
                    
                    // Purchase button
                    CTAButton(style: .primary,
                              title: String(localized:"purchase_title")) {
                        
                    }
                    
                }
                .padding(.padding16)
                .background(.colorWhite)
                .cornerRadius(.cornerRadius16)
                
            }
            .background(.colorGrey)
            .padding(.padding16)
        }
        .task {
            await viewModel.handleOnAppear()
        }
    }
}

// MARK: - Previews
#Preview {
    HighwayVignetteViewAssembly.createView()
}
