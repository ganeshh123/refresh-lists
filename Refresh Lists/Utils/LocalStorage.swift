//
//  LocalStorage.swift
//  Refresh Lists
//
//  Created by Ganesh H on 09/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation
import CoreData

/// Persistent Storage for Check List Data
class LocalStorage {
    
    /// Array of Check Lists in the App's State
    static var checkListModels = [CheckListModel]()
    
    /// Persists the Check Lists from the App State to the Local Storage
    static func writeCheckListsToStorage(){
        
        do {
            /* Encore the Check Lists Array from the App State as a JSON String */
            let encoder = JSONEncoder()
            let dataToStore = try encoder.encode(self.checkListModels)
            
            /* Write JSON String as an item in UserDefaults */
            UserDefaults.standard.set(dataToStore, forKey: "userLists")
            
        } catch {
            
            /* Error Writing to User Defaults */
            print("Error Storing Checklists!")
        }
        
        
    }
    
    /// Loads Check Lists from Local Storage into App State Array
    static func fetchCheckListsFromStorage(){
        
        if let fetchedData = UserDefaults.standard.data(forKey: "userLists") {
            
            /* Check List Data exists in UserDefaults */
            
            do {
                /* Decode JSON String into Array of Check List Models */
                let decoder = JSONDecoder()
                let fetchedCheckLists = try decoder.decode([CheckListModel].self, from: fetchedData)
                
                if(fetchedCheckLists.count > 0){
                    /* If at least one Check List Present, then load the Check List Array into the App State */
                    self.checkListModels = fetchedCheckLists
                    return
                }
                
            } catch {
                
                /* Error reading from UserDefaults */
                print("Error Reading CheckLists!")

            }
        }
            
        /* No Check List Data in User Defaults */
         
        /* Create Mock Data in App State */
        self.checkListModels = MockData.createMockCheckListModelData()
        
    }
    
    
    /// Loads Check Lists from Local Storage using background thread and executes code once finished
    /// - Parameter completion: Code to execute once reading data completed
    static func readCheckLists(completion: @escaping () -> ()){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            /* Load Check Lists from Local Storage into App State in a Background Thread */
            LocalStorage.fetchCheckListsFromStorage()
            
            DispatchQueue.main.async {
                
                /* Run the completion code in the Main Thread */
                completion()
            }
            
        }
    }
    
    /// Creates a new Check List in App State & Local Storage
    /// - Parameters:
    ///   - checkListToAdd: Check List to be created
    ///   - completion: Code to run with created Check List
    static func newCheckList(checkListToAdd: CheckListModel, completion: @escaping (CheckListModel) -> ()){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            /*  Background Threead */
            
            /* Add new Check List to the top of the App State Check Lists Array */
            LocalStorage.checkListModels.insert(checkListToAdd, at: 0)
            /* Write App State Array to Local Storage */
            LocalStorage.writeCheckListsToStorage()
            
            DispatchQueue.main.async {
                
                /* Run Completion Function in Main Thread */
                completion(checkListToAdd)
            }
            
        }
        
    }
    
    
    /// Updates a Check List in App State & Local Storage
    /// - Parameters:
    ///   - checkListId: Id of Check List to be updated
    ///   - updatedCheckList: Check List model with desired properties
    static func updateCheckListById(checkListId: UUID, updatedCheckList: CheckListModel){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            /* Background Thread */
            
            /* Find the index of the Check List to modify */
            if let checkListIndex = LocalStorage.checkListModels.firstIndex(where: { $0.id == checkListId}){
                
                /* Assign Updated Check List to index in App State Array */
                LocalStorage.checkListModels[checkListIndex] = updatedCheckList
                
                /* Write App State Array to Local Storage */
                LocalStorage.writeCheckListsToStorage()
            }
            
        }
        
    }
    
    /// Updates a List Item in App State & Local Storage
    /// - Parameters:
    ///   - checkListId: Id of Check List to update item in
    ///   - listItemId: Id of List Item to update
    ///   - updatedListItem: List Item model with desired properties
    static func updateListItemById(checkListId: UUID, listItemId: UUID, updatedListItem: ListItemModel){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            /* Background Thread */
            
            /* Find the index of the Check List to modify */
            if let checkListIndex = LocalStorage.checkListModels.firstIndex(where: { $0.id == checkListId}){
                
                /* Find the index of the List Item to modify */
                if let listItemIndex = LocalStorage.checkListModels[checkListIndex].items?.firstIndex(where: { $0.id == listItemId}){
                    
                    /* Assign Updated List Item to index in App State Check List Items Array */
                    LocalStorage.checkListModels[checkListIndex].items![listItemIndex] = updatedListItem
                    
                    /* Write App State Array to Local Storage */
                    LocalStorage.writeCheckListsToStorage()
                }
            }
            
        }
        
    }
    
    /// Deletes a List Item in App State & Local Storage and returns its old index (-1 if not found)
    /// - Parameters:
    ///   - checkListId: Id of Check List to delete item from
    ///   - listItemId: Id of List Item to delete
    ///   - completion: Function to Run with provided index of the deleted list item
    static func deleteListItemById(checkListId: UUID, listItemId: UUID, completion: @escaping (Int) -> ()){

        DispatchQueue.global(qos: .userInteractive).async {
            
            /* Background Thread */
            
            /* Find the index of the Check List to delete item from */
            if let checkListIndex = LocalStorage.checkListModels.firstIndex(where: { $0.id == checkListId}){
                
                 /* Find the index of the List Item to delete */
                if let listItemIndex = LocalStorage.checkListModels[checkListIndex].items?.firstIndex(where: { $0.id == listItemId}){
                    
                     /* Remove List Item from App State Check List Items Array */
                    LocalStorage.checkListModels[checkListIndex].items!.remove(at: listItemIndex)
                    
                    /* Write App State Array to Local Storage */
                    LocalStorage.writeCheckListsToStorage()
                    
                    /* Run the Completion Handler providing the (old) index of the deleted item */
                    completion(listItemIndex)
                    
                    return
                    
                }
            }
            
            /* Run the completion handler with an index of -1 to indicate that the list item
                to delete was not found
             */
            completion(-1)
            return
            
        }
        
    }
    
    /// Deletes a Check List in App State and Local Storage and returns its old index (-1 if not found)
    /// - Parameters:
    ///   - checkListId: Id of the Check List to delete
    ///   - completion: Function to run with provided index of the Deleted Check List
    static func deleteCheckListById(checkListId: UUID, completion: @escaping (Int) -> ()){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            /* Background Thread */
            
            /* Find the index of the Check List to delete */
            if let checkListIndex = LocalStorage.checkListModels.firstIndex(where: { $0.id == checkListId}){
                
                /* Remove Check List from App State Array */
                LocalStorage.checkListModels.remove(at: checkListIndex)
                
                /* Write App State Array to Local Storage */
                LocalStorage.writeCheckListsToStorage()
                
                /* Run the Completion Handler providing the (old) index of the deleted check list */
                completion(checkListIndex)
                
            }
            
            /* Run the completion handler with an index of -1 to indicate that the check list
               to delete was not found
            */
            completion(-1)
            return
            
        }
        
    }
    
    /// Moves the position of a Check List from one index to another in App State & Local Storage
    /// - Parameters:
    ///   - sourceIndexPath: Index of the original position of the Check List in the App State Check Lists Array
    ///   - destinationIndexPath: Index of the intended position of the Check List in the App State Check Lists Array
    ///   - completion: Function to run once check list has been moved
    static func moveCheckList(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath, completion: @escaping () -> ()){
        
        /* Remove (and fetch) the Check List from its current position in the App State Array */
        let checkListToMove = LocalStorage.checkListModels.remove(at: sourceIndexPath.row)
        /* Insert the Check List in its intended position in the App State Array */
        LocalStorage.checkListModels.insert(checkListToMove, at: destinationIndexPath.row)
    
        DispatchQueue.global(qos: .userInteractive).async {
            
             /* Write App State Array to Local Storage in the Background Thread */
            LocalStorage.writeCheckListsToStorage()
            
            /* Run the Completion Handler */
            completion()
    
        }
            
    }
    
}
