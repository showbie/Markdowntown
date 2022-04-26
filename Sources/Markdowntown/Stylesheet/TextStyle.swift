//
//  TextStyle.swift
//  
//
//  Created by Colin Humber on 2022-04-25.
//

import UIKit

public struct TextStyle: MarkdownStyle {
    public let textColor: UIColor
    public let font: UIFont
    public let backgroundColor: UIColor?
    
    public init(textColor: UIColor = .black, font: UIFont, backgroundColor: UIColor? = nil) {
        self.textColor = textColor
        self.font = font
        self.backgroundColor = backgroundColor
    }
}

public struct InsetTextStyle: MarkdownStyle {
    public let textColor: UIColor
    public let font: UIFont
    public let backgroundColor: UIColor?
    public let insets: UIEdgeInsets
        
    public init(textColor: UIColor = .black, font: UIFont = .systemFont(ofSize: 17), backgroundColor: UIColor? = nil, insets: UIEdgeInsets = .zero) {
        self.textColor = textColor
        self.font = font
        self.backgroundColor = backgroundColor
        self.insets = insets
    }
}
