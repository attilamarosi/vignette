// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct PaymentConfirmationView: View {
    
    @StateObject var viewModel: PaymentConfirmationViewModel
    
    var body: some View {
        AsyncContentView(viewModel: viewModel) {
            ScrollView {
                VStack {
                    
                    // Screen title
                    HStack {
                        Text("payment_confirmation_title")
                            .font(.headingLarge)
                        Spacer()
                    }
                    .padding(.horizontal, .padding16)
                    
                    HorizontalRulerView()
                    
                    // Vehicle data
                    Group {
                        HStack {
                            Text("platenumber")
                            
                            Spacer()
                            
                            if let uiModel = viewModel.uiModel {
                                Text(uiModel.platenumber)
                            }
                        }
                        
                        Spacer(minLength: .padding8)
                        
                        HStack {
                            Text("vignette_type")
                            Spacer()
                            // For example "Éves vármegyei"
                            if let vignetteCategory = viewModel.uiModel?.vignetteCategory {
                                Text(LocalizedStringKey(vignetteCategory))
                            }
                        }
                    }
                    .padding(.horizontal, .padding16)
                    .font(.paragraphSmallLight)
                    .foregroundStyle(.colorNavy)
                    
                    HorizontalRulerView()
                    
                    // Items
                    VStack {
                        if let uiModel = viewModel.uiModel {
                            ForEach(uiModel.orderItems, id: \.name) { item in
                                VignetteOrderItemView(name: item.name,
                                                      price: item.price)
                            }
                            .padding(.horizontal, .padding16)
                            
                            // Fee
                            HStack {
                                Text("usage_fee")
                                    .font(.paragraphSmall)
                                Spacer()
                                Text(uiModel.fee)
                                    .font(.paragraphSmall)
                            }
                            .padding(.horizontal, .padding16)
                        }
                    }
                    
                    HorizontalRulerView()
                    
                    // Summary
                    VStack(spacing: .padding16) {
                        Group {
                            HStack {
                                Text("amount_to_be_paid")
                                    .font(.headingSmall)
                                Spacer()
                            }
                            
                            HStack {
                                if let summary = viewModel.uiModel?.summary {
                                    Text(summary)
                                        .font(.headingExtraLarge)
                                }
                                Spacer()
                            }
                        }
                        .padding(.horizontal, .padding16)
                        
                        // Pay button
                        CTAButton(style: .primary,
                                  title: String(localized:"common_next")) {
                            Task {
                                await viewModel.processPayment()
                            }
                        }
                        
                        // Cancel button
                        CTAButton(style: .secondary,
                                  title: String(localized:"common_cancel")) {
                            viewModel.navigateBack()
                        }
                    }
                    .padding(.horizontal, .padding16)
                }
            }
        }
        .background(.colorWhite)
        .task {
            viewModel.createOrderSummary()
        }
    }
}
