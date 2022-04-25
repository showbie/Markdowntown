//
//  UIFont+Traits.swift
//  
//
//  Created by Colin Humber on 2022-04-25.
//

import UIKit

public extension UIFont {
    var bold: UIFont { with(.traitBold) }
    var italic: UIFont { with(.traitItalic) }
//    var boldItalic: UIFont { with(.traitBold, .traitItalic) }
    
    var isBold: Bool { fontDescriptor.symbolicTraits.contains(.traitBold) }
    var isItalic: Bool { fontDescriptor.symbolicTraits.contains(.traitItalic) }

    func with(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        guard let descriptor = fontDescriptor.withSymbolicTraits(fontDescriptor.symbolicTraits.union(UIFontDescriptor.SymbolicTraits(traits))) else { return self }
        
        return UIFont(descriptor: descriptor, size: 0)
    }
}
