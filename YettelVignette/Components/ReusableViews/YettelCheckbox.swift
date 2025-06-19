// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct YettelCheckbox: View {
    
    @Binding var selected: Bool
    
    var body: some View {
        Button {
            withAnimation(.easeInOut) {
                selected.toggle()
            }
        } label: {
            ZStack {
                // Background
                RoundedRectangle(cornerRadius: .cornerRadius4)
                    .stroke(selected ? Color.clear : Color.colorGrey, lineWidth: 1)
                    .background(
                        (selected ? Color.colorGrey : Color.colorWhite)
                            .cornerRadius(.cornerRadius4)
                    )
                    .frame(width: .width20, height: .height20)
                
                
                // Checkmark image
                Image("icon-check-thick")
                    .opacity(selected ? 1 : 0)
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Previews
#Preview {
    YettelCheckboxWrapper()
}

private struct YettelCheckboxWrapper: View {
    
    @State private var selected: Bool = false
    
    var body: some View {
        YettelCheckbox(selected: $selected)
    }
}
