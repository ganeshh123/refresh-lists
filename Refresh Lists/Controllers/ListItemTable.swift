//
//  ListItemTable.swift
//  Refresh Lists
//
//  Created by Ganesh H on 15/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation

import UIKit

extension CheckListViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDragDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let items = currentCheckList?.items {
            return items.count
        }else{
            return 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItemCell") as! ListItemController
        
        if let items = currentCheckList?.items {
            cell.setup(inputListItem: items[indexPath.row], checkListId: currentCheckList!.id, editing: self.isEditing, deleteListItemFunc: self.deleteListItem(listItemId:), editListItemFunc: self.showEditListItemName(listItemToEdit:))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = self.currentCheckList!.items?[indexPath.row]
        return [ dragItem ]
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let listItemToMove = self.currentCheckList!.items?.remove(at: sourceIndexPath.row)
        self.currentCheckList!.items?.insert(listItemToMove!, at: destinationIndexPath.row)
        
        LocalStorage.updateCheckListById(checkListId: self.currentCheckList!.id, updatedCheckList: self.currentCheckList!)
        
        DispatchQueue.main.async {
            self.currentCheckList = LocalStorage.checkListModels[self.checkListIndex!]
            self.listItemsTableView.reloadData()
        }
        
    }
    
    func deleteListItem(listItemId: UUID ){

        LocalStorage.deleteListItemById(checkListId: currentCheckList!.id, listItemId: listItemId, completion: { deletedItemIndex in
            
            if(deletedItemIndex == -1){
                return
            }else{
                
                DispatchQueue.main.async {
                    self.currentCheckList = LocalStorage.checkListModels[self.checkListIndex!]
                    self.listItemsTableView.deleteRows(at: [IndexPath(row: deletedItemIndex, section: 0)], with: .fade)
                }
                
            }
            
        })
        
    }
    
    func showEditListItemName(listItemToEdit: ListItemModel){
        
        var listItemToEdit = listItemToEdit
        let nameEditStoryBoard = UIStoryboard(name: "TextEditView", bundle: nil)
        let textEditView = nameEditStoryBoard.instantiateInitialViewController() as! TextEditViewController
        
        textEditView.confirmFunction = {inputName in 
            listItemToEdit.title = inputName
            
            LocalStorage.updateListItemById(checkListId: self.currentCheckList!.id, listItemId: listItemToEdit.id, updatedListItem: listItemToEdit)
            
            DispatchQueue.main.async {
                self.currentCheckList = LocalStorage.checkListModels[self.checkListIndex!]
                self.listItemsTableView.reloadData()
            }
        }
        
        textEditView.cancelFunction = {
            return
        }
        
        self.present(textEditView, animated: true)
        textEditView.prepareTextEditInput(color: Theme.getColorFromName(colorName: self.currentCheckList!.color), currentName: listItemToEdit.title)
        
    }
    
}

