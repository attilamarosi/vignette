// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct CountyVignetteView: View {
    
    @ObservedObject var viewModel: CountyVignetteViewModel
    
    var body: some View {
        AsyncContentView(viewModel: viewModel) {
            ScrollView {
                
                // Title
                HStack {
                    Text("vignette-one-year")
                        .font(.headingLarge)
                    Spacer()
                }
                .padding(.horizontal, .padding16)
                
                // Map
                
                // List of available county vignettes
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
                            Text("Fizetendő összeg")
                                .font(.headingSmall)
                            Spacer()
                        }
                        
                        HStack {
                            Text(viewModel.uiModel?.total ?? "0 Ft")
                                .font(.headingExtraLarge)
                            Spacer()
                        }
                    }
                    .padding(.horizontal, .padding16)
                    
                    CTAButton(style: .primary,
                              title: String(localized:"common_next")) {
                        
                    }
                }
                .padding(.horizontal, .padding16)
            }
            .background(.colorWhite)
        }
        .task {
            await viewModel.handleOnAppear()
        }
    }
}

// MARK: - Previews
#Preview {
    CountyVignetteViewAssembly.createView(vignettes: nil)
}
