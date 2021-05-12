//
//  StringFunctions.swift
//  Refresh Lists
//
//  Created by Ganesh H on 14/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation


extension String {

    /// Truncates the string to the specified length number of characters and appends an optional trailing string if longer.
    /// - Parameters:
    ///   - length: Desired maximum lengths of a string
    ///   - trailing: A 'String' that will be appended after the truncation.
    func trunc(length: Int, trailing: String = "…") -> String {
        return (self.count > length) ? self.prefix(length) + trailing : self
    }
    
}
