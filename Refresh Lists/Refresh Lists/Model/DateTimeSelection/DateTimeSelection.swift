//
//  DateTimeSelection.swift
//  Refresh Lists
//
//  Created by Ganesh H on 09/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation

struct DateTimeSelection {
    
    var hours: [Int64]?
    var days: [Int64]?
    var dates: [Int64]?
    var months: [Int64]?
    
    init(hours: [Int64], days: [Int64], dates: [Int64], months: [Int64]){
        self.hours = hours
        self.days = days
        self.dates = dates
        self.months = months
    }
    
}
