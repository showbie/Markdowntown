import Foundation
import Markdown
import UIKit

public struct Markdowntown {
    // MARK: - Initializer
    public init() { }
    
    // MARK: - Public Methods
    public func attributedString(from markdown: String, stylesheet: MarkdowntownStylesheet = .init(), configuration: MarkdowntownConfiguration = .default) -> NSAttributedString {
        attributedString(from: Document(parsing: markdown), stylesheet: stylesheet, configuration: configuration)
    }
    
    public func attributedString(from document: Document, stylesheet: MarkdowntownStylesheet = .init(), configuration: MarkdowntownConfiguration = .default) -> NSAttributedString {
        var markdowntown = _Markdowntown(stylesheet: stylesheet, configuration: configuration)
        return markdowntown.attributedString(from: document)
    }
    
    // MARK: - Markup Parser
    private struct _Markdowntown: MarkupVisitor {
        // MARK: Private Properties
        private let configuration: MarkdowntownConfiguration
        private let stylesheet: MarkdowntownStylesheet

        // MARK: - Lifecycle
        init(stylesheet: MarkdowntownStylesheet, configuration: MarkdowntownConfiguration) {
            self.stylesheet = stylesheet
            self.configuration = configuration
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
        
        mutating func visitCodeBlock(_ codeBlock: CodeBlock) -> NSAttributedString {
            let result: NSMutableAttributedString
            
            if configuration.useCodeBlock {
                result = NSMutableAttributedString(string: codeBlock.code)

                if codeBlock.hasSuccessor {
                    result.append(NSAttributedString(string: "\n\n"))
                }

                stylesheet.applyStyling(codeBlock: result)
            }
            else {
                result = NSMutableAttributedString(string: codeBlock.format())

                if codeBlock.hasSuccessor {
                    result.append(NSAttributedString(string: "\n\n"))
                }
                
                stylesheet.applyStyling(text: result)
            }

            return result
        }
        
        mutating func visitThematicBreak(_ thematicBreak: ThematicBreak) -> NSAttributedString {
            let result: NSMutableAttributedString
            
            if configuration.useThematicBreak {
                result = NSMutableAttributedString(string: "\u{00A0} \u{0009} \u{00A0}")
                
                if thematicBreak.hasSuccessor {
                    result.append(NSAttributedString(string: "\n"))
                }

                stylesheet.applyStyling(thematicBreak: result)
            }
            else {
                result = NSMutableAttributedString(string: thematicBreak.format())
                
                if thematicBreak.hasSuccessor {
                    result.append(NSAttributedString(string: "\n"))
                }

                stylesheet.applyStyling(text: result)
            }
            
            return result
        }
        
        mutating func visitHeading(_ heading: Heading) -> NSAttributedString {
            let result: NSMutableAttributedString
            
            if (heading.level == 1 && configuration.useHeading1) ||
               (heading.level == 2 && configuration.useHeading2) ||
               (heading.level == 3 && configuration.useHeading3) ||
               (heading.level == 4 && configuration.useHeading4) ||
               (heading.level == 5 && configuration.useHeading5) ||
               (heading.level == 6 && configuration.useHeading6) {
                result = NSMutableAttributedString(string: heading.plainText)
                
                if heading.hasSuccessor {
                    result.append(NSAttributedString(string: "\n"))
                }
                
                stylesheet.applyStyling(heading: result, atLevel: heading.level)
            }
            else {
                result = NSMutableAttributedString(string: heading.format())
                
                if heading.hasSuccessor {
                    result.append(NSAttributedString(string: "\n"))
                }
                
                stylesheet.applyStyling(text: result)
            }
            

            
            return result
        }
        
        mutating func visitHTMLBlock(_ html: HTMLBlock) -> NSAttributedString {
            guard configuration.useHTMLBlock else { return applyTextStyle(html.rawHTML) }
            
            let result = NSMutableAttributedString()
            
            let data = Data(html.rawHTML.utf8)
            
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                result.append(attributedString)
            }
            
            return result
        }
        
        mutating func visitListItem(_ listItem: ListItem) -> NSAttributedString {
            let result = NSMutableAttributedString()
            
            if configuration.useOrderedList || configuration.useUnorderedList {
                result.append(joinedVisitedChildren(for: listItem))
            }
            else {
                result.append(applyTextStyle(listItem.format()))
            }
            
            if listItem.hasSuccessor {
                result.append(applyTextStyle("\n"))
            }
            
            return result
        }
        
