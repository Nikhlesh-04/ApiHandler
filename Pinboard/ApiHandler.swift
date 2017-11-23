//
//  ApiH.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 22/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import UIKit

public enum HTTPMethod: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

//  TODO:- You can add more possible resonse type as response mime type.
public enum ResponseType: String {
    case atom_XML               = "application/atom+xml"
    case form_URLENCODED        = "application/x-www-form-urlencoded"
    case application_JSON       = "application/json"
    case octet_STREAM           = "application/octet-stream"
    case svg_XML                = "application/svg+xml"
    case xtml_XML               = "application/xhtml+xml"
    case application_XML        = "application/xml"
    case wildcard               = "*"
    case form_DATA              = "multipart/form-data"
    case test_HTML              = "text/html"
    case text_PLAIN             = "text/plain"
    case text_XML               = "text/xml"
    case wildcard_TYPE          = "*/*"
    case icon_IMAGE             = "image/x-icon"
    case jpeg_IMAGE             = "image/jpeg"
    case png_IMAGE              = "image/png"
    case xpng_IMAGE             = "image/x-png"
    case tiff_IMAGE             = "image/tiff"
    case adobe_PDF              = "application/pdf"
    case zip7                   = "application/x-7z-compressed"
    case zip                    = "application/zip"
    
    /*
    func mediaType() -> MediaType {
        switch self {
        case .atom_XML, .svg_XML, .xtml_XML, .application_XML, .text_XML:
            return MediaType.xml
        case .application_JSON, .text_PLAIN:
            return MediaType.json
        case .test_HTML:
            return MediaType.html
        case .icon_IMAGE, .jpeg_IMAGE, .png_IMAGE, .xpng_IMAGE, .tiff_IMAGE:
            return MediaType.image
        case .adobe_PDF:
            return MediaType.pdf
        case .zip, .zip7:
            return MediaType.zip
        default:
            return MediaType.unknown//String(self.rawValue)
        }
    }
     */
}

/*
//  TODO:- Update MediaType according to ResponseType.
public enum MediaType: String {
    //case text            = "planeText"
    case json            = "Json"
    case xml             = "xml"
    case html            = "html"
    case image           = "image"
    case pdf             = "pdf"
    case zip             = "zip"
    case unknown         = "unknown"
}
*/

class ApiHandler: NSObject {

    @discardableResult class func request(url: API, methode:HTTPMethod ,parameters: [String: AnyObject]? , header: [String: String]?, completionHandler:@escaping (_ response: AnyObject?, _ data:Data?, _ mimeType:String?) -> Void, failed:@escaping(_ error: Error) -> Void) -> URLSessionTask  {
        
        // create post request
        guard  let url = URL(string: url.rawValue) else {
            return URLSessionTask()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = methode.rawValue
        
        //  cache data reloading
        request.cachePolicy = .useProtocolCachePolicy
        
        // insert json data to the request (Parameters)
        if (parameters != nil) {
            // prepare json data
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters!)
            request.httpBody = jsonData
        }
        
        // set api call timeout time
        //request.timeoutInterval = 60.0
        
        if (header != nil) {
            for (key, value) in header! {
                request.setValue( value, forHTTPHeaderField: key)
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                // Retun complition handler in main thread because if UI is update in response handler.
                DispatchQueue.main.async {
                    failed(error!)
                }
                return
            }
            
            //Try Data as JSON
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print("Response:--- \(responseJSON)---")
                // Retun complition handler in main thread because if UI is update in response handler.
                DispatchQueue.main.async {
                    completionHandler(responseJSON as AnyObject?,nil,response?.mimeType)
                }
                return
            } else if let responseJSON = responseJSON as? [Any] {
                print("Response:--- \(responseJSON)---")
                // Retun complition handler in main thread because if UI is update in response handler.
                DispatchQueue.main.async {
                    completionHandler(responseJSON as AnyObject?,nil,response?.mimeType)
                }
                return
            }
            
            // here you can change xml to json dictionary and return to hadler or else at api response change xml to json dictionary.
            /*
            //Try Data as XML
            if response?.mimeType == ResponseType.text_XML.rawValue || response?.mimeType == ResponseType.application_XML.rawValue {
                // convert xml to string for debug.
                #if (arch(i386) || arch(x86_64)) && (os(iOS) || os(watchOS) || os(tvOS))
                    let xmlString = String(data: data, encoding: String.Encoding.utf8)
                    print("xml as String: " + xmlString!)
                #endif
                
                do {
                    let xmlDictionary = try  XMLReader.dictionary(forXMLData: data)
                    //print("Response:--- \(xmlDictionary)---")
                    DispatchQueue.main.async {
                        completionHandler(xmlDictionary as AnyObject?, nil, response?.mimeType)
                    }
                    return
                } catch let error {
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        failed(error)
                    }
                    return
                }
                
                //let parser = XMLParser(data: data)
                //parser.delegate = self
                //parser.parse()
            } else {

                //Try Data as Raw.
                DispatchQueue.main.async {
                    completionHandler(nil,data,response?.mimeType)
                }
                return
            }
            */
            
            //Try Data as Raw.
            
            // Retun complition handler in main thread because if UI is update in response handler.
            DispatchQueue.main.async {
                completionHandler(nil,data,response?.mimeType)
            }
            return
        }
        
        task.resume()
        return task
    }
    
}
