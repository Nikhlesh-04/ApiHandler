//
//  User.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 23/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var id                      = ""
    var username                = ""
    var name                    = ""
    var profileImage_thumb      = ""
    var profileImage            = ""

    convenience init(_ attributes: [AnyHashable: Any]) {
        self.init()
        id = attributes["id"] as? String ?? ""
        username = attributes["username"] as? String ?? ""
        name = attributes["name"] as? String ?? ""
        
        if let userImages = attributes["profile_image"] as? [String:Any] {
            profileImage_thumb = userImages["small"] as? String ?? ""
            profileImage = userImages["large"] as? String ?? ""
        }
    }
}
