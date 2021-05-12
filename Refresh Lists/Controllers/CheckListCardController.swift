//
//  CheckListCardController.swift
//  Refresh Lists
//
//  Created by Ganesh H on 13/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

/// View to show a Check List's Card in the Main App Screen
class CheckListCardController: UITableViewCell {
    
    /// Card View for Check List
    @IBOutlet var checkListCardView: UIView!
    /// Label showing Name of Check List
    @IBOutlet var titleLabel: UILabel!
    /// Label showing number of uncompleted items on the Check List
    @IBOutlet var incompleteItemCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setup(checkListModel: CheckListModel){
        
        /* Style the Card and set the labels */
        checkListCardView.makeCheckListCardView(checkList: checkListModel)
        titleLabel.makeCheckListCardTitle(title: checkListModel.title, maxLength: 18)
        incompleteItemCountLabel.makeCheckListCardItemCount(text: String(checkListModel.countUncompleted()) + " items left")
        
    }
    
    /// Adds Margin Gaps to Check List Cards
    override func layoutSubviews() {
          super.layoutSubviews()
          //set the values for top,left,bottom,right margins
          let margins = UIEdgeInsets(top: 0, left: 30, bottom: 20, right: 30)
          contentView.frame = contentView.frame.inset(by: margins)
          contentView.layer.cornerRadius = 10
    }

}
