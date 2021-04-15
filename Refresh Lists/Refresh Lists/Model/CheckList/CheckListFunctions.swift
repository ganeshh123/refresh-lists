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
    
}
