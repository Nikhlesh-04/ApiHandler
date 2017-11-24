//
//  PinboardTests.swift
//  PinboardTests
//
//  Created by Nikhlesh bagdiya on 21/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import XCTest
@testable import Pinboard

class PinboardTests: XCTestCase {
    
    var viewController:ViewController!
    var otherViewController:OtherDataViewerViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = ViewController()
        otherViewController = OtherDataViewerViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
        otherViewController = nil
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    // Asynchronous test: success fast, failure slow, JSON Response.
    func testValidJSONGetsHTTPStatusCode200() {
        // 1
        let promise = expectation(description: "Status code: 200")
        
        ApiHandler.request(url: API.json, methode: .get, parameters: nil, header: nil, completionHandler: { (response, data, mimeType) in
            
           if response != nil {
            // 2
                promise.fulfill()
                return
           }
            
             XCTFail("Error: Not JSON Response")
            
        }) { (error) in
            XCTFail("Error: \(error.localizedDescription)")
        }
        // when
        
        // 3
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // Asynchronous test: success fast, failure slow, XML Response.
    func testValidXMLGetsHTTPStatusCode200() {
        // 1
        let promise = expectation(description: "Status code: 200")
        
        ApiHandler.request(url: API.xml, methode: .get, parameters: nil, header: nil, completionHandler: { (response, data, mimeType) in
            
            if mimeType == ResponseType.text_XML.rawValue || mimeType == ResponseType.application_XML.rawValue {
                if (data != nil) {
                    // 2
                    promise.fulfill()
                    return
                }
            }
            
            XCTFail("Error: Not XML Response")
            
        }) { (error) in
            XCTFail("Error: \(error.localizedDescription)")
        }
        // when
        
        // 3
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // Asynchronous test: success fast, failure slow, Image by URl Response.
    func testValidImageLoadByUrlLGetsHTTPStatusCode200() {
        
        let promise = expectation(description: "load Image Success.")
        
        let imageView = UIImageView()
        imageView.loadImageWithUrl(url: URL.init(string: "http://www.webtechlearning.com/wp-content/uploads/2014/04/Best-Animation.jpg")!)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 20) {
            if imageView.image != nil {
                promise.fulfill()
            } else {
                XCTFail("Error: Not Image Response")
            }
        }
        // 3
        waitForExpectations(timeout: 20, handler: nil)
        
    }
    
    // Asynchronous test: success fast, failure slow, Data Response for PDF.
    func testValidDataForPDFGetHTTPStatusCode200() {
        let promise = expectation(description: "Status code: 200")
        
        ApiHandler.request(url: API.pdf, methode: .get, parameters: nil, header: nil, completionHandler: { (response, data, mimeType) in
            
            if mimeType == ResponseType.adobe_PDF.rawValue {
                if (data != nil) {
                    // 2
                    promise.fulfill()
                    return
                }
            }
            
            XCTFail("Error: Not PDF Response")
            
        }) { (error) in
            XCTFail("Error: \(error.localizedDescription)")
        }
        // when
        
        // 3
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            // self.viewController.apiForPinboardData()
            
            //self.otherViewController.apiForDownloadPdf()
        }
    }
    
}
