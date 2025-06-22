// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

protocol NavigationCoordinator {
    func push(_ path: any Routable)
    func popLast()
    func popToRoot()
}
