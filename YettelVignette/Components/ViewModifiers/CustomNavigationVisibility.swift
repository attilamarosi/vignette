// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

extension View {
    func showNavigationBar(_ isVisible: Bool) -> some View {
        preference(key: NavigationBarVisibilityKey.self,
                   value: isVisible)
    }
}

struct NavigationBarVisibilityKey: PreferenceKey {
    static var defaultValue: Bool = true
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}
