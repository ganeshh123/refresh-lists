//
//  ThemeFunctions.swift
//  Refresh Lists
//
//  Created by Ganesh H on 27/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

class ThemeFunctions {
    
    static func getColorFromName(colorName: String) -> UIColor {
        
        var color: UIColor?
        
        switch colorName {
        case "sand":
            color = Theme.current.listBgSandColor
        case "blue":
             color = Theme.current.listBgBlueColor
        case "green":
            color = Theme.current.listBgGreenColor
        case "pink":
            color = Theme.current.listBgPinkColor
        default:
            color = Theme.current.listBgSandColor
        }
        
        return color!
        
    }
    
    static func switchListColor(currentColorName: String) -> UIColor {
        
        var newColor: UIColor?
        
        switch currentColorName {
        case "sand":
            newColor = Theme.current.listBgBlueColor
        case "blue":
            newColor = Theme.current.listBgGreenColor
        case "green":
            newColor = Theme.current.listBgPinkColor
        case "pink":
            newColor = Theme.current.listBgSandColor
        default:
            newColor = Theme.current.listBgSandColor
        }
        
        return newColor!
        
    }
}


