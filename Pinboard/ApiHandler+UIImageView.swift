//
//  ApiHandler+UIImageView.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 22/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import UIKit

extension UIImageView {
    
    @discardableResult public func loadImageWithUrl(url: URL ,with placeHolderImage:UIImage?=nil) -> URLSessionDataTask {
        
        let imageURL = url
        
        if (placeHolderImage != nil) {
            image = placeHolderImage
        }
        
        // retrieves image if already available in cache
        if let imageFromCache = Constants.kImageCache.object(forKey: url as AnyObject) as? UIImage {
            
            self.image = imageFromCache
            return URLSessionDataTask()
        }
        
        // image does not available in cache.. so retrieving it from url...
        let tasks = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    
                    if imageURL == url {
                        self.image = imageToCache
                    }
                    
                    Constants.kImageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
            })
        }
        tasks.resume()
        return tasks
    }
    
}
