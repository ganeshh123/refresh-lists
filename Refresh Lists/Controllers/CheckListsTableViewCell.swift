//
//  CheckListsTableViewCell.swift
//  Refresh Lists
//
//  Created by Ganesh H on 13/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

class CheckListsTableViewCell: UITableViewCell {

    @IBOutlet var checkListCard: UIView!
    @IBOutlet var checkListCardTitle: UILabel!
    @IBOutlet var checkListCardItemCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    func setup(checkListModel: CheckListModel){
        
        checkListCard.makeCheckListCardView(checkList: checkListModel)
        checkListCardTitle.makeCheckListCardTitle(title: checkListModel.title, maxLength: 18)
        
        checkListCardItemCountLabel.makeCheckListCardItemCount(text: String(checkListModel.countUncompleted()) + " items left")
        
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          //set the values for top,left,bottom,right margins
          let margins = UIEdgeInsets(top: 0, left: 30, bottom: 20, right: 30)
          contentView.frame = contentView.frame.inset(by: margins)
          contentView.layer.cornerRadius = 10
    }

}
