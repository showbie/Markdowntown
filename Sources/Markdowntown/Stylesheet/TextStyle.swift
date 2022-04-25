//
//  TextStyle.swift
//  
//
//  Created by Colin Humber on 2022-04-25.
//

import UIKit

struct TextStyle: MarkdownStyle {
    let textColor: UIColor
    let font: UIFont
    let backgroundColor: UIColor?
    
    init(textColor: UIColor = .black, font: UIFont, backgroundColor: UIColor? = nil) {
        self.textColor = textColor
        self.font = font
        self.backgroundColor = backgroundColor
    }
}

struct InsetTextStyle: MarkdownStyle {
    let textColor: UIColor
    let font: UIFont
    let backgroundColor: UIColor?
    let insets: UIEdgeInsets
        
    init(textColor: UIColor = .black, font: UIFont = .systemFont(ofSize: 17), backgroundColor: UIColor? = nil, insets: UIEdgeInsets = .zero) {
        self.textColor = textColor
        self.font = font
        self.backgroundColor = backgroundColor
        self.insets = insets
    }
}
