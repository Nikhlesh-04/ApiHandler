//
//  OtherDataViewerVC.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 22/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import UIKit

class OtherDataViewerViewController: UIViewController {

    //  MARK: - IBOutlet Declarations.
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var downloadZipButton: UIButton!
    @IBOutlet weak var zipFilelocationLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var dismissBarButton: UIBarButtonItem!
    
    //  MARK: - Variable Declarations.
    
    
    //  MARK: - UIViewController Override Methods.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupInitilView()
    }
    
    //  MARK: - setup Initial View Method.
    private func setupInitilView() {
        dismissBarButton.isEnabled = false
        
        apiForUpdateView()
    }
    
    //  MARK:- Buttons Actions Methods.
    @IBAction func didTapDownloadPdfButton(_ sender: Any) {
        self.apiForDownloadPdf()
    }
    
    @IBAction func didTapDownloadZipButton(_ sender: Any) {
        self.apiForDownloadZip()
    }
    
    @IBAction func didTapdismissWebViewBarButton() {
        webView.setupViewWithZoomOutEffect()
        dismissBarButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.webView.isHidden = true
        }
    }
    
    //  MARK: - setup WebView Method.
    func setupWebView(url:URL) {
        webView.isHidden = false
        webView.setupViewWithZoomInEffect()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.dismissBarButton.isEnabled = true
        }
        let requestObj = URLRequest(url: url)
        webView.loadRequest(requestObj)
    }

    // MARK: - Memory Warning handle Methode.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//  MARK:- API Calling Mehods.
extension OtherDataViewerViewController {
    
    func apiForUpdateView() {
        APIClient.apiCallForXmlData() { [weak self](response, data, mimeType) in
            if mimeType == ResponseType.text_XML.rawValue || mimeType == ResponseType.application_XML.rawValue {
                if (data != nil) {
                    if let xmlString = String(data: data!, encoding: String.Encoding.utf8) {
                        self?.textView.text = xmlString
                        print("xml as String: " + xmlString)
                        if let xmlDictionary = try? XMLReader.dictionary(forXMLData: data!) {
                            print(xmlDictionary)
                            let xmlModel = XmlDictionary(xmlDictionary)
                            self?.textView.text = (self?.textView.text ?? "") + "\n\n\nFrom: \(xmlModel.from)\nTo: \(xmlModel.to)\nMessage: \(xmlModel.message)\n"
                        }
                    }
                }
            }
        }
    }
    
    func apiForDownloadPdf() {
        APIClient.apiCallForPDFData() { [weak self](response, data, mimeType) in
            if mimeType == ResponseType.adobe_PDF.rawValue {
                if (data != nil) {
                    if let filePath = FileManager.default.saveFileResourceToTemporaryDirectory(fileName: "ar_ios", fileExtension: "pdf", fileData: data!) {
                        self?.setupWebView(url: filePath)
                    }
                }
            }
        }
    }
    
    func apiForDownloadZip() {
        APIClient.apiCallForZipData() { [weak self](response, data, mimeType) in
            if mimeType == ResponseType.zip.rawValue || mimeType == ResponseType.zip7.rawValue {
                if (data != nil) {
                    if let filePath = FileManager.default.saveFileResourceToTemporaryDirectory(fileName: "zip_ios", fileExtension: "zip", fileData: data!) {
                        self?.downloadZipButton.isHidden = true
                        self?.zipFilelocationLabel.isHidden = false
                        self?.zipFilelocationLabel.text = (self?.zipFilelocationLabel.text ?? "") + "\(filePath)"
                    }
                }
            }
        }
    }
}

