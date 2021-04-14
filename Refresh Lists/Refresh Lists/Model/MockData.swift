//
//  MockData.swift
//  Refresh Lists
//
//  Created by Ganesh H on 09/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation

class MockData {
    
    static func createMockCheckListModelData() -> [CheckListModel] {
        
        var models = [CheckListModel]()
        
        models.append(
            CheckListModel(
                title: "Weekly Shop",
                items: createMockShoppingListItemModelData(),
                refresh: createMockRefreshDateTimeSelectionModelData(),
                reminder: createMockReminderDateTimeSelectionModelData()
            )
            
        )
        
        models.append(
            CheckListModel(
                title: "Bedtime Pills",
                items: createMockShoppingListItemModelData(),
                refresh: createMockRefreshDateTimeSelectionModelData(),
                reminder: createMockReminderDateTimeSelectionModelData(),
                color: Theme.current.listBgGreenColor
            )
            
        )
        
        models.append(
            CheckListModel(
                title: "Utility Bills",
                items: createMockShoppingListItemModelData(),
                refresh: createMockRefreshDateTimeSelectionModelData(),
                reminder: createMockReminderDateTimeSelectionModelData(),
                color: Theme.current.listBgBlueColor
            )
            
        )
        
        models.append(
            CheckListModel(
                title: "Fishing Supplies",
                items: createMockShoppingListItemModelData(),
                refresh: createMockRefreshDateTimeSelectionModelData(),
                reminder: createMockReminderDateTimeSelectionModelData(),
                color: Theme.current.listBgPinkColor
            )
            
        )

        models.append(
            CheckListModel(
                title: "Phone Backup",
                items: createMockShoppingListItemModelData(),
                refresh: createMockRefreshDateTimeSelectionModelData(),
                reminder: createMockReminderDateTimeSelectionModelData()
            )
            
        )

        
        return models
    }
    
    static func createMockRefreshDateTimeSelectionModelData() -> DateTimeSelectionModel {
        
        let model = DateTimeSelectionModel(hours: [9], days: [2], dates: [0], months: [0])
        
        return model
    }
    
    static func createMockReminderDateTimeSelectionModelData() -> DateTimeSelectionModel {
        let model = DateTimeSelectionModel(hours: [9], days: [1], dates: [0], months: [0])
        
        return model
    }
    
    static func createMockShoppingListItemModelData() -> [ListItemModel] {
        
        var models = [ListItemModel]()
        
        models.append(ListItemModel(title: "Wholemeal Bread"))
        models.append(ListItemModel(title: "Oils - Coconut, Olive, Sunflower"))
        models.append(ListItemModel(title: "Granny Smith Apples"))
        models.append(ListItemModel(title: "Nicotine Tablets"))
        models.append(ListItemModel(title: "Free Range Eggs - 6 Pack"))
        models.append(ListItemModel(title: "Spaghetti"))
        models.append(ListItemModel(title: "Semi Skimmed Milk"))
        models.append(ListItemModel(title: "Yoghurt"))
        models.append(ListItemModel(title: "Easy Cook Rice"))
        models.append(ListItemModel(title: "Salmon"))
        models.append(ListItemModel(title: "Tomato Soup"))
        models.append(ListItemModel(title: "Potatoes"))
        models.append(ListItemModel(title: "Wheetabix"))
        
        return models
    }
    
}
