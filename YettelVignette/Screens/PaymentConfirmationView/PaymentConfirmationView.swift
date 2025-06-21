// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct PaymentConfirmationView: View {
    
    @ObservedObject var viewModel: PaymentConfirmationViewModel
    
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
                            Text("Matrica típusa")
                            Spacer()
                            Text("Éves vármegyei")
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
                                VignetteOrderItemView(name: item.name, price: item.price)
                            }
                            
                            HStack {
                                Text("usage_fee")
                                    .font(.paragraphSmall)
                                Spacer()
                                Text(uiModel.fee)
                                    .font(.paragraphSmall)
                            }
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
                                Text("0 Ft")
                                    .font(.headingExtraLarge)
                                Spacer()
                            }
                        }
                        .padding(.horizontal, .padding16)
                        
                        // Pay button
                        CTAButton(style: .primary,
                                  title: String(localized:"common_next")) {
                            
                        }
                        
                        // Cancel button
                        CTAButton(style: .secondary,
                                  title: String(localized:"common_cancel")) {
                            
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

// MARK: - Previews
#Preview {
    PaymentConfirmationViewAssembly.createView(purchaseItem: Mocks.purchaseItem)
}
