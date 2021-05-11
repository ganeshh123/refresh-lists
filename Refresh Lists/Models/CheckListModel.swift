//
//  CheckListModel.swift
//  Refresh Lists
//
//  Created by Ganesh H on 09/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation
import UIKit

struct CheckListModel: Codable {
    
    let id: UUID
    var title: String
    var items: [ListItemModel]?
    var color: String
    
    init(title: String, items: [ListItemModel]?, color: String? = "sand"){
        
        self.id = UUID()
        self.title = title
        
        if(items != nil){
            self.items = items
        }else{
            self.items = []
        }
        
        self.color = color!

    }
    
    func countUncompleted() -> Int{
        
        var uncompletedCount = 0
        
        items?.forEach({ (listItem) in
            if(listItem.completed == false){
                uncompletedCount = uncompletedCount + 1
            }
        })
        
        return uncompletedCount
    }
}
