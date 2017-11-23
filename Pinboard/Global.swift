//
//  Global.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 21/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import PKHUD

/// Just use //MARK: , //TODO: or //FIXME: instead of #pragma

open class Global : NSObject {
    
    open class func stringifyJson(_ value: Any, prettyPrinted: Bool = false) -> NSString {
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : .prettyPrinted
        if JSONSerialization.isValidJSONObject(value) {
            if let data = try? JSONSerialization.data(withJSONObject: value, options: options) {
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string
                }
            }
        }
        return ""
    }
    
    /***********************************************************************************************/
    //  MARK:- Globle Alert
    /***********************************************************************************************/
    open class func showAlert(withMessage message: String, sender: UIViewController? = UIApplication.topViewController(), buttonTitle: String? = "OK") {
        
        let alert = UIAlertController(title: Constants.kAppDisplayName, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler:nil))
        sender?.present(alert, animated: true, completion: nil)
    }
    
    public class func showAlert(withMessage message: String, sender: UIViewController? = UIApplication.topViewController(), setTwoButton: Bool? = false , setFirstButtonTitle: String? = "OK" , setSecondButtonTitle: String? = "NO" , handler: ((UIAlertAction) -> Void)?) {
        
        let alert = UIAlertController(title: Constants.kAppDisplayName, message: message, preferredStyle: .alert)
        
        if (setTwoButton == true) {
            alert.addAction(UIAlertAction(title: setSecondButtonTitle, style: .default, handler:nil))
        }
        alert.addAction(UIAlertAction(title: setFirstButtonTitle, style: .default, handler:{ (action) in
            handler!(action)
        }))
        sender?.present(alert, animated: true, completion: nil)
    }
    
    /*************************************************************/
    //  MARK:- Setup HUD Property for entire App
    /*************************************************************/
    public class func setUpPKProgressHUDProperty() {
        PKHUD.sharedHUD.dimsBackground = true
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
    }
    
    /*************************************************************/
    //MARK:- show/hide Global ProgressHUD
    /*************************************************************/
    
    @discardableResult open class func showLoadingSpinner(sender: UIView? = UIApplication.topViewController()?.view) {
        DispatchQueue.main.async {
            HUD.show(.progress)
        }
    }
    
    open class func dismissLoadingSpinner() {
        DispatchQueue.main.async {
            PKHUD.sharedHUD.hide()
        }
    }
    
    /*************************************************************/
    //  MARK:- NSURL From String
    /*************************************************************/
    open class func NSURLFromString(_ aURLString:String!) -> URL {
        var returnValue:URL!;
        if let url = aURLString {
            let trimmedURLString:String! = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            returnValue = URL(string:trimmedURLString)
        }
        return returnValue;
    }
    
    /*************************************************************/
    //  MARK:- Make a Phone call
    /*************************************************************/
    open class func makeCall(for number: String) {
        //number.digits
        guard let url = URL(string:"tel://\(number.trim())"), UIApplication.shared.canOpenURL(url) else {
            return
        }
        
        if #available(iOS 10.0, *){
            UIApplication.shared.open(url, completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    /*************************************************************/
    //  MARK:- Get NSDate From String and convert formate accordingly
    /*************************************************************/
    open class func getNSDateFromString(_ theDate:String, formate:String, convertFormate:String) -> String {
        
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        let date = dateFormatter.date(from: theDate)
        dateFormatter.dateFormat = convertFormate
        let newDateString = dateFormatter.string(from: date!)
        
        return Global.getVal(newDateString as AnyObject!) as! String
    }
    
    /*************************************************************/
    //  MARK:- Open Url From String
    /*************************************************************/
    
    open class func openUrlFromString(_ urlString:String!) {
        
        if let targetURL = URL(string: "http://\(urlString)") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(targetURL, options: [:], completionHandler: { (success) in
                })
            } else {
                _ = UIApplication.shared.openURL(targetURL)
            }
        }
    }

    
    open class func openMap(for coordinates: CLLocationCoordinate2D) {
        
        let regionDistance:CLLocationDistance = 10000

        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.openInMaps(launchOptions: options)
    }

    open class func openGoogleMap(forDirection direction: Bool, of coordinates: CLLocationCoordinate2D) {
        
        let appScheme = URL(string: "comgooglemaps://")!
        let urlScheme = URL(string: "http://maps.google.com/")!
        var scheme: URL!
        var schemeOpenURL = ""
        
        if UIApplication.shared.canOpenURL(appScheme) {
            scheme = appScheme
        } else if UIApplication.shared.canOpenURL(urlScheme) {
            scheme = urlScheme
        } else {
            print("Can't use \(appScheme) on this device.")
            print("Can't use \(urlScheme) on this device.")
            return
        }
        
        if direction {
            schemeOpenURL = "\(scheme!)?saddr=&daddr=\(coordinates.latitude),\(coordinates.longitude)&directionsmode=driving"
        } else {
            schemeOpenURL = String(format: "\(scheme!)?q=%f,%f&center=%f,%f&zoom=14",coordinates.latitude, coordinates.longitude, coordinates.latitude, coordinates.longitude)
        }
        
        guard let directionsURL = URL(string: schemeOpenURL) else {
            print("Can't open \(schemeOpenURL) URL.")
            return
        }
        if #available(iOS 10.0, *){
            UIApplication.shared.open(directionsURL, completionHandler: nil)
        } else {
            UIApplication.shared.openURL(directionsURL)
        }
    }
    
    /*************************************************************/
    //  MARK:- App Set UserDefaults Values
    /*************************************************************/
    open class func setAppUserDefaultsValues(_ value:AnyObject, key:String) {
        Constants.kUserDefaults.set(value, forKey: key)
        Constants.kUserDefaults.synchronize()
    }
    
    /*************************************************************/
    //  MARK:- Get App UserDefaults Values
    /*************************************************************/
    open class func getAppUserDefaults(_ key:String) -> String {
        Constants.kUserDefaults.synchronize()
        return getVal(Constants.kUserDefaults.object(forKey: key) as AnyObject!) as! String
    }
    
    /*************************************************************/
    //  MARK:- Clear All UserDefaults Values
    /*************************************************************/
    open class func clearAllAppUserDefaults() {
        
        /*
        for key in Constants.kUserDefaults.dictionaryRepresentation().keys {
            if !(key == "iappToken" || key == "isShare" || key == "isShareEmail" || key == "pinButtonPressed") {
                Constants.kUserDefaults.removeObject(forKey: key)
            }
        }
        
        Constants.kUserDefaults.synchronize()
         */
    }
    
    /*************************************************************/
    //  MARK:- Print All User Defaults Values
    /*************************************************************/
    open class func printAppAllUserDefaults() {
        
        Constants.kUserDefaults.synchronize()
        for elem in Constants.kUserDefaults.dictionaryRepresentation() {
            printDebug("------------------------------")
            printDebug("User defaults value::- [\(elem)]")
        }
    }
    
    /*************************************************************/
    //  MARK:- App NSNull or nil clear
    /*************************************************************/
    open class func getVal(_ param:AnyObject!) -> AnyObject {
        
        //printDebug("getVal = \(param)")
        
        if param == nil {
            return "" as AnyObject
        }
        else if param is NSNull {
            return "" as AnyObject
        }
            /*else if param is NSNumber {
             return "\(param)"
             }*/
        else {
            return param
        }
    }
    
    //  MARK:- Get Integer Value
    open class func getDouble(for value: Any) -> Double {
        
        if let val = value as? Double {
            return val
        } else if let val = value as? String {
            return Double(val) ?? 0
        } else if let val = value as? Int {
            return Double(val)
        } else {
            return value as? Double ?? 0.0
        }
    }
    
    open class func getInt(for value: Any) -> Int {
        
        if let val = value as? Int {
            return val
        } else if let val = value as? String {
            return Int(val) ?? 0
        } else if let val = value as? Bool {
            return Int(NSNumber(value: val)) 
        } else {
            return value as? Int ?? 0
        }
    }
    
    /*************************************************************/
    //  MARK:- Dictionary Removing Nulls or nil Values
    /*************************************************************/
    
    open class func dictionaryRemovingNulls( aDictionary param:NSDictionary) -> NSMutableDictionary{
        let rawData:NSDictionary = param as NSDictionary
        let mutableRawData:NSMutableDictionary = NSMutableDictionary(dictionary: rawData)
        for key in rawData.allKeys(for: NSNull()) {
            mutableRawData.setValue("", forKey: key as! String)
        }
        return mutableRawData
    }
    /*************************************************************/
    //  MARK:- Dictionary Change NSNumber to String
    /*************************************************************/
    
    open class func stringifyDictionary(aDictionary param:NSDictionary) -> NSMutableDictionary {
        
        let rawData:NSDictionary = dictionaryRemovingNulls(aDictionary: param)
        let mutableRawData:NSMutableDictionary = NSMutableDictionary(dictionary: rawData)
        for key in rawData.allKeys {
            let value: AnyObject? = rawData.value(forKey: key as! String) as AnyObject?
            if (value!.isKind(of: NSNumber.self)) {
                let numberValue:NSNumber = rawData.value(forKey: key as! String) as! NSNumber
                mutableRawData.setValue(numberValue.stringValue, forKey: key as! String)
            }
        }
        return mutableRawData
    }
    
    /*************************************************************/
    //  MARK:- Get Number Of Lines For String
    /*************************************************************/
    
    open class func numberOfLinesForString(_ label: UILabel) -> Int {
        var lineCount = 0;
        let textSize = CGSize(width: label.frame.size.width, height: CGFloat(Float.infinity));
        let rHeight = lroundf(Float(label.sizeThatFits(textSize).height))
        let charSize = lroundf(Float(label.font.lineHeight));
        lineCount = rHeight/charSize
        printDebug("No of lines \(lineCount)")
        
        return lineCount
    }
    
    open class func getTextHeightForString(_ string: String, font: UIFont, width: CGFloat, isHtmlText : Bool? = false) -> CGFloat {
        
        var height : CGFloat = 0.0
        var detailTitle : String = ""
        
        if string.length > 0 {
            detailTitle = string
        }
        
        if (detailTitle.length > 0 ) {
            if isHtmlText == true {
                
                let attrStr  = try! NSAttributedString(
                    data: "\(detailTitle)".data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                    options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                    documentAttributes:nil)
                let constrainedSize: CGSize = CGSize(width: CGFloat(width), height: CGFloat.greatestFiniteMagnitude)
                let requiredHeight: CGRect = attrStr.boundingRect(with: constrainedSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
                height += requiredHeight.size.height
                
            } else {
                
                var myMutableString = NSMutableAttributedString()
                //Initialize the mutable string
                myMutableString = NSMutableAttributedString(
                    string: detailTitle,
                    attributes: [NSFontAttributeName: font])
                let constrainedSize: CGSize = CGSize(width: CGFloat(width), height: CGFloat.greatestFiniteMagnitude)
                let requiredHeight: CGRect = myMutableString.boundingRect(with: constrainedSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
                height += requiredHeight.size.height
            }
            
        }
        return height
    }
    
    open class func setButtonEdgeInsets(_ button: UIButton) {
        
        // raise the image and push it right to center it
        button.imageEdgeInsets = UIEdgeInsetsMake(-((button.frame.size.height) - (button.imageView?.frame.size.height)! + 5.0 ), 0.0, 0.0,  -(button.titleLabel?.frame.size.width)!);
        
        // lower the text and push it left to center it
        button.titleEdgeInsets = UIEdgeInsetsMake(0.0, -(button.imageView?.frame.size.width)!, -((button.frame.size.height) - (button.titleLabel?.frame.size.height)!),0.0);
    }
}

//MARK:- Location Services
/************************************************************************************/

extension Global {
    
    public class func checkLocationServices() -> CLAuthorizationStatus {
        
        switch CLLocationManager.authorizationStatus() {
            
        case .notDetermined:
            triggerLocationServices() // User has not yet made a choice with regards to this application
        case .restricted, .denied:
            locationDisableAlert(UIApplication.topViewController()!)
        case .authorizedWhenInUse, .authorizedAlways:
            break
        }
        
        return CLLocationManager.authorizationStatus()
    }
    
    private class func triggerLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            if Constants.kLocationManager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)) {
                Constants.kLocationManager.requestWhenInUseAuthorization()
            }
        }
    }
    
    public class func locationDisableAlert(_ sender: UIViewController? = UIApplication.topViewController()) {
        
        let message = "In order to use, go to your Settings\nApp > Privacy > Location Services"
        let alertController = UIAlertController(title: "Location is Disabled", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Not Now", style: .cancel, handler:nil))
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (action) in
            let settingUrl = URL(string: UIApplicationOpenSettingsURLString)
            if #available(iOS 10, *) {
                UIApplication.shared.open(settingUrl!, options: [:], completionHandler: { (success) in
                })
            } else {
                _ = UIApplication.shared.openURL(settingUrl!)
            }
        }
        alertController.addAction(settingsAction)
        sender!.present(alertController, animated: true, completion: nil)
    }
}

