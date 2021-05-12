//
//  ItemsListController.swift
//  Refresh Lists
//
//  Created by Ganesh H on 15/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation
import UIKit

extension CheckListViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDragDelegate{
    
    
    /// Sets the number of rows for items list
    /// - Parameters:
    ///   - tableView: Table View
    ///   - section: Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        /* Set number of rows to number of list items, otherwise zero*/
        
        if let items = currentCheckList?.items {
            return items.count
        }else{
            return 0
        }
        
        
    }
    
    /// Sets the view to display on each row to represent the list item
    /// - Parameters:
    ///   - tableView: Table View
    ///   - indexPath: Index of item
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItemCell") as! ListItemController
        
        if let items = currentCheckList?.items {
            
            /* Set up List Item View for each item */
            cell.setup(inputListItem: items[indexPath.row], checkListId: currentCheckList!.id, editing: self.isEditing, deleteListItemFunc: self.deleteListItem(listItemId:), editListItemFunc: self.showEditListItemName(listItemToEdit:))
        }
        
        return cell
    }
    
    /// Sets the height for each list item view
    /// - Parameters:
    ///   - tableView: Table View
    ///   - indexPath: Index of Item
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    /// Returns the list item which was dragged
    /// - Parameters:
    ///   - tableView: Table View
    ///   - session: Session
    ///   - indexPath: Index of Dragged Item
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = self.currentCheckList!.items?[indexPath.row]
        return [ dragItem ]
    }
    
    /// Moves a List Item from one position to another
    /// - Parameters:
    ///   - tableView: Table View
    ///   - sourceIndexPath: Index of source position
    ///   - destinationIndexPath: Index of destination position
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        /* Remove the list item from source position and insert it
            at the destination position
         */
        let listItemToMove = self.currentCheckList!.items?.remove(at: sourceIndexPath.row)
        self.currentCheckList!.items?.insert(listItemToMove!, at: destinationIndexPath.row)
        
        /* Persist new order to Local Storage */
        LocalStorage.updateCheckListById(checkListId: self.currentCheckList!.id, updatedCheckList: self.currentCheckList!)
        
        DispatchQueue.main.async {
            
            /* Reload the list to show new order */
            self.currentCheckList = LocalStorage.checkListModels[self.currentCheckListIndex!]
            self.listItemsTableView.reloadData()
        }
        
    }
    
    /// Deletes the list item with a specified Id from the Check List
    /// - Parameter listItemId: Id of the list item to delete
    func deleteListItem(listItemId: UUID ){

        /* Delete the list item from the Check List in Local Storage */
        LocalStorage.deleteListItemById(checkListId: currentCheckList!.id, listItemId: listItemId, completion: { deletedItemIndex in
            
            if(deletedItemIndex == -1){
                /* If no item found to delete, stop*/
                return
            }else{
                
                /* If item deleted, then update the list view to show this change*/
                
                DispatchQueue.main.async {
                    self.currentCheckList = LocalStorage.checkListModels[self.currentCheckListIndex!]
                    self.listItemsTableView.deleteRows(at: [IndexPath(row: deletedItemIndex, section: 0)], with: .fade)
                }
                
            }
            
        })
        
    }
    
    /// Allows the user to rename a provided list item
    /// - Parameter listItemToEdit: List Item to rename
    func showEditListItemName(listItemToEdit: ListItemModel){
        
        /* Prepare the Text Edit View */
        var listItemToEdit = listItemToEdit
        let nameEditStoryBoard = UIStoryboard(name: "TextEditView", bundle: nil)
        let textEditView = nameEditStoryBoard.instantiateInitialViewController() as! TextEditViewController
        
        
        /* Set the function to run when a new name is confirmed */
        textEditView.confirmFunction = {inputName in
            
            /* Set the new name and persist to local storage */
            listItemToEdit.title = inputName
            LocalStorage.updateListItemById(checkListId: self.currentCheckList!.id, listItemId: listItemToEdit.id, updatedListItem: listItemToEdit)
            
            DispatchQueue.main.async {
                
                /* Update the list to show the new name */
                self.currentCheckList = LocalStorage.checkListModels[self.currentCheckListIndex!]
                self.listItemsTableView.reloadData()
            }
        }
        
        textEditView.cancelFunction = {
            return
        }
        
        
        /* Show the Text Edit View, and style the Text field */
        self.present(textEditView, animated: true)
        textEditView.prepareTextEditInput(color: Theme.getColorFromName(colorName: self.currentCheckList!.color), currentName: listItemToEdit.title)
        
    }
    
}

