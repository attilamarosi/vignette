// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

public enum FontSize: CGFloat {
    case extraSmall    = 12     // 12 -> Captions, footnotes
    case small         = 14     // 14 -> Secondary text, labels
    case medium        = 16     // 16 -> Body text (default for readability)
    case large         = 18     // 18 -> Emphasized body text
    case title         = 20     // 20 -> Titles or section headers
    case headline      = 24     // 24 -> Main headlines
    case displaySmall  = 28     // 28 -> Small display text
    case displayMedium = 34     // 34 -> Medium display text
    case displayLarge  = 40     // 40 -> Large display text (hero titles)
}

public enum FontType: String {
    case oswaldBold         = "Oswald-Bold"
    case oswaldExtraLight   = "Oswald-ExtraLight"
    case oswaldLight        = "Oswald-Light"
    case oswaldMedium       = "Oswald-Medium"
    case oswaldRegular      = "Oswald-Regular"
    case oswaldSemiBold     = "Oswald-SemiBold"
}

// MARK: - View Modifier for using a custom Font
public struct YettelFontModifier: ViewModifier {
    var size: FontSize
    var type: FontType
    
    public func body(content: Content) -> some View {
        content
            .font(.yettelFont(size: size,
                              type: type))
    }
}

// MARK: - Font Extension for using a custom Font
public extension Font {
    
    // Use this for defining custom size and type
    static func yettelFont(size: FontSize,
                           type: FontType = .oswaldMedium) -> Font {
        Font.custom(type.rawValue,
                    size: size.rawValue)
    }
    
    /*
     -- Paragraphs --
     */
    
    static var paragraphMain: Font {
        yettelFont(size: .medium,
                   type: .oswaldMedium)
    }
    
    /*
     -- Headings --
     */
    
    static var headingMain: Font {
        yettelFont(size: .medium,
                   type: .oswaldBold)
    }
    
    static var headingExtraLarge: Font {
        yettelFont(size: .displayLarge,
                   type: .oswaldSemiBold)
    }
}
