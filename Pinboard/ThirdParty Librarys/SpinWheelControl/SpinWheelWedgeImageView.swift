//
//  SpinWheelWedgeImageView.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 21/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import UIKit

open class SpinWheelWedgeImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private func setDefaultValues(width:CGFloat) {
        self.image = AssetsImages.kDefaultPlaceHolder
        self.layer.masksToBounds = true
        self.layer.cornerRadius = width/2
    }
    
    public func configureWedgeImageView(index: UInt, width: CGFloat, position: CGPoint, radiansPerWedge: Radians) {
        self.frame = CGRect(x: 0, y: 0, width: width, height: width)
        self.layer.anchorPoint = CGPoint(x: 2.5 , y: 0.5)
        self.layer.position = position
        self.transform = CGAffineTransform(rotationAngle: radiansPerWedge * CGFloat(index) + CGFloat.pi + (radiansPerWedge / 2))
        
        setDefaultValues(width:width)
    }

}
