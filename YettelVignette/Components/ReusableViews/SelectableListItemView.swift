// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct SelectableListItemView: View {
    
    @Binding var selected: Bool
    var title: String
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
                            YettelRadioButton(selected: $selected)
                            Spacer()
                            Text(title)
                                .fontWeight(.bold)
                            Spacer()
                            Text(price)
                                .fontWeight(.bold)
                        }
                        .padding(.horizontal, .padding16)
                            
                    }
                    .padding(.horizontal, .padding16)
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
                               title: "D1 - heti (10 napos)",
                               price: "6 400 Ft")
    }
    
}
