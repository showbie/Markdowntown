//
//  MarkdowntownConfiguration.swift
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
    let useSoftBreak: Bool
    let useLineBreak: Bool
    let useInlineCode: Bool
    let useCodeBlock: Bool
    let useThematicBreak: Bool
    let useHTMLBlock: Bool

    public init(useHeading1: Bool,
                useHeading2: Bool,
                useHeading3: Bool,
                useHeading4: Bool,
                useHeading5: Bool,
                useHeading6: Bool,
                useEmphasis: Bool,
                useStrong: Bool,
                useStrikethrough: Bool,
                useLink: Bool,
                useOrderedList: Bool,
                useUnorderedList: Bool,
                useParagraph: Bool,
                useSoftBreak: Bool,
                useLineBreak: Bool,
                useInlineCode: Bool,
                useCodeBlock: Bool,
                useThematicBreak: Bool,
                useHTMLBlock: Bool) {
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
        self.useSoftBreak = useSoftBreak
        self.useLineBreak = useLineBreak
        self.useInlineCode = useInlineCode
        self.useCodeBlock = useCodeBlock
        self.useThematicBreak = useThematicBreak
        self.useHTMLBlock = useHTMLBlock
    }
    
    public static let `default` = MarkdowntownConfiguration(useHeading1: true,
                                                            useHeading2: true,
                                                            useHeading3: true,
                                                            useHeading4: true,
                                                            useHeading5: true,
                                                            useHeading6: true,
                                                            useEmphasis: true,
                                                            useStrong: true,
                                                            useStrikethrough: true,
                                                            useLink: true,
                                                            useOrderedList: true,
                                                            useUnorderedList: true,
                                                            useParagraph: true,
                                                            useSoftBreak: true,
                                                            useLineBreak: true,
                                                            useInlineCode: true,
                                                            useCodeBlock: true,
                                                            useThematicBreak: true,
                                                            useHTMLBlock: true)
}
