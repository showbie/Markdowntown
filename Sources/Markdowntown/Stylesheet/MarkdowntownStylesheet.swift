//
//  MarkdowntownStylesheet.swift
//
//
//  Created by Colin Humber on 2022-04-25.
//

import UIKit

public struct MarkdowntownStylesheet {
    public let paragraphStyle: NSParagraphStyle
    public let textStyle: TextStyle
    public let emphasisStyle: TextStyle
    public let strongStyle: TextStyle
    public let strongEmphasisStyle: TextStyle
    public let strikethroughStyle: TextStyle
    public let codeStyle: InsetTextStyle
    public let heading1Style: TextStyle
    public let heading2Style: TextStyle
    public let heading3Style: TextStyle
    public let heading4Style: TextStyle
    public let heading5Style: TextStyle
    public let heading6Style: TextStyle
    public let linkStyle: TextStyle

    public init(paragraphStyle: NSParagraphStyle = .markdownDefault,
                textStyle: TextStyle = .init(font: .systemFont(ofSize: 17)),
                emphasisStyle: TextStyle = .init(font: .italicSystemFont(ofSize: 17)),
                strongStyle: TextStyle = .init(font: .boldSystemFont(ofSize: 17)),
                strongEmphasisStyle: TextStyle = .init(font: .systemFont(ofSize: 17).bold.italic),
                strikethroughStyle: TextStyle = .init(font: .systemFont(ofSize: 17)),
                codeStyle: InsetTextStyle = .init(font: .monospacedSystemFont(ofSize: 16, weight: .regular), backgroundColor: .lightGray),
                heading1Style: TextStyle = .init(font: .boldSystemFont(ofSize: 28)),
                heading2Style: TextStyle = .init(font: .boldSystemFont(ofSize: 26)),
                heading3Style: TextStyle = .init(font: .boldSystemFont(ofSize: 24)),
                heading4Style: TextStyle = .init(font: .boldSystemFont(ofSize: 24)),
                heading5Style: TextStyle = .init(font: .boldSystemFont(ofSize: 20)),
                heading6Style: TextStyle = .init(font: .boldSystemFont(ofSize: 20)),
                linkStyle: TextStyle = .init(textColor: .systemBlue, font: .systemFont(ofSize: 17))
    ) {
        self.textStyle = textStyle
        self.paragraphStyle = paragraphStyle
        self.emphasisStyle = emphasisStyle
        self.strongStyle = strongStyle
        self.strongEmphasisStyle = strongEmphasisStyle
        self.strikethroughStyle = strikethroughStyle
        self.codeStyle = codeStyle
        self.heading1Style = heading1Style
        self.heading2Style = heading2Style
        self.heading3Style = heading3Style
        self.heading4Style = heading4Style
        self.heading5Style = heading5Style
        self.heading6Style = heading6Style
        self.linkStyle = linkStyle
    }
    
    func applyStyling(to string: NSMutableAttributedString, withStyle style: MarkdownStyle) {
        string.setAttributes([.foregroundColor: style.textColor,
                              .font: style.font])
        
        if let bgColor = style.backgroundColor {
            string.addAttribute(.backgroundColor, value: bgColor)
        }
    }
    
    func applyStyling(text: NSMutableAttributedString) {
        applyStyling(to: text, withStyle: textStyle)
    }
    
    func applyStyling(emphasis: NSMutableAttributedString) {
        applyStyling(to: emphasis, withStyle: emphasisStyle)
    }

    func applyStyling(strong: NSMutableAttributedString) {
        applyStyling(to: strong, withStyle: strongStyle)
    }

    func applyStyling(strongEmphasis: NSMutableAttributedString) {
        applyStyling(to: strongEmphasis, withStyle: strongEmphasisStyle)
    }

    func applyStyling(paragraph: NSMutableAttributedString) {
        paragraph.addAttribute(.paragraphStyle, value: paragraphStyle)
    }
    
    func applyStyling(inlineCode: NSMutableAttributedString) {
        applyStyling(to: inlineCode, withStyle: codeStyle)
    }
    
    func applyStyling(codeBlock: NSMutableAttributedString) {
        applyStyling(to: codeBlock, withStyle: codeStyle)

        // inset
    }
    
    func applyStyling(link: NSMutableAttributedString) {
        applyStyling(to: link, withStyle: linkStyle)
    }
    
    func applyStyling(heading: NSMutableAttributedString, atLevel level: Int) {
        var style: TextStyle
        
        switch level {
        case 1: style = heading1Style
        case 2: style = heading2Style
        case 3: style = heading3Style
        case 4: style = heading4Style
        case 5: style = heading5Style
        case 6: style = heading6Style
        default: style = heading1Style
        }
        
        var headingFont = style.font
        
        heading.enumerateAttribute(.font, in: NSRange(location: 0, length: heading.string.count)) { value, _, _ in
            guard let currentFont = value as? UIFont else { return }
        
            if currentFont.isBold {
                headingFont = headingFont.bold
            }
            
            if currentFont.isItalic {
                headingFont = headingFont.italic
            }
        }
        
        heading.setAttributes([.foregroundColor: style.textColor,
                               .font: headingFont])
        
        if let bgColor = style.backgroundColor {
            heading.addAttribute(.backgroundColor, value: bgColor)
        }
    }
}


public extension MarkdowntownStylesheet {
    static var `default` = MarkdowntownStylesheet()
//    static var `default` = MarkdownStylesheet(textFont: UIFont(name: "Avenir-Roman", size: 17)!,
//                                              textColor: .black,
//                                              emphasisFont: UIFont(name: "Avenir-Oblique", size: 17)!,
//                                              emphasisColor: .blue,
//                                              boldFont: UIFont(name: "Avenir-Heavy", size: 17)!,
//                                              boldColor: .red)
}
