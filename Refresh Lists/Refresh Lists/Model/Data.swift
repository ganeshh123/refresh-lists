//
//  Data.swift
//  Refresh Lists
//
//  Created by Ganesh H on 09/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation

class Data{
    
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
}
