// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct SelectableListItemView: View {
    
    @Binding var selected: Bool
    var title: String
    var detailedName: String
    var price: String
    
    var body: some View {
        
        Button {
            withAnimation(.easeInOut(duration: 0.3)) {
                selected.toggle()
            }
        } label: {
            VStack {
                RoundedRectangle(cornerRadius: .cornerRadius8)
                    .fill(Color.colorWhite)
                    .frame(height: .height76)
                    .overlay(
                        RoundedRectangle(cornerRadius: .cornerRadius8)
                            .stroke(selected ? .colorNavy : .colorGrey,
                                    lineWidth: .width2)
                    )
                    .overlay {
                        HStack {
                            // Radio button
                            YettelRadioButton(selected: $selected)
                                .padding(.trailing, .padding16)
                            
                            // Product name
                            Group {
                                Text(title)
                                Text(" - ")
                                Text(LocalizedStringKey(detailedName))
                            }
                            .font(.paragraphMain)
                            
                            Spacer()
                            
                            // Product price
                            Text(price)
                                .font(.headingMain)
                        }
                        .padding(.horizontal, .padding16)
                    }
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Previews
#Preview {
    SelectableListItemViewWrapper()
}

private struct SelectableListItemViewWrapper: View {
    
    @State private var selected = false
    
    var body: some View {
        SelectableListItemView(selected: $selected,
                               title: "D1",
                               detailedName: "heti (10 napos)",
                               price: "6 400 Ft")
    }
    
}
