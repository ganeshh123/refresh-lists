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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(inputListItem: ListItemModel, checkListId: UUID){
        
        self.listItem = inputListItem
        self.checkListId = checkListId
        
        self.listItemRightButton.disableButton()
        
        self.listItemView.makeListItem()
        self.listItemTitle.makeListItemLabel(text: listItem!.title)
        
        if(inputListItem.completed){
            self.listItemLeftButton.makeCheckListItemButton(icon: UIImage(named: "icon_checked")!, color: Theme.current.grayColor)
        }else{
            self.listItemLeftButton.makeCheckListItemButton(icon: UIImage(named: "icon_unchecked")!, color: Theme.current.appAccentColor)
        }
    }

    @IBAction func leftButtonPressed(_ sender: UIButton) {
        
        if(self.isEditing == false){
            toggleCompleted()
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
    
}
