// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct SelectableItemWithCheckboxView: View {
    
    @Binding var isSelected: Bool
    var name: String
    var price: String
    
    var body: some View {
        Button {
            isSelected.toggle()
        } label: {
            HStack {
                YettelCheckbox(selected: $isSelected)
                    .padding(.trailing, .padding16)
                Text(name)
                    .font(.paragraphMain)
                    .foregroundStyle(isSelected ? .colorDarkerGrey : .colorNavy)
                Spacer()
                Text(price)
                    .font(.headingMain)
                    .foregroundStyle(.colorNavy)
            }
            .padding(.horizontal, .padding16)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Previews
#Preview {
    SelectableItemWithCheckboxViewWrapper()
}

private struct SelectableItemWithCheckboxViewWrapper: View {
    
    @State private var isSelected: Bool = false
    
    var body: some View {
        SelectableItemWithCheckboxView(isSelected: $isSelected,
                                       name: "Pest vármegye",
                                       price: "6 400 Ft")
    }
    
}
