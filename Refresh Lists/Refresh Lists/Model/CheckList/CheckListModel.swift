//
//  CheckListModel.swift
//  Refresh Lists
//
//  Created by Ganesh H on 09/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation
import UIKit

struct CheckListModel {
    
    let id: UUID
    
    var title: String
    var items: [ListItemModel]?
    var refresh: DateTimeSelectionModel
    var reminder: DateTimeSelectionModel
    var color: UIColor
    
    init(title: String, items: [ListItemModel]?, refresh: DateTimeSelectionModel?, reminder: DateTimeSelectionModel?, color: UIColor? = Theme.current.listBgSandColor){
        
        self.id = UUID()
        self.title = title
        
        if(items != nil){
            self.items = items
        }else{
            self.items = []
        }
        
        if(refresh != nil){
            self.refresh = refresh!
        }else{
            self.refresh = DateTimeSelectionModel(hours: [],days: [],dates: [],months: [])
        }
        
        if(reminder != nil){
            self.reminder = reminder!
        }else{
            self.reminder = DateTimeSelectionModel(hours: [],days: [],dates: [],months: [])
        }
        
        self.color = color!

    }
}
