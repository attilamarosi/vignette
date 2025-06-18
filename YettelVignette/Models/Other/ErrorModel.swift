// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

/// Represents the error for the ViewState
struct ErrorModel {
    var error: APIError
    var dismissAction: (() -> Void)?
}

