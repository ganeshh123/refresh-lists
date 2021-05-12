//
//  ThemeProtocol.swift
//  Refresh Lists
//
//  Created by Ganesh H on 12/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

/// Protocol for creating App Themes
protocol ThemeProtocol{
    /// Sans font used for App Interface
    var sansFont: String {get}
    /// Handwriting Style font used for User Inputted Data
    var handwritingFont: String {get}
    /// Accent Color for App Text Icons
    var appAccentColor: UIColor {get}
    /// Background Color for the App
    var appBackgroundColor: UIColor {get}
    /// General Purpose Green Color
    var greenColor: UIColor {get}
    /// General Purpose Red Color
    var redColor: UIColor {get}
    /// General Purpose Gray Color
    var grayColor: UIColor {get}
    /* Colors for Check List Organization */
    var listBgBlueColor: UIColor {get}
    var listBgGreenColor: UIColor {get}
    var listBgPinkColor: UIColor {get}
    var listBgSandColor: UIColor {get}
    var listHeaderColor: UIColor {get}
}

