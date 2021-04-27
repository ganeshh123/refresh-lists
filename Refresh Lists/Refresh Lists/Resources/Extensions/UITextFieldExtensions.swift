//
//  UITextFieldExtensions.swift
//  Refresh Lists
//
//  Created by Ganesh H on 15/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

extension UITextField {
    
    func invalidInput(){
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
    }
    
    func clearInvalidInput(){
        self.layer.borderWidth = 0
    }
    
    
    func makeAddListItemTextInput(placeholder: String){
        
        /* Set Colors */
        self.backgroundColor = Theme.current.appBackgroundColor
        self.textColor = Theme.current.appAccentColor
        self.tintColor = Theme.current.appAccentColor
        
        /* Set Font */
        self.font = UIFont(name: Theme.current.handwritingFont, size: 22)
        
        /* Set Text */
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : Theme.current.appAccentColor])
        
        /* Set Functions */
        
    }
    
    func makeNameEditInput(backgroundColor: UIColor, text: String){
        
        /* Set Colors */
        self.backgroundColor = backgroundColor
        self.textColor = Theme.current.appAccentColor
        self.tintColor = Theme.current.appAccentColor
        
        /* Set Font */
        self.font = UIFont(name: Theme.current.handwritingFont, size: 22)
        
        /* Set Text */
        self.text = text
        
        /* Set Functions */
        
    }
    
}
