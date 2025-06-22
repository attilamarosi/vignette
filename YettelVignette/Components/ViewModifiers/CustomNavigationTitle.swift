// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

extension View {
    func customNavigationTitle(_ title: String) -> some View {
        self.preference(key: CustomNavigationTitleKey.self,
                        value: title)
    }
}

// MARK: - Custom Preference key for navigation title
struct CustomNavigationTitleKey: PreferenceKey {
    static var defaultValue: String = ""
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}
