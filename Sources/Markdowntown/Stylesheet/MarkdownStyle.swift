//
//  MarkdownStyle.swift
//  
//
//  Created by Colin Humber on 2022-04-25.
//

import UIKit

protocol MarkdownStyle {
    var textColor: UIColor { get }
    var font: UIFont { get }
    var backgroundColor: UIColor? { get }
}
