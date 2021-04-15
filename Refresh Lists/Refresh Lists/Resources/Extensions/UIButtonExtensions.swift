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
        self.isHidden = false
    }
    
    func makeSettingsButton(title: String, icon: UIImage){
        
        /* Set Colors */
        self.tintColor = Theme.current.appAccentColor
        
        /* Set Icon */
        self.setImage(icon, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 14, left: 10, bottom: 14, right: 168)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(Theme.current.appAccentColor, for: .normal)
        self.titleLabel!.font = UIFont(name: "font_raleway", size: 17)
        self.titleEdgeInsets = UIEdgeInsets(top: 14, left: 15, bottom: 14, right: 10)
        
        /* Set Border */
        let lineView = UIView(frame: CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 2))
        lineView.backgroundColor = Theme.current.grayColor
        self.addSubview(lineView)
    }
    
    func makeCheckListCardButton(icon: UIImage){
        
        /* Set Colors */
        self.backgroundColor = UIColor(named: "clear")
        self.tintColor = Theme.current.appAccentColor
        
        /* Set Icon */
        self.setImage(icon, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
    func makeCheckListItemButton(icon: UIImage, color: UIColor){
        
        /* Set Colors */
        self.backgroundColor = UIColor(named: "clear")
        self.tintColor = color
        
        /* Set Icon */
        self.setImage(icon, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func disableButton(){
        self.isHidden = true
        self.isEnabled = false
    }
    
    func enableButton(){
        self.isEnabled = true
        self.isHidden = false
    }
    
}
