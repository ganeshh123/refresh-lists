//
//  Theme.swift
//  Refresh Lists
//
//  Created by Ganesh H on 22/03/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

class Theme {
    static var current: ThemeProtocol = LightTheme()
    
    static func getThemeSetting(){
        if(UserDefaults.standard.object(forKey: "LightTheme") != nil){
            if(UserDefaults.standard.bool(forKey: "LightTheme") == true){
                Theme.current = LightTheme()
            }else{
                Theme.current = DarkTheme()
            }
        }else{
            Theme.current = LightTheme()
        }
        print("Set Theme from Settings")
    }
    
    static func setThemeSetting(lightThemeChosen: Bool){
        UserDefaults.standard.set(lightThemeChosen, forKey: "LightTheme")
    }
}
