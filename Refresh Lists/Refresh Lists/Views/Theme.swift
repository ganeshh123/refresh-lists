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
                print("Read Light Theme from Settings")
            }else{
                Theme.current = DarkTheme()
                print("Read Dark Theme from Settings")
            }
        }else{
            Theme.current = LightTheme()
        }
    }
    
    static func switchTheme(){
        if(UserDefaults.standard.object(forKey: "LightTheme") != nil){
            if(UserDefaults.standard.bool(forKey: "LightTheme") == true){
                UserDefaults.standard.set(false, forKey: "LightTheme")
                print("Set Theme to Dark")
            }else{
                UserDefaults.standard.set(true, forKey: "LightTheme")
                print("Set Theme to Light")
            }
        }else{
            UserDefaults.standard.set(true, forKey: "LightTheme")
            print("Set Theme to Light")
        }
        
        self.getThemeSetting()
    }
}
