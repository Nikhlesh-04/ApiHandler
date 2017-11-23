//
//  Constants.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 21/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import UIKit
import CoreLocation

public struct Constants {
    
    static let kAppDelegate         = UIApplication.shared.delegate as! AppDelegate
    static let kUserDefaults        = UserDefaults.standard

    static let kScreenWidth         = UIScreen.main.bounds.width
    static let kScreenHeight        = UIScreen.main.bounds.height
    
    static let kAppDisplayName      = UIApplication.appName
    static let kAppVersion          = UIApplication.shortVersionString
    
    static let kLocationManager     = CLLocationManager()
    static let kCalendar            = Calendar.current

    static let kAPIVersion          = "1.0"
    static let kAuthAPIKey          = ""
    static let kDeviceType          = "ios"
    static let kImageCache           = NSCache<AnyObject, AnyObject>()
    
    
    static let kHeaders = ["authKey": kAuthAPIKey,
                          "deviceType": kDeviceType,
                          "appVersion": kAppVersion,
                          "apiVersion": kAPIVersion]
                          //"Deviceid": kAppDelegate.deviceID]
    
    typealias CompletionHandler = (_ result: Any?, _ error: Error?) -> Void
}


public struct Storyboard {
    
    static let kMainStoryboard      = UIStoryboard(name: "Main", bundle: nil)
}

public struct AssetsImages {
    
    static let kLogoBig             = UIImage(named: "logo_big")
    static let kLogoSmall           = UIImage(named: "logo_small")
    static let kLogo                = UIImage(named: "logo")
    static let kAppIconSmall        = UIImage(named: "AppIcon29x29")
    static let kDefaultPlaceHolder  = #imageLiteral(resourceName: "default-placeholder")
}

public struct Identifiers {
    
    static let kJsonTableCell          = "JsonCell"
}

extension Notification.Name {
    /// Used as a namespace for all `Notification` user info dictionary keys.
    public struct Key {
        // Definition:
        public static let TextFieldValueChange = Notification.Name(NotificationKey.kTextFieldValueChange)
    }
}

public struct NotificationKey {
    
    static let kTextFieldValueChange = "org.app.notification.key.textFieldValueChange"
}

public struct ConstantsErrors {

    static let kNoInternetConnection = NSError(domain: Constants.kAppDisplayName, code: NSURLErrorNotConnectedToInternet, userInfo: [NSLocalizedDescriptionKey: ConstantsMessages.kConnectionFailed])
    
    static let kSomethingWrong = NSError(domain: Constants.kAppDisplayName, code: 1000002, userInfo: [NSLocalizedDescriptionKey : "Something went wrong\nPlease try again soon!."])

}

public struct ConstantsMessages {
    
    static let kConnectionFailed    = "looks like there is some problem in your internet connection,\nPlease try again after some time."
    static let kNetworkFailure      = "looks like there is some network error,\nPlease try after some time."
    static let kSomethingWrong      = "Something went wrong\nPlease try again soon!"
}

