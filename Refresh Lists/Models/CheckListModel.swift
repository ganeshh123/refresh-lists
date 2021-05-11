//
//  CheckListModel.swift
//  Refresh Lists
//
//  Created by Ganesh H on 09/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation
import UIKit

/// Model to represent a Check List
struct CheckListModel: Codable {
    
    /// Unique ID for Check list
    let id: UUID
    /// Name of the Check List
    var title: String
    /// Array of List Items
    var items: [ListItemModel]?
    /// String representing the color of the Check List's view
    var color: String
    
    /// Initializes an instance of the CheckListModel Class
    /// - Parameters:
    ///   - title: Name of Checklist
    ///   - items: Array of List Items
    ///   - color: Parameter items: Optional - String representing the color of the checklist's view
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
    
    /// Counts the number of uncompleted items in the CheckList
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
