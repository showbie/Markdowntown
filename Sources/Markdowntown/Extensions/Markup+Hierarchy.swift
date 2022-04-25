//
//  Markup+Hierarchy.swift
//  
//
//  Created by Colin Humber on 2022-04-25.
//

import Markdown

extension Markup {
    var hasSuccessor: Bool {
        guard let childCount = parent?.childCount else { return false }
        
        return indexInParent < childCount - 1
    }
    
    var isInList: Bool {
        var currentParent = parent
        
        while currentParent != nil {
            if currentParent is ListItemContainer {
                return true
            }
            
            currentParent = currentParent?.parent
        }

        return false
    }
}
