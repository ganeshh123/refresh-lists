//
//  LightTheme.swift
//  Refresh Lists
//
//  Created by Ganesh H on 12/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

struct LightTheme: ThemeProtocol{
    var sansFont: String = "font_raleway"
    var handwritingFont: String = "font_shortstack"
    var appAccentColor: UIColor = UIColor(named: "light_app_accent")!
    var appBackgroundColor: UIColor = UIColor(named: "light_app_background")!
    var greenColor: UIColor = UIColor(named: "light_green")!
    var redColor: UIColor = UIColor(named: "light_red")!
    var listBgBlueColor: UIColor = UIColor(named: "light_list_bg_blue")!
    var listBgGreenColor: UIColor = UIColor(named: "light_list_bg_green")!
    var listBgPinkColor: UIColor = UIColor(named: "light_list_bg_pink")!
    var listBgSandColor: UIColor = UIColor(named: "light_list_bg_sand")!
    var listHeaderColor: UIColor = UIColor(named: "light_list_header")!
}
