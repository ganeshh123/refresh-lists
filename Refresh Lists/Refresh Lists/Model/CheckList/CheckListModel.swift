//
//  CheckListModel.swift
//  Refresh Lists
//
//  Created by Ganesh H on 09/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation

struct CheckListModel {
    
    let id: UUID
    
    var title: String
    var items: [ListItemModel]?
    var refresh: DateTimeSelectionModel
    var reminder: DateTimeSelectionModel
    
    init(title: String){
        self.id = UUID()
        self.title = title
        self.items = []
        self.refresh = DateTimeSelectionModel(hours: [],days: [],dates: [],months: [])
        self.reminder = DateTimeSelectionModel(hours: [],days: [],dates: [],months: [])
    }
}
