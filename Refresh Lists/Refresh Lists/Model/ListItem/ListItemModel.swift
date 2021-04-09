//
//  ListItemModel.swift
//  Refresh Lists
//
//  Created by Ganesh H on 09/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation

struct ListItemModel {
    
    var title: String!
    
    init(title: String){
        if(title != ""){
            self.title = title
        }
    }
    
}
