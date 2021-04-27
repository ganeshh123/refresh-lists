//
//  CheckListFunctions.swift
//  Refresh Lists
//
//  Created by Ganesh H on 09/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation

class CheckListFunctions {
    
    
    static func readCheckLists(completion: @escaping () -> ()){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            // TODO: Fetch CheckLists from CoreData Storage
            
            if(Data.checkListModels.count == 0){
                Data.checkListModels = MockData.createMockCheckListModelData()
            }
            
            DispatchQueue.main.async {
                completion()
            }
            
        }
    }
    
    static func updateCheckList(index: Int, updatedCheckList: CheckListModel){
        Data.checkListModels[index] = updatedCheckList
        
        /* TODO: Push to Core Data */
    }
    
    static func updateCheckListById(checkListId: UUID, updatedCheckList: CheckListModel){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            if let checkListIndex = Data.checkListModels.firstIndex(where: { $0.id == checkListId}){
                
                print("Updated Check List")
                Data.checkListModels[checkListIndex] = updatedCheckList
                
                /* TODO: Push to Core Data */
            }
            
        }
        
    }
    
    static func updateListItemById(checkListId: UUID, listItemId: UUID, updatedListItem: ListItemModel){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            if let checkListIndex = Data.checkListModels.firstIndex(where: { $0.id == checkListId}){
                if let listItemIndex = Data.checkListModels[checkListIndex].items?.firstIndex(where: { $0.id == listItemId}){
                    
                    Data.checkListModels[checkListIndex].items![listItemIndex] = updatedListItem
                    
                    print("Updated List Item" )
                    /* Todo Push to Core Data */
                    
                }
            }
            
        }
        
    }
    
    static func deleteListItemById(checkListId: UUID, listItemId: UUID, completion: @escaping (Int) -> ()){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            if let checkListIndex = Data.checkListModels.firstIndex(where: { $0.id == checkListId}){
                if let listItemIndex = Data.checkListModels[checkListIndex].items?.firstIndex(where: { $0.id == listItemId}){
                    
                    Data.checkListModels[checkListIndex].items!.remove(at: listItemIndex)
                    
                    print("Deleted List Item")
                    /* Todo Push to Core Data */
                    
                    completion(listItemIndex)
                    
                    return
                    
                }
            }
            
            completion(-1)
            return
            
        }
        
    }
    
    static func deleteCheckListById(checkListId: UUID, completion: @escaping (Int) -> ()){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            if let checkListIndex = Data.checkListModels.firstIndex(where: { $0.id == checkListId}){
                
                Data.checkListModels.remove(at: checkListIndex)
                print("Deleted Check List")
                
                completion(checkListIndex)
                
            }
            
            completion(-1)
            return
            
        }
        
    }
    
}
