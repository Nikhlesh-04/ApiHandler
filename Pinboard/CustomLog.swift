//
//  CustomLog.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 21/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import Foundation

// Be sure to set the "DEBUG" symbol.
// Set it in the "Swift Compiler - Custom Flags" section, "Other Swift Flags" line. You add the DEBUG symbol with the -D DEBUG entry.


func printDebug(withDetails items: Any..., file: String = #file, line: Int = #line, function: String = #function) {
    
    #if DEBUG
        
        let time = "\n_______________________ DEBUG _______________________\n\(Date.today())"
        let filename = "\nFile Name: \(file.lastPathComponent)"
        let onMethod = "\nMethod Name: \(function)"
        let ofLine = "\nLine: \(line)\n_____________________________________________________\n"
        let last = "\n*****************************************************"
        
        print(time, filename, onMethod, ofLine, items, last)
        
    #else
        
    #endif
    
}


func printDebug(_ items: Any...) {
    
    #if DEBUG
        print(items)
    #else
        
    #endif
    
}
