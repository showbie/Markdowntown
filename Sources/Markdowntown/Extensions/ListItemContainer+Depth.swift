//
//  ListItemContainer+Depth.swift
//  
//
//  Created by Colin Humber on 2022-04-25.
//

import Markdown

extension ListItemContainer {
    /// Depth of the list within the markup tree.
    ///
    /// This is a 1-based index.
    var depth: Int {
        var index = 1
        var currentParent = parent

        while currentParent != nil  {
            if currentParent is ListItemContainer {
                index += 1
            }
            
            currentParent = currentParent?.parent
        }
        
        return index
    }
}
