//
//  FileManager.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 22/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import UIKit

extension FileManager {

    public func clearTempDirectory() {
        do {
            let tmpDirectory = try contentsOfDirectory(atPath: NSTemporaryDirectory())
            try tmpDirectory.forEach {[unowned self] file in
                let path = String.init(format: "%@%@", NSTemporaryDirectory(), file)
                try self.removeItem(atPath: path)
            }
        } catch {
            print(error)
        }
    }
    
    public func saveFileResourceToTemporaryDirectory(fileName: String, fileExtension: String, fileData:Data) -> URL?
    {
        let tempDirectoryURL = NSURL.fileURL(withPath: NSTemporaryDirectory(), isDirectory: true)
        
        // Create a destination URL.
        let targetURL = tempDirectoryURL.appendingPathComponent("\(fileName).\(fileExtension)")
        
        // Save the file.
        if !fileExitsAtTemporaryDirectory(fileName: fileName, fileExtension: fileExtension) {
            do {
                try fileData.write(to: targetURL)
                return targetURL
            } catch let error {
                print("Unable to copy file: \(error)")
            }
        } else {
            return targetURL
        }
        
        return nil
    }
    
    public func fileExitsAtTemporaryDirectory(fileName: String, fileExtension: String) -> Bool {
        let tempDirectoryURL = NSURL.fileURL(withPath: NSTemporaryDirectory(), isDirectory: true)
        
        // Create a destination URL.
        let targetURL = tempDirectoryURL.appendingPathComponent("\(fileName).\(fileExtension)")
        
        return FileManager.default.fileExists(atPath: targetURL.path)
    }
    
    public func deleteFileAtTemporaryDirectory(fileName: String, fileExtension: String) -> Bool {
        let tempDirectoryURL = NSURL.fileURL(withPath: NSTemporaryDirectory(), isDirectory: true)
        
        // Create a destination URL.
        let targetURL = tempDirectoryURL.appendingPathComponent("\(fileName).\(fileExtension)")
        
        do {
            try FileManager.default.removeItem(at: targetURL)
            return true
        } catch let error {
            print("Unable to copy file: \(error)")
            return false
        }
    }
}
