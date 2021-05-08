//
//  ListItemView.swift
//  Refresh Lists
//
//  Created by Ganesh H on 15/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

class ListItemViewCell: UITableViewCell {
    
    @IBOutlet var listItemView: UIView!
    @IBOutlet var listItemLeftButton: UIButton!
    @IBOutlet var listItemTitle: UILabel!
    @IBOutlet var listItemRightButton: UIButton!
    
    var listItem: ListItemModel?
    var checkListId: UUID?
    var checkListEditing: Bool = false
    var deleteListItemFunc: (UUID) -> Void = {_ in }
    var editListItemFunc: (ListItemModel) -> Void = {_ in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(inputListItem: ListItemModel, checkListId: UUID, editing: Bool, deleteListItemFunc: @escaping (UUID) -> Void = {_ in }, editListItemFunc: @escaping (ListItemModel) -> Void = {_ in }){
        
        self.listItem = inputListItem
        self.checkListId = checkListId
        self.checkListEditing = editing
        self.deleteListItemFunc = deleteListItemFunc
        self.editListItemFunc = editListItemFunc
        
        self.listItemView.makeListItem()
        
        if(self.checkListEditing == false){
            
            self.listItemTitle.makeListItemLabel(text: listItem!.title, maxLength: 22)
            self.listItemRightButton.disableButton()
            
            if(inputListItem.completed){
                self.listItemLeftButton.makeCheckListItemButton(icon: UIImage(named: "icon_checked")!, color: Theme.current.grayColor)
            }else{
                self.listItemLeftButton.makeCheckListItemButton(icon: UIImage(named: "icon_unchecked")!, color: Theme.current.appAccentColor)
            }
        }else{
            
            self.listItemTitle.makeListItemLabel(text: listItem!.title, maxLength: 18)
            self.listItemRightButton.enableButton()
            
            self.listItemLeftButton.makeCheckListItemButton(icon: UIImage(named: "icon_edit")!, color: Theme.current.greenColor)
            self.listItemRightButton.makeCheckListItemButton(icon: UIImage(named: "icon_cross")!, color: Theme.current.redColor)
        }
    }

    @IBAction func leftButtonPressed(_ sender: UIButton) {
        
        if(self.checkListEditing == false){
            toggleCompleted()
        }else{
            editListItemFunc(self.listItem!)
        }
    }
    
    func toggleCompleted(){
        if(listItem!.completed == false){
            
            self.listItem!.completed = true
            self.listItemLeftButton.makeCheckListItemButton(icon: UIImage(named: "icon_checked")!, color: Theme.current.grayColor)
            
        }else{
            
            self.listItem!.completed = false
            self.listItemLeftButton.makeCheckListItemButton(icon: UIImage(named: "icon_unchecked")!, color: Theme.current.appAccentColor)
            
        }
        
        CheckListFunctions.updateListItemById(checkListId: self.checkListId!, listItemId: self.listItem!.id, updatedListItem: self.listItem!)
    }
    
    
    @IBAction func listItemRightButtonPressed(_ sender: UIButton) {
        
        if(self.checkListEditing == true){
            
            self.deleteListItemFunc(self.listItem!.id)
        }
    }
    
}
