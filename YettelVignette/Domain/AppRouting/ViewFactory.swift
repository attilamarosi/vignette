// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

typealias Routable = ViewFactory & Hashable

protocol ViewFactory {
    func makeView() -> AnyView
}
