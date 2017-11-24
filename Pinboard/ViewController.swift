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
    var jsonContentArray = [MainData]()
    
    //  MARK: - UIViewController Override Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        apiForPinboardData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        clickmeButton.setupViewWithPulsateEffect()
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
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        if let jsonDataViewController = segue.destination as? JsonDataViewerViewController {
            jsonDataViewController.jsonContentArray = self.jsonContentArray 
        }
     }
}

//  MARK:- SpinWheelControlDataSource Mehods.
extension ViewController: SpinWheelControlDataSource {
    
    //Specify the number of wedges in the spin wheel by returning a positive value that is greater than 1
    func numberOfWedgesInSpinWheel(spinWheel: SpinWheelControl) -> UInt {
        return UInt(jsonContentArray.count)
    }
    
    //Returns the SpinWheelWedge at the specified index of the SpinWheelControl
    func wedgeForSliceAtIndex(index: UInt) -> SpinWheelWedge {
        let indexs = Int(index)
        let wedge = SpinWheelWedge()
        if let url = URL(string: jsonContentArray[indexs].urls.thumb)  {
            wedge.imageView.loadImageWithUrl(url: url)
        }
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
    
    func apiForPinboardData() {
        APIClient.apiCallForPinboardData() { [weak self](response, data, mimeType) in
            if let jsonResonse = response as? [[String:Any]] {
                print(jsonResonse)
                var i = 0
                for item in jsonResonse {
                    self?.jsonContentArray.append(MainData(item))
                    i += 1
                    if i == 10 {
                        break
                    }
                }
                self?.confiureWheel()
            }
        }
    }
}
