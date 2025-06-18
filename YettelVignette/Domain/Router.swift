// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

public enum Routes: Hashable {
    case order
}

class Router: ObservableObject {
    
    @Published var navigationPath = NavigationPath()
    
    func push(to route: Routes) {
        navigationPath.append(route)
    }
    
    func navigateBack() {
        guard navigationPath.count > 1 else { return }
        navigationPath.removeLast()
    }
    
    func popToRoot() {
        navigationPath = NavigationPath()
    }
    
}
