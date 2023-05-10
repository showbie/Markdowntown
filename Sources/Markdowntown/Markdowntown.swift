import Foundation
import Markdown
import UIKit

public struct Markdowntown {
    public init() { }
    
    // MARK: - Public Methods
    
    public func attributedString(from markdown: String, stylesheet: MarkdowntownStylesheet = .init()) -> NSAttributedString {
        attributedString(from: Document(parsing: markdown), stylesheet: stylesheet)
    }
    
    public func attributedString(from document: Document, stylesheet: MarkdowntownStylesheet = .init()) -> NSAttributedString {
        var markdowntown = _Markdowntown(stylesheet: stylesheet)
        return markdowntown.attributedString(from: document)
    }
    

    // MARK: - Markup Parser
    
    private struct _Markdowntown: MarkupVisitor {
        // MARK: Private Properties
        private let stylesheet: MarkdowntownStylesheet

        // MARK: - Lifecycle
        init(stylesheet: MarkdowntownStylesheet) {
            self.stylesheet = stylesheet
        }
        
        
        // MARK: - Public Methods
        mutating func attributedString(from markdown: String) -> NSAttributedString {
            attributedString(from: Document(parsing: markdown))
        }
        
        mutating func attributedString(from document: Document) -> NSAttributedString {
            visit(document)
        }
        
        
        // MARK: - MarkupVisitor
        mutating func defaultVisit(_ markup: Markup) -> NSAttributedString {
            joinedVisitedChildren(for: markup)
        }
        
        //    mutating func visitBlockQuote(_ blockQuote: BlockQuote) -> NSAttributedString {
        //
        //    }
        
        mutating func visitCodeBlock(_ codeBlock: CodeBlock) -> NSAttributedString {
            let result = NSMutableAttributedString(string: codeBlock.code)
            
            stylesheet.applyStyling(codeBlock: result)
            
            if codeBlock.hasSuccessor {
                result.append(NSMutableAttributedString(string: "\n\n"))
            }
            
            return result
        }
        
        mutating func visitThematicBreak(_ thematicBreak: ThematicBreak) -> NSAttributedString {
            let newLines = thematicBreak.hasSuccessor ? "\n\n" : ""
            
            let result = NSMutableAttributedString(string: "\u{00A0} \u{0009} \u{00A0}\(newLines)")
            
            stylesheet.applyStyling(thematicBreak: result)
            
            return result
        }
        
        mutating func visitHeading(_ heading: Heading) -> NSAttributedString {
            let result = joinedVisitedChildren(for: heading)
            
            stylesheet.applyStyling(heading: result, atLevel: heading.level)
            
            if heading.hasSuccessor {
                result.append(applyTextStyle("\n\n"))
            }
            
            return result
        }
        
        mutating func visitHTMLBlock(_ html: HTMLBlock) -> NSAttributedString {
            let result = NSMutableAttributedString()
            
            let data = Data(html.rawHTML.utf8)
            
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                result.append(attributedString)
            }
            
            return result
        }
        
        mutating func visitListItem(_ listItem: ListItem) -> NSAttributedString {
            let result = joinedVisitedChildren(for: listItem)
            
            if listItem.hasSuccessor {
                result.append(applyTextStyle("\n"))
            }
            
            return result
        }
        
        mutating func visitOrderedList(_ orderedList: OrderedList) -> NSAttributedString {
            let result = NSMutableAttributedString()
            
            let depth = orderedList.depth
            
            for (index, item) in orderedList.listItems.enumerated() {
                let number = NumberFormatter()
                let string = number.string(from: NSNumber(value: index + 1))!
                
                let tabs = Array(repeating: "\t", count: depth).joined()
                result.append(applyTextStyle("\(tabs)\(string). "))
                result.append(visit(item))
            }
            
            if orderedList.hasSuccessor {
                result.append(applyTextStyle("\n\n"))
            }
            
            return result
        }
        
