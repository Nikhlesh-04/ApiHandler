//
//  Links.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 23/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import UIKit

class Links: NSObject {

    var self_link    = ""
    var html         = ""
    var download     = ""
    
    convenience init(_ attributes: [AnyHashable: Any]) {
        self.init()
        
        self_link = attributes["self"] as? String ?? ""
        html = attributes["html"] as? String ?? ""
        download = attributes["download"] as? String ?? ""
    }
}
