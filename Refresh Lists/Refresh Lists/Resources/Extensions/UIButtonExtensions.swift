//
//  UIButtonExtension.swift
//  Refresh Lists
//
//  Created by Ganesh H on 13/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

extension UIButton {
    
    
    
    func makeMainAppButton(){
        
        self.tintColor = Theme.current.appAccentColor
    }
    
    func makeSettingsButton(title: String, icon: UIImage){
        
        let lineView = UIView(frame: CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 2))
        lineView.backgroundColor = Theme.current.grayColor
        self.addSubview(lineView)
        
        self.tintColor = Theme.current.appAccentColor
        
        self.setImage(icon, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 14, left: 10, bottom: 14, right: 168)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(Theme.current.appAccentColor, for: .normal)
        self.titleLabel!.font = UIFont(name: "font_raleway", size: 17)
        self.titleEdgeInsets = UIEdgeInsets(top: 14, left: 15, bottom: 14, right: 10)
    }
    
}