        mutating func visitOrderedList(_ orderedList: OrderedList) -> NSAttributedString {
            let result = NSMutableAttributedString()

            if configuration.useOrderedList {
                let depth = orderedList.depth
                
                for (index, item) in orderedList.listItems.enumerated() {
                    let number = NumberFormatter()
                    let string = number.string(from: NSNumber(value: index + 1))!
                    
                    let tabs = Array(repeating: "\t", count: depth).joined()
                    result.append(applyTextStyle("\(tabs)\(string). "))
                    result.append(visit(item))
                }
            }
            else {
                result.append(applyTextStyle(orderedList.format()))
            }

            if orderedList.hasSuccessor {
                result.append(applyTextStyle("\n\n"))
            }
            
            return result
        }
        
        mutating func visitUnorderedList(_ unorderedList: UnorderedList) -> NSAttributedString {
            let result = NSMutableAttributedString()
            
            if configuration.useUnorderedList {
                let depth = unorderedList.depth
                
                for item in unorderedList.listItems {
                    let tabs = Array(repeating: "\t", count: depth).joined()
                    result.append(applyTextStyle("\(tabs)• "))
                    result.append(visit(item))
                }
            }
            else {
                result.append(applyTextStyle(unorderedList.format()))
            }
            
            if unorderedList.hasSuccessor {
                result.append(applyTextStyle("\n\n"))
            }
            
            return result
        }
        
        mutating func visitParagraph(_ paragraph: Paragraph) -> NSAttributedString {
            let result: NSMutableAttributedString // = joinedVisitedChildren(for: paragraph)
//            let result = joinedVisitedChildren(for: paragraph)
            
            if paragraph.hasSuccessor {
                if paragraph.isInList {
                    result = NSMutableAttributedString(string: "\n")
                }
                else {
                    result = NSMutableAttributedString(string: "\n\n")
                }
            }
            else {
                result = NSMutableAttributedString()
            }
            
            stylesheet.applyStyling(paragraph: result)
            
            return result
        }
        
        mutating func visitInlineCode(_ inlineCode: InlineCode) -> NSAttributedString {
            guard configuration.useInlineCode else { return applyTextStyle(inlineCode.format()) }
            
            let result = NSMutableAttributedString(string: inlineCode.code)
            stylesheet.applyStyling(inlineCode: result)
            
            return result
        }
        
        mutating func visitStrong(_ strong: Strong) -> NSAttributedString {
            guard configuration.useStrong else { return applyTextStyle(strong.format()) }

            let result = NSMutableAttributedString(string: strong.plainText)
//            let result = joinedVisitedChildren(for: strong)
            
            if strong.parent is Emphasis, configuration.useEmphasis {
                stylesheet.applyStyling(strongEmphasis: result)
            }
            else if !(strong.child(at: 0) is Emphasis) {
                stylesheet.applyStyling(strong: result)
            }
            
            return result
        }
        
        mutating func visitEmphasis(_ emphasis: Emphasis) -> NSAttributedString {
            guard configuration.useEmphasis else { return applyTextStyle(emphasis.format()) }
            
            let result = NSMutableAttributedString(string: emphasis.plainText)
//            let result = joinedVisitedChildren(for: emphasis)
            
            if emphasis.parent is Strong, configuration.useStrong {
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
        
        mutating func visitSoftBreak(_ softBreak: SoftBreak) -> NSAttributedString {
            applyTextStyle("\n")
        }
        
        mutating func visitLineBreak(_ lineBreak: LineBreak) -> NSAttributedString {
            applyTextStyle("\n\n")
        }
        
        mutating func visitLink(_ link: Link) -> NSAttributedString {
            guard configuration.useLink else { return applyTextStyle(link.format()) }

            let result = joinedVisitedChildren(for: link)
                        
            if let destination = link.destination, let url = URL(string: destination) {
                stylesheet.applyStyling(link: result)
                
                result.addAttribute(.link, value: url)
            }
            
            return result
        }

        mutating func visitText(_ text: Text) -> NSAttributedString {
            let string = NSMutableAttributedString(string: text.format())
            
            stylesheet.applyStyling(text: string)
            
            return string
        }
        
        mutating func visitStrikethrough(_ strikethrough: Strikethrough) -> NSAttributedString {
            guard configuration.useStrikethrough else { return applyTextStyle(strikethrough.format()) }

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
