//
//  ListItemModel.swift
//  Refresh Lists
//
//  Created by Ganesh H on 09/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation

struct ListItemModel: Codable {
    
    let id: UUID
    
    var title: String!
    var completed: Bool
    
    init(title: String, completed: Bool = false){
        
        self.id = UUID()
        self.title = title
        self.completed = completed
    }
    
}
