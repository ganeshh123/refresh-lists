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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(inputListItem: ListItemModel){
        
        self.listItem = inputListItem
        
        self.listItemRightButton.disableButton()
        
        self.listItemView.makeListItem()
        self.listItemTitle.makeListItemLabel(text: listItem!.title)
        
        
    }

}