        mutating func visitUnorderedList(_ unorderedList: UnorderedList) -> NSAttributedString {
            let result = NSMutableAttributedString()
            
            let depth = unorderedList.depth
            
            for item in unorderedList.listItems {
                let tabs = Array(repeating: "\t", count: depth).joined()
                result.append(applyTextStyle("\(tabs)• "))
                result.append(visit(item))
            }
            
            if unorderedList.hasSuccessor {
                result.append(applyTextStyle("\n\n"))
            }
            
            return result
        }
        
        mutating func visitParagraph(_ paragraph: Paragraph) -> NSAttributedString {
            let result = joinedVisitedChildren(for: paragraph)
            
            if paragraph.hasSuccessor {
                if paragraph.isInList {
                    result.append(applyTextStyle("\n"))
                }
                else {
                    result.append(applyTextStyle("\n\n"))
                }
            }
            
            stylesheet.applyStyling(paragraph: result)
            
            return result
        }
        
        mutating func visitInlineCode(_ inlineCode: InlineCode) -> NSAttributedString {
            let result = NSMutableAttributedString(string: inlineCode.code)
            
            stylesheet.applyStyling(inlineCode: result)
            
            return result
        }
        
        mutating func visitEmphasis(_ emphasis: Emphasis) -> NSAttributedString {
            let result = joinedVisitedChildren(for: emphasis)
            
            if emphasis.parent is Strong {
                stylesheet.applyStyling(strongEmphasis: result)
            }
            else if !(emphasis.child(at: 0) is Strong) {
                stylesheet.applyStyling(emphasis: result)
            }
            
            return result
        }
        
        //    mutating func visitImage(_ image: Image) -> NSAttributedString {
        //        let result = NSMutableAttributedString()
        //
        //        if let source = image.source {
        //            let imageData = try? Data(contentsOf: URL(string: source)!)
        //            let image = UIImage(data: imageData!)
        //            let imageAttachment = NSTextAttachment()
        //            imageAttachment.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        //            imageAttachment.image = image
        //
        //            result.append(NSAttributedString(attachment: imageAttachment))
        //        }
        //
        //        return result
        //    }
        
        mutating func visitLineBreak(_ lineBreak: LineBreak) -> NSAttributedString {
            applyTextStyle("\n\n")
        }
        
        mutating func visitLink(_ link: Link) -> NSAttributedString {
            let result = joinedVisitedChildren(for: link)
                        
            if let destination = link.destination, let url = URL(string: destination) {
                stylesheet.applyStyling(link: result)
                
                result.addAttribute(.link, value: url)
            }
            
            return result
        }
        
        mutating func visitSoftBreak(_ softBreak: SoftBreak) -> NSAttributedString {
            applyTextStyle("\n")
        }
        
        mutating func visitStrong(_ strong: Strong) -> NSAttributedString {
            let result = joinedVisitedChildren(for: strong)
            
            if strong.parent is Emphasis {
                stylesheet.applyStyling(strongEmphasis: result)
            }
            else if !(strong.child(at: 0) is Emphasis) {
                stylesheet.applyStyling(strong: result)
            }
            
            return result
        }
        
        mutating func visitText(_ text: Text) -> NSAttributedString {
            let string = NSMutableAttributedString(string: text.plainText)
            
            stylesheet.applyStyling(text: string)
            
            return string
        }
        
        mutating func visitStrikethrough(_ strikethrough: Strikethrough) -> NSAttributedString {
            let result = joinedVisitedChildren(for: strikethrough)
            
            result.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue)
            
            return result
        }
        
        private mutating func applyTextStyle(_ string: String) -> NSAttributedString {
            visitText(Text(string))
        }
    }
}

extension MarkupVisitor where Result == NSAttributedString {
    /// Visits all children of the provided markup node and joins all results into an
    /// `NSMutableAttributedString`.
    /// - Parameter markup: The `Markup` node to visit.
    /// - Returns: An `NSMutableAttributedString` containing the results of all visited
    /// children.
    mutating func joinedVisitedChildren(for markup: Markup) -> NSMutableAttributedString {
        markup.children
            .map { visit($0) }
            .reduce(into: NSMutableAttributedString()) {
                $0.append($1)
            }
    }
}
