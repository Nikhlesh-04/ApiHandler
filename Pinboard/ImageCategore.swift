//
//  ImageCategore.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 23/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import UIKit

class ImageCategore: NSObject {

    var id              = 0
    var title           = ""
    var photo_count     = 0
    var photos          = ""
    
    convenience init(_ attributes: [AnyHashable: Any]) {
        self.init()
        id              = Global.getInt(for: attributes["id"] ?? "0")
        photo_count     = Global.getInt(for: attributes["photo_count"] ?? "0")
        title = attributes["title"] as? String ?? ""
        
        if let links = attributes["links"] as? [String:Any] {
            photos = links["photos"] as? String ?? ""
        }
    }
}
