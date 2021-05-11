//
//  LabelStyles.swift
//  Refresh Lists
//
//  Created by Ganesh H on 12/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

extension UILabel {
    
    func makeScreenTitleLabel(text: String) {
        
        /* Set Colors */
        self.textColor = Theme.current.appAccentColor
        
        /* Set Font */
        self.font = self.font.withSize(34.0)
        
        /* Set Text */
        self.text = text
        
    }
    
    func makeCheckListCardTitle(title: String, maxLength: Int){
        
        /* Set Colors */
        self.textColor = Theme.current.appAccentColor
        
        /* Set Fonts */
        self.font = UIFont(name: Theme.current.handwritingFont, size: 22)
        
        /* Set Values */
        self.text = title.trunc(length: maxLength)
        
    }
    
    func makeCheckListCardItemCount(text: String){
        /* Set Colors */
        self.textColor = Theme.current.appAccentColor
        
        /* Set Fonts */
        self.font = UIFont(name: Theme.current.sansFont, size: 20)
        
        /* Set Values */
        self.text = text
    }
    
    func makeListItemLabel(text: String, maxLength: Int){
        
        /* Set Colors */
        self.textColor = Theme.current.appAccentColor
        
        /* Set Fonts */
        self.font = UIFont(name: Theme.current.handwritingFont, size: 17)
        
        /* Set Text */
        self.text = text.trunc(length: maxLength)
    }
    
    
    func makeConfirmationMessageLabel(text: String, maxLength: Int){
        
        /* Set Colors */
        self.textColor = Theme.current.appAccentColor
        
        /* Set Fonts */
        self.font = UIFont(name: Theme.current.sansFont, size: 22)
        self.textAlignment = .center
        
        /* Set Values */
        self.text = text.trunc(length: maxLength)
        
    }
    
    func makeDateTimeSelectionInfoText(text: String){
        
        /* Set Colors */
        self.textColor = Theme.current.appAccentColor
        
        /* Set Fonts */
        self.font = UIFont(name: Theme.current.handwritingFont, size: 14)
        self.textAlignment = .left
        
        
    }
    
}
