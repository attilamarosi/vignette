// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

enum PopupStyle {
    case informal
    case warning
    case error
}

struct PopupModel {
    var style: PopupStyle
    var title: LocalizedStringResource
    var description: LocalizedStringResource?
    var customMessage: String?
    var buttons: [CTAButton]
}

