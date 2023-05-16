//
//  File.swift
//  
//
//  Created by Gary Kash on 2023-05-15.
//

import Foundation

public struct MarkdowntownConfiguration {
    let useHeading1: Bool
    let useHeading2: Bool
    let useHeading3: Bool
    let useHeading4: Bool
    let useHeading5: Bool
    let useHeading6: Bool
    let useEmphasis: Bool
    let useStrong: Bool
    let useStrikethrough: Bool
    let useLink: Bool
    let useOrderedList: Bool
    let useUnorderedList: Bool
    let useParagraph: Bool
    let useInlineCode: Bool
    let useCodeBlock: Bool
    let useThematicBreak: Bool
    let useHTMLBlock: Bool

    init(useHeading1: Bool = true,
         useHeading2: Bool = true,
         useHeading3: Bool = true,
         useHeading4: Bool = true,
         useHeading5: Bool = true,
         useHeading6: Bool = true,
         useEmphasis: Bool = true,
         useStrong: Bool = true,
         useStrikethrough: Bool = true,
         useLink: Bool = true,
         useOrderedList: Bool = true,
         useUnorderedList: Bool = true,
         useParagraph: Bool = true,
         useInlineCode: Bool = true,
         useCodeBlock: Bool = true,
         useThematicBreak: Bool = true,
         useHTMLBlock: Bool = true) {
        self.useHeading1 = useHeading1
        self.useHeading2 = useHeading2
        self.useHeading3 = useHeading3
        self.useHeading4 = useHeading4
        self.useHeading5 = useHeading5
        self.useHeading6 = useHeading6
        self.useEmphasis = useEmphasis
        self.useStrong = useStrong
        self.useStrikethrough = useStrikethrough
        self.useLink = useLink
        self.useOrderedList = useOrderedList
        self.useUnorderedList = useUnorderedList
        self.useParagraph = useParagraph
        self.useInlineCode = useInlineCode
        self.useCodeBlock = useCodeBlock
        self.useThematicBreak = useThematicBreak
        self.useHTMLBlock = useHTMLBlock
    }
    
    public static let `default` = MarkdowntownConfiguration()
}
