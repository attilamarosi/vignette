// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct YettelNavigationBarContainerView<Content: View>: View {
    
    @State private var title: String = ""
    @State private var isNavigationBarVisible: Bool = true

    let canGoBack: Bool
    let onBack: (() -> Void)?
    let content: Content

    init(canGoBack: Bool,
         onBack: (() -> Void)?,
         @ViewBuilder content: () -> Content) {
        self.canGoBack = canGoBack
        self.onBack = onBack
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                if isNavigationBarVisible {
                    YettelNavigationView(title: $title,
                                          topInset: geometry.safeAreaInsets.top,
                                          canGoBack: canGoBack,
                                          onBack: onBack)
                }
                
                // Content part
                content
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 0,
                           maxHeight: .infinity)
                    .onPreferenceChange(CustomNavigationTitleKey.self) { title = $0 }
                    .onPreferenceChange(NavigationBarVisibilityKey.self) {
                        isNavigationBarVisible = $0
                    }
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

// MARK: - Preview
#Preview {
    YettelNavigationBarContainerView(canGoBack: true,
                                     onBack: {}) {
        Text("Yettel")
    }
}
