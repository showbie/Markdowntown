//
//  MarkdowntownConfiguration.swift
//  
//
//  Created by Gary Kash on 2023-05-15.
//

import Foundation

public struct MarkdowntownConfiguration {
    let useHeadings: Bool
    let useEmphasis: Bool
    let useStrong: Bool
    let useStrikethrough: Bool
    let useLink: Bool
    let useLists: Bool
    let useInlineCode: Bool
    let useCodeBlock: Bool
    let useThematicBreak: Bool
    let useHTMLBlock: Bool

    public init(useHeadings: Bool,
                useEmphasis: Bool,
                useStrong: Bool,
                useStrikethrough: Bool,
                useLink: Bool,
                useLists: Bool,
                useInlineCode: Bool,
                useCodeBlock: Bool,
                useThematicBreak: Bool,
                useHTMLBlock: Bool) {
        self.useHeadings = useHeadings
        self.useEmphasis = useEmphasis
        self.useStrong = useStrong
        self.useStrikethrough = useStrikethrough
        self.useLink = useLink
        self.useLists = useLists
        self.useInlineCode = useInlineCode
        self.useCodeBlock = useCodeBlock
        self.useThematicBreak = useThematicBreak
        self.useHTMLBlock = useHTMLBlock
    }
    
    public static let `default` = MarkdowntownConfiguration(useHeadings: true,
                                                            useEmphasis: true,
                                                            useStrong: true,
                                                            useStrikethrough: true,
                                                            useLink: true,
                                                            useLists: true,
                                                            useInlineCode: true,
                                                            useCodeBlock: true,
                                                            useThematicBreak: true,
                                                            useHTMLBlock: true)
}
