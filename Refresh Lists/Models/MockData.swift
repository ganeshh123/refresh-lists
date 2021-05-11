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
                items: createMockShoppingListItemModelData()
            )
            
        )
        
        models.append(
            CheckListModel(
                title: "Daily Medication",
                items: createMockDailyMedicationListItemModelData(),
                color: "green"
            )
            
        )
        
        models.append(
            CheckListModel(
                title: "Study Terms",
                items: [],
                color: "pink"
            )
            
        )
        
        models.append(
            CheckListModel(
                title: "Monthly Payments",
                items: createMockMonthlyPaymentsListItemModelData(),
                color: "blue"
            )
            
        )

        
        return models
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
    
    static func createMockMonthlyPaymentsListItemModelData() -> [ListItemModel] {
        
        var models = [ListItemModel]()
        
        models.append(ListItemModel(title: "Phone Contract"))
        models.append(ListItemModel(title: "Electricity"))
        models.append(ListItemModel(title: "Health Club Membership"))
        models.append(ListItemModel(title: "Retirement Fund"))
        
        return models
    }
    
    static func createMockDailyMedicationListItemModelData() -> [ListItemModel] {
        
        var models = [ListItemModel]()
        
        models.append(ListItemModel(title: "Insulin Glulisine"))
        models.append(ListItemModel(title: "Vitamin D"))
        models.append(ListItemModel(title: "Hayfever Tablets"))
        
        return models
    }
    
}
