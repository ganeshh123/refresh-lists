//
//  DateTimeSelection.swift
//  Refresh Lists
//
//  Created by Ganesh H on 09/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation

struct DateTimeSelectionModel: Codable {
    
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

/* Notes */

// Each array contains the selected allowed times for refresh or reminders.
// Values in the array can be translated into times and dates using the system
// below.

/* Hours */

// 0 - Every Hour
// 1 - 1 am
// ...
// 13 - 1pm
// ...
// 24 - 12am

/* Days */

// 0 - Every Day of the Week
// 1 - Mondays
// ...
// 7 - Sundays

/* Dates */

// 0 - Every Day of the Month
// 1 - 1st of the month
// ...
// 31 - 31st of the month

/* Months */

// 0 - Every Month
// 1 - January
// ...
// 12 - December
