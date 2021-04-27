//
//  ListItemTable.swift
//  Refresh Lists
//
//  Created by Ganesh H on 15/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation

import UIKit

extension CheckListViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let items = currentCheckList?.items {
            return items.count
        }else{
            return 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItemCell") as! ListItemViewCell
        
        if let items = currentCheckList?.items {
            cell.setup(inputListItem: items[indexPath.row], checkListId: currentCheckList!.id, editing: self.isEditing, deleteListItemFunc: self.deleteListItem(listItemId:), editListItemFunc: self.showEditListItemName(listItemToEdit:))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func deleteListItem(listItemId: UUID ){

        CheckListFunctions.deleteListItemById(checkListId: currentCheckList!.id, listItemId: listItemId, completion: { deletedItemIndex in
            
            if(deletedItemIndex == -1){
                return
            }else{
                
                DispatchQueue.main.async {
                    self.currentCheckList = Data.checkListModels[self.checkListIndex!]
                    self.listItemsTableView.deleteRows(at: [IndexPath(row: deletedItemIndex, section: 0)], with: .fade)
                }
                
            }
            
        })
        
    }
    
    func showEditListItemName(listItemToEdit: ListItemModel){
        
        var listItemToEdit = listItemToEdit
        let nameEditStoryBoard = UIStoryboard(name: "NameEditView", bundle: nil)
        let nameEditView = nameEditStoryBoard.instantiateInitialViewController() as! NameEditViewController
        
        nameEditView.confirmFunction = {inputName in 
            listItemToEdit.title = inputName
            
            CheckListFunctions.updateListItemById(checkListId: self.currentCheckList!.id, listItemId: listItemToEdit.id, updatedListItem: listItemToEdit)
            
            DispatchQueue.main.async {
                self.currentCheckList = Data.checkListModels[self.checkListIndex!]
                self.listItemsTableView.reloadData()
            }
        }
        
        nameEditView.cancelFunction = {
            return
        }
        
        self.present(nameEditView, animated: true)
        nameEditView.prepareNameEditInput(color: Theme.current.listBgSandColor, currentName: listItemToEdit.title)
        
    }
    
}

