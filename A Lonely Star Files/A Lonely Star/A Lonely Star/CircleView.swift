//
//  CircleView.swift
//  A Lonely Star
//
//  Created by ADAMLANE on 3/16/20.
//  Copyright © 2020 WackyClown. All rights reserved.
//

import Foundation
import UIKit
class CircleView:UIView
{
    override func draw(_ rect: CGRect)
    {
        drawRingFittingInsideView()
    }

    internal func drawRingFittingInsideView()->()
    {
        let randomRed = CGFloat(arc4random_uniform(255)) / 255.0;
        let randomGreen = CGFloat(arc4random_uniform(255)) / 255.0;
        let randomBlue = CGFloat(arc4random_uniform(255)) / 255.0;
        
        let planetColor = UIColor.init(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1)
        
        let halfSize:CGFloat = min( bounds.size.width/2, bounds.size.height/2)
        let desiredLineWidth:CGFloat = 1    // your desired value

        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x:halfSize,y:halfSize),
            radius: CGFloat( halfSize - (desiredLineWidth/2) ),
            startAngle: CGFloat(0),
            endAngle:CGFloat(Double.pi * 2),
            clockwise: true)

        let shapeLayer = CAShapeLayer()
        
            shapeLayer.path = circlePath.cgPath

        shapeLayer.fillColor = planetColor.cgColor
            shapeLayer.strokeColor = UIColor.black.cgColor
            shapeLayer.lineWidth = desiredLineWidth

        layer.addSublayer(shapeLayer)
    }
}
