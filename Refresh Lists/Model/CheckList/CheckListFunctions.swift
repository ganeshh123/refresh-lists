//
//  CheckListFunctions.swift
//  Refresh Lists
//
//  Created by Ganesh H on 09/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation
import CoreData

class CheckListFunctions {
    
    
    static func readCheckLists(completion: @escaping () -> ()){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            // TODO: Fetch CheckLists from CoreData Storage
            Data.fetchCheckListsFromStorage()
            
            DispatchQueue.main.async {
                completion()
            }
            
        }
    }
    
    static func newCheckList(checkListToAdd: CheckListModel, completion: @escaping (CheckListModel) -> ()){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            /* Add to Core Data*/
            
            Data.checkListModels.insert(checkListToAdd, at: 0)
            Data.writeCheckListsToStorage()
            
            DispatchQueue.main.async {
                completion(checkListToAdd)
            }
            
        }
        
    }
    
    
    static func updateCheckListById(checkListId: UUID, updatedCheckList: CheckListModel){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            if let checkListIndex = Data.checkListModels.firstIndex(where: { $0.id == checkListId}){
                
                print("Updated Check List")
                Data.checkListModels[checkListIndex] = updatedCheckList
                
                /* TODO: Push to Core Data */
                Data.writeCheckListsToStorage()
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
                    Data.writeCheckListsToStorage()
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
                    Data.writeCheckListsToStorage()
                    
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
                Data.writeCheckListsToStorage()
                
                completion(checkListIndex)
                
            }
            
            completion(-1)
            return
            
        }
        
    }
    
}
