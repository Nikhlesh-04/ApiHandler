//
//  FilterItem.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 22/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import UIKit

class ImageUrl: NSObject {
    
    var raw         = ""
    var full        = ""
    var regular     = ""
    var small       = ""
    var thumb       = ""
    
    //  MARK: - Intializer
    convenience init(_ attributes: [AnyHashable: Any]) {
        self.init()
        
        raw = attributes["raw"] as? String ?? ""
        full = attributes["full"] as? String ?? ""
        regular = attributes["regular"] as? String ?? ""
        small = attributes["small"] as? String ?? ""
        thumb = attributes["thumb"] as? String ?? ""
    }
}

