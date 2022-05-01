//
//  ThematicBreakStyle.swift
//  
//
//  Created by Colin Humber on 2022-05-01.
//

import UIKit

public struct ThematicBreakStyle {
    public enum Thickness {
        case thin
        case thick
        case double
        
        internal var underlineStyle: NSUnderlineStyle {
            switch self {
            case .thin: return .single
            case .thick: return .thick
            case .double: return .double
            }
        }
    }
    
    public let thickness: Thickness
    public let color: UIColor
    
    public init(thickness: Thickness, color: UIColor) {
        self.thickness = thickness
        self.color = color
    }
}
