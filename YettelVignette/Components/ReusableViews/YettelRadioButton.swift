// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

/// Radio button with an initial state
/// - selected: Bool
/// The value of the current state
struct YettelRadioButton: View {
    
    @Binding var selected: Bool
    
    var body: some View {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    selected.toggle()
                }
            }) {
                ZStack {
                    Circle()
                        .frame(width: .width28)
                        .foregroundStyle(.colorWhite)
                        .overlay(
                            Circle()
                                .stroke(.colorGrey,
                                        lineWidth: .width2)
                        )
                    
                    if selected {
                        Circle()
                            .frame(width: .width16)
                            .foregroundStyle(.colorNavy)
                            .transition(.scale)
                    }
                }
            }
            .buttonStyle(.plain)
            .accessibilityLabel(TestAutomationIDs.General.radioButton)
            .accessibilityValue(selected ? String(localized: "radio_buton_selected") : String(localized: "radio_buton_not_selected"))
        }
}

// MARK: - Previews
#Preview {
    RadioButtonPreviewWrapper()
}

private struct RadioButtonPreviewWrapper: View {
    @State private var isSelected = false
    
    var body: some View {
        YettelRadioButton(selected: $isSelected)
    }
}