//MARK:- Notification Disable Alert
/************************************************************************************/

extension Global {
    
    public class func checkNotificationServices() {
        // Elsewhere...
        
        if !UIDevice.isSimulator {
            // Do one thing
            if !UIApplication.shared.isRegisteredForRemoteNotifications {
                Global.notificationDisableAlert(UIApplication.topViewController()!)
            }
        }
    }
    fileprivate class func notificationDisableAlert(_ sender: UIViewController? = UIApplication.topViewController()) {
        
        let message = "Please unable services to use real time information of your request,\ngo to your Settings\nApp > Notification."
        let alertController = UIAlertController(title: "Notification services are disabled", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Not Now", style: .cancel, handler:nil))
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (action) in
            let settingUrl = URL(string: UIApplicationOpenSettingsURLString)
            if #available(iOS 10, *) {
                UIApplication.shared.open(settingUrl!, options: [:], completionHandler: { (success) in
                })
            } else {
                _ = UIApplication.shared.openURL(settingUrl!)
            }
        }
        alertController.addAction(settingsAction)
        sender!.present(alertController, animated: true, completion: nil)
    }
    
    public class func setBorder(_ view:UIView, color:UIColor, width:CGFloat? = 1.0) {
        
        view.layer.borderWidth = width!
        view.layer.borderColor = color.cgColor
        view.layer.masksToBounds = true
    }
    
    public class func textfieldPaddingview(_ txtfield:UITextField, space:CGFloat) {
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: space, height: txtfield.frame.height))
        txtfield.leftView = paddingView
        txtfield.leftViewMode = UITextFieldViewMode.always
    }
}

//MARK:- Begin Refreshing Manually
/************************************************************************************/
extension UIRefreshControl {
    
    func beginRefreshingManually() {
        if let scrollView = superview as? UIScrollView , self.isRefreshing == false {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y - self.frame.size.height), animated: true)
        }
        self.beginRefreshing()
    }
    
    func endRefreshingManually() {
        if let scrollView = superview as? UIScrollView {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y + self.frame.size.height), animated: true)
        }
        self.endRefreshing()
    }
}
