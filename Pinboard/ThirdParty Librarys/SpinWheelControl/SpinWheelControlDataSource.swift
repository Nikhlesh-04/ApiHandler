//
//  SpinWheelControlDataSource.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 21/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import Foundation

@objc public protocol SpinWheelControlDataSource : NSObjectProtocol {
    
    //Return the number of wedges in the specified SpinWheelControl.
    @objc func numberOfWedgesInSpinWheel(spinWheel: SpinWheelControl) -> UInt
    
    //Returns the SpinWheelWedge at the specified index of the SpinWheelControl
    @objc func wedgeForSliceAtIndex(index: UInt) -> SpinWheelWedge
}
