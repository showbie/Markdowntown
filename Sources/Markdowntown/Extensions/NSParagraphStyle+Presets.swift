//
//  NSParagraphStyle+Presets.swift
//  
//
//  Created by Colin Humber on 2022-04-25.
//

import UIKit

public extension NSParagraphStyle {
    static let markdownDefault: NSParagraphStyle = {
        let style = NSMutableParagraphStyle()
        style.paragraphSpacingBefore = 0
        style.paragraphSpacing = 0
        style.lineSpacing = 0
        style.lineBreakMode = .byWordWrapping
        
        return style
    }()
}

