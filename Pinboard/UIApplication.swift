//
//  UIApplication.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 21/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import UIKit
import SafariServices

public extension UIApplication {
    
    class var appDetails: String {
        get {
            if let dict = Bundle.main.infoDictionary {
                if let shortVersion = dict["CFBundleShortVersionString"] as? String,
                    let mainVersion = dict["CFBundleVersion"] as? String,
                    let appName = dict["CFBundleName"] as? String {
                    return "You're using \(appName) Version: \(mainVersion) (Build \(shortVersion))."
                }
            }
            return ""
        }
    }
    class var appName: String {
        get {
            let mainBundle = Bundle.main
            let displayName = mainBundle.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
            let name = mainBundle.object(forInfoDictionaryKey: kCFBundleNameKey as String) as? String
            return displayName ?? name ?? "Unknown"
        }
    }
    
    class var versionString: String {
        get {
            let mainBundle = Bundle.main
            let buildVersionString = mainBundle.object(forInfoDictionaryKey: "CFBundleVersion") as? String
            let version = mainBundle.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
            return buildVersionString ?? version ?? "Unknown Version"
        }
    }
    class var shortVersionString: String {
        get {
            let mainBundle = Bundle.main
            let buildVersionString = mainBundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
            let version = mainBundle.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
            return buildVersionString ?? version ?? "Unknown Version"
        }
    }
        
    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        
        return viewController
    }
    
    class func isFirstLaunch(_ key: String) -> Bool {
        if !UserDefaults.standard.bool(forKey: key) {
            //NSUserDefaults.standardUserDefaults().setBool(true, forKey: key)
            //NSUserDefaults.standardUserDefaults().synchronize()
            return true
        }
        return false
    }

    
    class func tryURL(urls: [String]) {

        for url in urls {
            if UIApplication.shared.canOpenURL(url.makeURL()!) {
                
                if #available(iOS 9.0, *) {
                    let safariVC = SFSafariViewController(url: url.makeURL()!)
                    self.topViewController()?.present(safariVC, animated: true, completion: nil)
                } else {
                    UIApplication.shared.openURL(url.makeURL()!)
                }
                return
            }
        }
    }
    
    /*Example for use:
     
     UIApplication.tryURL([
                "fb://profile/116374146706", // App
                "www.facebook.com/116374146706" // Website if app fails
     ])*/
}

public extension UIWindow {
    
    public var visibleViewController: UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(self.rootViewController)
    }
    
    public static func getVisibleViewControllerFrom(_ vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(pvc)
            } else {
                return vc
            }
        }
    }
}

extension String {
    
    public var length: Int {
        return self.characters.count
    }
    
    public var str: NSString {
        return self as NSString
    }
    public var pathExtension: String {
        return str.pathExtension
    }
    public var lastPathComponent: String {
        return str.lastPathComponent
    }
    
    public func makeURL() -> URL? {
        
        let trimmed = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        guard let url = URL(string: trimmed ?? "") else {
            return nil
        }
        return url
    }
    
    public func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public func substring(_ from: Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: from))
    }
}
