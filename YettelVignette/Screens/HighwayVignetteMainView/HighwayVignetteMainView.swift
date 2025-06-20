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
                }
                
                // Nation-wide highway vignettes
                VStack {
                    HStack {
                        Text("nation-wide-highway-vignettes")
                            .font(.headingLarge)
                        Spacer()
                    }
                        
                    if let uiModel = viewModel.uiModel {
                        ForEach(uiModel.highwayVignettes, id: \.id) { vignette in
                            SelectableListItemView(selected: .constant(false),
                                                   title: vignette.productName,
                                                   price: vignette.price)
                        }
                    }
                    
                }
                .padding(.padding16)
                .background(.colorWhite)
                .cornerRadius(.cornerRadius8)
                
                
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
