//
//  ModalView.swift
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
    
}
