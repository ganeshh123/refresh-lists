//
//  ListItemController.swift
//  Refresh Lists
//
//  Created by Ganesh H on 15/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

/// Controller for List Items
class ListItemController: UITableViewCell {
    
    /// View for the list item
    @IBOutlet var listItemView: UIView!
    /// Left Side Button of List Item Cell
    @IBOutlet var leftButton: UIButton!
    /// Title Label for List Item
    @IBOutlet var titleLabel: UILabel!
    /// Right Side Button of List Item Cell
    @IBOutlet var rightButton: UIButton!
    
    /// List Item model to represent
    var currentListItem: ListItemModel?
    /// ID of the parent check list
    var parentCheckListId: UUID?
    /// Boolean representing of Check List View is in Editing Mode
    var checkListEditing: Bool = false
    /// Function to delete the list item
    var deleteListItemFunc: (UUID) -> Void = {_ in }
    /// Function to edit the list item's name
    var editListItemFunc: (ListItemModel) -> Void = {_ in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(inputListItem: ListItemModel, checkListId: UUID, editing: Bool, deleteListItemFunc: @escaping (UUID) -> Void = {_ in }, editListItemFunc: @escaping (ListItemModel) -> Void = {_ in }){
        
        /* Set Params as member variables */
        self.currentListItem = inputListItem
        self.parentCheckListId = checkListId
        self.checkListEditing = editing
        self.deleteListItemFunc = deleteListItemFunc
        self.editListItemFunc = editListItemFunc
        
        /* Style List Item View */
        self.listItemView.makeListItem()
        
        if(self.checkListEditing == false){
            
            self.titleLabel.makeListItemLabel(text: currentListItem!.title, maxLength: 22)
            
            /* If Check List in Editing Mode, disable the right button*/
            self.rightButton.disableButton()
            
            
            /* Set Check Box icon and color based on item completion status*/
            if(inputListItem.completed){
                self.leftButton.makeCheckListItemButton(icon: UIImage(named: "icon_checked")!, color: Theme.current.grayColor)
            }else{
                self.leftButton.makeCheckListItemButton(icon: UIImage(named: "icon_unchecked")!, color: Theme.current.appAccentColor)
            }
            
        }else{
            
            self.titleLabel.makeListItemLabel(text: currentListItem!.title, maxLength: 18)
            
            /* If Check List in editing mode, enable the right button */
            self.rightButton.enableButton()
            
            /* Set the left and right buttons to be edit and delete buttons respectively */
            self.leftButton.makeCheckListItemButton(icon: UIImage(named: "icon_edit")!, color: Theme.current.greenColor)
            self.rightButton.makeCheckListItemButton(icon: UIImage(named: "icon_cross")!, color: Theme.current.redColor)
        }
    }
    
    /// Handler for Left Side Button Pressed
    /// - Parameter sender: Button Pressed
    @IBAction func leftButtonPressed(_ sender: UIButton) {
        
        if(self.checkListEditing == false){
            /* If Check List Locked, then toggle completion status */
            toggleCompleted()
        }else{
            /* If Check List is in Edit Mode, then run the edit item function */
            editListItemFunc(self.currentListItem!)
        }
    }
    
    /// Handler for Right Side Button Pressed
    /// - Parameter sender: Button Pressed
    @IBAction func listItemRightButtonPressed(_ sender: UIButton) {
        
        if(self.checkListEditing == true){
            
            /* If Check List is in Edit Mode, then run the delete item function */
            self.deleteListItemFunc(self.currentListItem!.id)
        }
    }
    
    /// Toggle the completion status of the list item
    func toggleCompleted(){
        if(currentListItem!.completed == false){
            
            /* If uncompleted, set the item as completed */
            
            self.currentListItem!.completed = true
            self.leftButton.makeCheckListItemButton(icon: UIImage(named: "icon_checked")!, color: Theme.current.grayColor)
            
        }else{
            
            /* If completed, set the item as incomplete */
            
            self.currentListItem!.completed = false
            self.leftButton.makeCheckListItemButton(icon: UIImage(named: "icon_unchecked")!, color: Theme.current.appAccentColor)
            
        }
        
        /* Persist the list item to the Local Storage */
        LocalStorage.updateListItemById(checkListId: self.parentCheckListId!, listItemId: self.currentListItem!.id, updatedListItem: self.currentListItem!)
    }
    
}
