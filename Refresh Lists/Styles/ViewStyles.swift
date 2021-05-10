//
//  ViewStyles.swift
//  Refresh Lists
//
//  Created by Ganesh H on 13/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

extension UIView {
    
    func makeModalView() {
        
        /* Set Shadows */
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowColor = UIColor.darkGray.cgColor
        
        /* Set Corner Radius*/
        self.layer.cornerRadius = 10
        
        /* Set Colors */
        self.backgroundColor = Theme.current.appBackgroundColor
    }
    
    func makeCheckListCardView(checkList: CheckListModel) {
        
        /* Set Colors */
        self.setCheckListCardBackground(color: checkList.color)
        
        /* Set Shadows */
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowColor = UIColor.darkGray.cgColor
        
        /* Set Corner Radius*/
        self.layer.cornerRadius = 10
        
        /* Set Dimensions */
    }
    
    func setCheckListCardBackground(color: String){
        switch color {
        case "blue":
            self.backgroundColor = Theme.current.listBgBlueColor
        case "green":
             self.backgroundColor = Theme.current.listBgGreenColor
        case "pink":
             self.backgroundColor = Theme.current.listBgPinkColor
        case "sand":
             self.backgroundColor = Theme.current.listBgSandColor
        default:
             self.backgroundColor = Theme.current.listBgSandColor
        }
    }
    
    func makeListItem(){
        
        /* Set Colors */
        self.backgroundColor = UIColor(named: "clear")
    }
    
}
