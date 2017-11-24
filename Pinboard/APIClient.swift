//
//  APICall.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 24/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import UIKit

public class APIClient: NSObject {

    class func apiCallForPinboardData(completionHandler:@escaping (_ response: AnyObject?, _ data:Data?, _ mimeType:String?) -> Void) {
        Global.showLoadingSpinner()
        ApiHandler.request(url: API.json, methode: .get, parameters: nil, header: nil, completionHandler: { (response, data, mimeType) in
            completionHandler(response, data, mimeType)
            Global.dismissLoadingSpinner()
        }) { (error) in
            print(error.localizedDescription)
            Global.dismissLoadingSpinner()
            Global.showAlert(withMessage: ConstantsMessages.kSomethingWrong)
        }
    }
    
    class func apiCallForXmlData(completionHandler:@escaping (_ response: AnyObject?, _ data:Data?, _ mimeType:String?) -> Void) {
        Global.showLoadingSpinner()
        ApiHandler.request(url: API.xml, methode: .get, parameters: nil, header: nil, completionHandler: { (response, data, mimeType) in
            completionHandler(response, data, mimeType)
            Global.dismissLoadingSpinner()
        }) { (error) in
            print(error.localizedDescription)
            Global.dismissLoadingSpinner()
            Global.showAlert(withMessage: ConstantsMessages.kSomethingWrong)
        }
    }
    
    class func apiCallForPDFData(completionHandler:@escaping (_ response: AnyObject?, _ data:Data?, _ mimeType:String?) -> Void) {
        Global.showLoadingSpinner()
        ApiHandler.request(url: API.pdf, methode: .get, parameters: nil, header: nil, completionHandler: { (response, data, mimeType) in
            completionHandler(response, data, mimeType)
            Global.dismissLoadingSpinner()
        }) { (error) in
            print(error.localizedDescription)
            Global.dismissLoadingSpinner()
            Global.showAlert(withMessage: ConstantsMessages.kSomethingWrong)
        }
    }
    
    class func apiCallForZipData(completionHandler:@escaping (_ response: AnyObject?, _ data:Data?, _ mimeType:String?) -> Void) {
        Global.showLoadingSpinner()
        ApiHandler.request(url: API.zip, methode: .get, parameters: nil, header: nil, completionHandler: { (response, data, mimeType) in
            completionHandler(response, data, mimeType)
            Global.dismissLoadingSpinner()
        }) { (error) in
            print(error.localizedDescription)
            Global.dismissLoadingSpinner()
            Global.showAlert(withMessage: ConstantsMessages.kSomethingWrong)
        }
    }
}
