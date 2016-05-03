//
//  GradientView.swift
//  SwiftDemo
//
//  Created by Himanshu H. Padia on 17/03/16.
//  Copyright © 2016 digicorp. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    var gradient: CAGradientLayer!
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupGradient()
        setViewColor()
    }
    
    func setupGradient () {
        let darkOp: UIColor = getRandomColor()
        let lightOp: UIColor = getRandomColor()
        // Create the gradient
        self.gradient = CAGradientLayer()
        // Set colors
        gradient.colors = [(lightOp.CGColor as AnyObject), (darkOp.CGColor as AnyObject)]
        // Set bounds
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, atIndex: 0)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupGradient()
        setViewColor()
    }
    
    func getRandomColor() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    func setViewColor () {
        // Create the colors
        let darkOp: UIColor = getRandomColor()
        let lightOp: UIColor = getRandomColor()
        
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = self.gradient.colors
        animation.toValue = [(lightOp.CGColor as AnyObject), (darkOp.CGColor as AnyObject)]
        animation.duration = 5.00
        animation.removedOnCompletion = false
        //        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionLinear)
        animation.delegate = self
        animation.autoreverses = true
        // Add the animation to our layer
        self.gradient.addAnimation(animation, forKey: "animateGradient")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        setViewColor();
    }

}
