//
//  ThemeProtocol.swift
//  Refresh Lists
//
//  Created by Ganesh H on 12/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

protocol ThemeProtocol{
    var sansFont: String {get}
    var handwritingFont: String {get}
    var appAccentColor: UIColor {get}
    var appBackgroundColor: UIColor {get}
    var greenColor: UIColor {get}
    var redColor: UIColor {get}
    var grayColor: UIColor {get}
    var listBgBlueColor: UIColor {get}
    var listBgGreenColor: UIColor {get}
    var listBgPinkColor: UIColor {get}
    var listBgSandColor: UIColor {get}
    var listHeaderColor: UIColor {get}
}

