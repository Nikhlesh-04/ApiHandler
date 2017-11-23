//
//  ViewController.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 21/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //  MARK: - IBOutlet Declarations.
    @IBOutlet weak var clickmeButton: UIButton!

    //  MARK: - Variable Declarations.
    var spinWheelControl: SpinWheelControl!
    
    //  MARK: - UIViewController Override Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        confiureWheel()
        
        clickmeButton.setupViewWithPulsateEffect()
        
        apiForPinboardData()
    }
    
    //  MARK: - Configure Wheel Method.
    fileprivate func confiureWheel() {
        
        let width = self.view.frame.size.width - 40
        let frame = CGRect(x: 20, y: 80, width: width, height: width)
        
        spinWheelControl = SpinWheelControl(frame: frame)
        self.view.addSubview(spinWheelControl)
        
        // spinWheelControl.addTarget(self, action: #selector(spinWheelDidChangeValue), for: UIControlEvents.valueChanged)
        
        spinWheelControl.dataSource = self
        
        spinWheelControl.delegate = self
        
        spinWheelControl.reloadData()
    }

    // MARK: - Memory Warning handle Methode.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//  MARK:- SpinWheelControlDataSource Mehods.
extension ViewController: SpinWheelControlDataSource {
    
    //Specify the number of wedges in the spin wheel by returning a positive value that is greater than 1
    func numberOfWedgesInSpinWheel(spinWheel: SpinWheelControl) -> UInt {
        return 10
    }
    
    //Returns the SpinWheelWedge at the specified index of the SpinWheelControl
    func wedgeForSliceAtIndex(index: UInt) -> SpinWheelWedge {
        let wedge = SpinWheelWedge()
        return wedge
    }
}

//  MARK:- SpinWheelControlDelegate Mehods.
extension ViewController: SpinWheelControlDelegate {
    //Triggered when the spin wheel control has come to rest after spinning.
    func spinWheelDidEndDecelerating(spinWheel: SpinWheelControl) {
        
    }
    
    //Triggered at various intervals. The variable radians describes how many radians the spin wheel control has moved since the last time this method was called.
    func spinWheelDidRotateByRadians(radians: CGFloat) {
        
    }
}

//  MARK:- API Calling Mehods.
extension ViewController {
    
    public func apiForPinboardData() {
        Global.showLoadingSpinner(sender: self.view)
        ApiHandler.request(url: API.xml, methode: .get, parameters: nil, header: nil, completionHandler: { (response, data, mimeType) in
            if let jsonresonse = response as? [String:Any] {
                print(jsonresonse)
            }
            Global.dismissLoadingSpinner()
        }) { (error) in
            print(error.localizedDescription)
            Global.dismissLoadingSpinner()
        }
    }
}
