//
//  Degrees+MathMethods.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 21/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import Foundation
import UIKit

extension Degrees {
    
    var toRadians: Radians {
        return self * CGFloat.pi / 180
    }
}
