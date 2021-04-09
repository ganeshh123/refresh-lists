//
//  ListItemModel.swift
//  Refresh Lists
//
//  Created by Ganesh H on 09/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation

struct ListItemModel {
    
    let id: UUID
    
    var title: String!
    
    init(title: String){
        
        self.id = UUID()
        self.title = title
    }
    
}
