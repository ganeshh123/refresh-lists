//
//  LocalStorage.swift
//  Refresh Lists
//
//  Created by Ganesh H on 09/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation
import CoreData

class LocalStorage {
    
    static var checkListModels = [CheckListModel]()
    
    static func writeCheckListsToStorage(){
        
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let dataToStore = try encoder.encode(self.checkListModels)
            
            print("Writing Userdata to Storage")
            print(String(data: dataToStore, encoding: .utf8)!)
            
            // Write/Set Data
            UserDefaults.standard.set(dataToStore, forKey: "userLists")
            
        } catch {
            print("Error Storing Checklists!")
        }
        
        
    }
    
    static func fetchCheckListsFromStorage(){
        
        if let fetchedData = UserDefaults.standard.data(forKey: "userLists") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let fetchedCheckLists = try decoder.decode([CheckListModel].self, from: fetchedData)
                
                if(fetchedCheckLists.count > 0){
                    self.checkListModels = fetchedCheckLists
                }else{
                    self.checkListModels = MockData.createMockCheckListModelData()
                }
                
            } catch {
                print("Error Reading CheckLists!")
                self.checkListModels = MockData.createMockCheckListModelData()
            }
        }else{
            self.checkListModels = MockData.createMockCheckListModelData()
        }
        
        
    }
    
    
    static func readCheckLists(completion: @escaping () -> ()){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            // TODO: Fetch CheckLists from CoreData Storage
            LocalStorage.fetchCheckListsFromStorage()
            
            DispatchQueue.main.async {
                completion()
            }
            
        }
    }
    
    static func newCheckList(checkListToAdd: CheckListModel, completion: @escaping (CheckListModel) -> ()){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            /* Add to Core Data*/
            
            LocalStorage.checkListModels.insert(checkListToAdd, at: 0)
            LocalStorage.writeCheckListsToStorage()
            
            DispatchQueue.main.async {
                completion(checkListToAdd)
            }
            
        }
        
    }
    
    
    static func updateCheckListById(checkListId: UUID, updatedCheckList: CheckListModel){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            if let checkListIndex = LocalStorage.checkListModels.firstIndex(where: { $0.id == checkListId}){
                
                print("Updated Check List")
                LocalStorage.checkListModels[checkListIndex] = updatedCheckList
                
                /* TODO: Push to Core Data */
                LocalStorage.writeCheckListsToStorage()
            }
            
        }
        
    }
    
    static func updateListItemById(checkListId: UUID, listItemId: UUID, updatedListItem: ListItemModel){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            if let checkListIndex = LocalStorage.checkListModels.firstIndex(where: { $0.id == checkListId}){
                if let listItemIndex = LocalStorage.checkListModels[checkListIndex].items?.firstIndex(where: { $0.id == listItemId}){
                    
                    LocalStorage.checkListModels[checkListIndex].items![listItemIndex] = updatedListItem
                    
                    print("Updated List Item" )
                    /* Todo Push to Core Data */
                    LocalStorage.writeCheckListsToStorage()
                }
            }
            
        }
        
    }
    
    static func deleteListItemById(checkListId: UUID, listItemId: UUID, completion: @escaping (Int) -> ()){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            if let checkListIndex = LocalStorage.checkListModels.firstIndex(where: { $0.id == checkListId}){
                if let listItemIndex = LocalStorage.checkListModels[checkListIndex].items?.firstIndex(where: { $0.id == listItemId}){
                    
                    LocalStorage.checkListModels[checkListIndex].items!.remove(at: listItemIndex)
                    
                    print("Deleted List Item")
                    
                    /* Todo Push to Core Data */
                    LocalStorage.writeCheckListsToStorage()
                    
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
            
            if let checkListIndex = LocalStorage.checkListModels.firstIndex(where: { $0.id == checkListId}){
                
                LocalStorage.checkListModels.remove(at: checkListIndex)
                print("Deleted Check List")
                LocalStorage.writeCheckListsToStorage()
                
                completion(checkListIndex)
                
            }
            
            completion(-1)
            return
            
        }
        
    }
    
    static func moveCheckList(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath, completion: @escaping () -> ()){
        
        let checkListToMove = LocalStorage.checkListModels.remove(at: sourceIndexPath.row)
        LocalStorage.checkListModels.insert(checkListToMove, at: destinationIndexPath.row)
    
        DispatchQueue.global(qos: .userInteractive).async {
            LocalStorage.writeCheckListsToStorage()

            completion()
    
        }
            
    }
    
}
