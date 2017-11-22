//
//  UIView+Animation.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 22/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import UIKit

extension UIView {
    
    func setupViewWithWaterRippleEffect() {
        let animation = CATransition()
        //animation.delegate = self.superview
        animation.duration = 5.0
        animation.timingFunction = CAMediaTimingFunction(name : kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = "rippleEffect"
        self.layer.add(animation, forKey: nil)
    }
    
    func setupViewWithPulsateEffect() {
        if #available(iOS 9.0, *) {
            let pulse = CASpringAnimation(keyPath: "transform.scale")
            pulse.duration = 0.6
            pulse.fromValue = 0.95
            pulse.toValue = 1.0
            pulse.autoreverses = true
            pulse.repeatCount = .infinity
            pulse.initialVelocity = 0.5
            pulse.damping = 1.0
            layer.add(pulse, forKey: "pulse")
        }
    }
    
    func setupViewWithFlashEffect() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        layer.add(flash, forKey: nil)
    }
    
    func setupViewWithShakeEffect() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        shake.fromValue = fromValue
        shake.toValue = toValue
        layer.add(shake, forKey: "position")
    }
    
    func setupViewWithZoomInEffect() {
        self.transform = CGAffineTransform.identity.scaledBy(x: 0.001, y: 0.001)
        UIView.animate(withDuration: 1.0, animations: {() -> Void in
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion:nil)
    }
    
    func setupViewWithZoomOutEffect() {
        UIView.animate(withDuration: 1.0, animations: {() -> Void in
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }, completion: {(_ finished: Bool) -> Void in
            self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        })
    }
}
