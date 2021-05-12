//
//  Theme.swift
//  Refresh Lists
//
//  Created by Ganesh H on 22/03/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

/// Class for managing App Themes
class Theme {
    
    
    /// Stores & Provides the Currently Chosen Theme for the App
    static var current: ThemeProtocol = LightTheme()
    
    /// Returns Light or Dark Theme Structs based on Stored Settings
    static func getThemeSetting(){
        if(UserDefaults.standard.object(forKey: "LightTheme") != nil){
            if(UserDefaults.standard.bool(forKey: "LightTheme") == true){
                
                /* If Settings shows Light Theme, then return Light Theme Struct */
                Theme.current = LightTheme()
                
            }else{
                
                /* If Settings shows Dark Theme, then return Dark Theme Struct */
                Theme.current = DarkTheme()
                print("Read Dark Theme from Settings")
            }
        }else{
            
            /* Otherwise, return Light Theme */
            Theme.current = LightTheme()
        }
    }
    
    /// Toggles between Light and Dark Theme
    static func switchTheme(){
        if(UserDefaults.standard.object(forKey: "LightTheme") != nil){
            if(UserDefaults.standard.bool(forKey: "LightTheme") == true){
                
                /* If current theme light, then write dark theme to settings */
                UserDefaults.standard.set(false, forKey: "LightTheme")
            }else{
                
                /* If current theme dark, then write light theme to settings */
                UserDefaults.standard.set(true, forKey: "LightTheme")
            }
        }else{
            
            /* Otherwise, set theme to dark */
            UserDefaults.standard.set(false, forKey: "LightTheme")
            print("Set Theme to Light")
        }
        
        /* Update App Theme from Settings */
        self.getThemeSetting()
    }
    
    /// Returns a Color for Styling a List from a name representation
    /// - Parameter colorName: Name of color to return
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
    
    /// Returns a new  color string to change list colors
    /// - Parameter currentColorName: Current Color String
    static func switchListColor(currentColorName: String) -> String {
        
        var newColorName: String?
        
        switch currentColorName {
        case "sand":
            newColorName = "blue"
        case "blue":
            newColorName = "green"
        case "green":
            newColorName = "pink"
        case "pink":
            newColorName = "sand"
        default:
            newColorName = "sand"
        }
        
        return newColorName!
        
    }
}
