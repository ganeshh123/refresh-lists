//
//  ListItemModel.swift
//  Refresh Lists
//
//  Created by Ganesh H on 09/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation

/// Model to Represent a List Item
struct ListItemModel: Codable {
    
    /// Unique identifier for list item
    let id: UUID
    /// Name of the list item
    var title: String!
    /// Boolean indicating if the list item is marked as completed
    var completed: Bool
    
    /// Creates an instance of a List Item
    /// - Parameters:
    ///   - title: Name of the list item
    ///   - completed: Optional - Boolean indicating if the list item is marked as completed
    init(title: String, completed: Bool = false){
        
        self.id = UUID()
        self.title = title
        self.completed = completed
    }
    
}
