//
//  SpinWheelControlDelegate.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 21/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol SpinWheelControlDelegate {
    
    //Triggered when the spin wheel has come to rest after spinning.
    @objc optional func spinWheelDidEndDecelerating(spinWheel: SpinWheelControl)
    
    //Triggered at various intervals. The variable radians describes how many radians the spin wheel control has moved since the last time this method was called.
    @objc optional func spinWheelDidRotateByRadians(radians: CGFloat)
}
