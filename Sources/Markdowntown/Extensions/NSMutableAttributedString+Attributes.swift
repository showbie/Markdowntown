//
//  NSMutableAttributedString+Attributes.swift
//  
//
//  Created by Colin Humber on 2022-04-25.
//

import Foundation

extension NSMutableAttributedString {
    func addAttribute(_ attribute: NSAttributedString.Key, value: Any) {
        addAttribute(attribute, value: value, range: NSRange(location: 0, length: length))
    }
    
    func setAttributes(_ attributes: [NSAttributedString.Key: Any]) {
        setAttributes(attributes, range: NSRange(location: 0, length: length))
    }
}
