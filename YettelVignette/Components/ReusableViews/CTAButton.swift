// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI


/// An enumeration that defines the visual style of a CTA (Call To Action) button
enum CTAButtonStyle {
    case primary
    case secondary
}

extension CTAButtonStyle {
    
    /// Returns the text color associated with the button style.
    var textColor: Color {
        switch self {
        case .primary:
            .colorWhite
        case .secondary:
            .colorNavy
        }
    }
    
    /// Returns the background color for the button.
    var backgroundColor: Color {
        switch self {
        case .primary:
            .colorNavy
        case .secondary:
            .colorWhite
        }
    }
    
    /// Returns the border color for the button.
    var borderColor: Color {
        switch self {
        case .primary:
            .clear
        case .secondary:
            .colorNavy
        }
    }
}

/// A customizable SwiftUI button component used for call-to-action interactions, styled according to the provided CTAButtonStyle.
/// - style: CTAButtonStyle
/// Determines the visual style of the button (colors and border).
/// - title: String
/// The label text displayed on the button.
/// - action: (() -> Void)
/// A closure that is executed when the button is tapped.
struct CTAButton: View {
    
    var style: CTAButtonStyle
    var title: String
    var action: (() -> Void)
    
    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: .cornerRadius24)
                .fill(style.backgroundColor)
                .frame(height: .buttonHeight)
                .overlay(
                    RoundedRectangle(cornerRadius: .cornerRadius24)
                        .stroke(style.borderColor,
                                lineWidth: .width2)
                )
                .overlay {
                    Text(title)
                        .font(.paragraphMain)
                        .foregroundStyle(style.textColor)
                        
                }
                .padding(.horizontal, .padding16)
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier(TestAutomationIDs.General.ctaButton)
        .accessibilityLabel(title)
    }
}

// MARK: - Previews
#Preview {
    Group {
        CTAButton(style: .primary,
                  title: String(localized: "common_next"),
                  action: {})
        
        CTAButton(style: .secondary,
                  title: String(localized: "common_cancel"),
                  action: {})
    }
    .padding(.vertical, .padding16)
}
