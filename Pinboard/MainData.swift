//
//  MainData.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 23/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import UIKit

class MainData: NSObject {
    
    var id              = ""
    var created_at      = ""
    var color           = UIColor.black
    var likes           = 0
    var user            = User()
    var urls            = ImageUrl()
    var categories      = [ImageCategore]()
    var links           = Links()
    
    //  MARK: - Intializer
    convenience init(_ attributes: [AnyHashable: Any]) {
        self.init()
        
        id           = attributes["id"] as? String ?? ""
        created_at   = attributes["created_at"] as? String ?? ""
        color        = UIColor(hex: attributes["color"] as? String ?? "#ffffff", alpha: 1)
        likes        = Global.getInt(for: attributes["likes"] ?? "0")
        urls         = ImageUrl(attributes["urls"] as? [String:Any] ?? [String:Any]())
        user         = User(attributes["user"] as? [String:Any] ?? [String:Any]())
        links        = Links(attributes["links"] as? [String:Any] ?? [String:Any]())
        
        if let categoris = attributes["categories"] as? [[String:Any]] {
            for items in categoris {
                let imagecate = ImageCategore(items)
                categories.append(imagecate)
            }
        }
    }

}
