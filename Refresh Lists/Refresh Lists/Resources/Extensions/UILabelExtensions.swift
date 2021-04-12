//
//  UILabelExtensions.swift
//  Refresh Lists
//
//  Created by Ganesh H on 12/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

extension UILabel {
    
    func makeScreenTitleLabel() {
        
        /* Set Colors */
        self.textColor = Theme.current.appAccentColor
        
        /* Set Font */
        self.font = self.font.withSize(34.0)
        
    }
    
}
