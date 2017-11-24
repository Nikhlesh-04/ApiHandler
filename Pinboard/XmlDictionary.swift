//
//  XmlDictionary.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 24/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import UIKit

class XmlDictionary: NSObject {

    var from        = ""
    var message     = ""
    var to          = ""
    
    convenience init(_ attributes: [AnyHashable: Any]) {
        self.init()
        
        if let note = attributes["note"] as? [String: Any] {
            if let froms = note["from"] as?[String: Any] {
                from = froms["text"] as? String ?? ""
            }
            if let froms = note["message"] as?[String: Any] {
                message = froms["text"] as? String ?? ""
            }
            if let froms = note["to"] as?[String: Any] {
                to = froms["text"] as? String ?? ""
            }
        }
    }
}
