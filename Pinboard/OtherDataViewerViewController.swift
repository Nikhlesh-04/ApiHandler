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
    }
    
    //  MARK:- Buttons Actions Methods.
    @IBAction func didTapDownloadPdfButton(_ sender: Any) {
        setupWebView()
    }
    
    @IBAction func didTapDownloadZipButton(_ sender: Any) {
    }
    
    @IBAction func didTapdismissWebViewBarButton() {
        webView.setupViewWithZoomOutEffect()
        dismissBarButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.webView.isHidden = true
        }
    }
    
    //  MARK: - setup WebView Method.
    func setupWebView() {
        webView.isHidden = false
        webView.setupViewWithZoomInEffect()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.dismissBarButton.isEnabled = true
        }
        
        
        //  TODO:- update when api handler is complete.
        guard let url = URL (string: API.PDF.rawValue) else {
            return
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
