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
    
}
