//
//  Utilities.swift
//  A Lonely Star
//
//  Created by ADAMLANE on 3/16/20.
//  Copyright © 2020 WackyClown. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class Utilities
{
    static func setBackground(_ backgroundImage: SKSpriteNode, size: CGSize, xPos: CGFloat, yPos: CGFloat)
    {
        backgroundImage.size = size
        backgroundImage.position = CGPoint(x: xPos, y: yPos)
        backgroundImage.zPosition = 0
    }
    
    static func initText(_ label: SKLabelNode, message: String, fontName: String, fontSize: CGFloat, color: SKColor, xPos: CGFloat, yPos: CGFloat)
    {
        label.text = message
        label.fontName = fontName
        label.fontSize = fontSize
        label.fontColor = color
        label.position = CGPoint(x: xPos, y: yPos)
        label.zPosition = 10
    }
    
    static func transitionTo()
    {
    }
    
    
    static func styleTextField(_ textfield: UITextField)
    {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 145/255, green:0/255, blue: 41/255, alpha: 1).cgColor
        
        textfield.borderStyle = .none
        
        textfield.layer.addSublayer(bottomLine)
        
    }
    /*
    static func styleTextField2(_ textfield:UITextField)
    {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 145/255, green:0/255, blue: 41/255, alpha: 1).cgColor
        
        textfield.borderStyle = .none
        textfield.backgroundColor = .white
        textfield.layer.addSublayer(bottomLine)

    }
    
    static func styleFilledButton(_ button:UIButton)
    {
        button.backgroundColor = UIColor.init(red: 135/255, green:0/255, blue: 27/255, alpha: 1)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 18.0
        button.tintColor = UIColor.white
    }
    
    static func blackOutlineButton(_ button:UIButton)
    {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 18.0
        button.tintColor = UIColor.black
    }
    
    static func styleHollowButton(_ button: UIButton)
    {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 18.0
        button.tintColor = UIColor.white
    }
    
    static func styleMaroonButton(_ button: UIButton)
    {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.backgroundColor = UIColor.init(red: 136/255, green:0/255, blue: 27/255, alpha: 1).cgColor
        button.layer.cornerRadius = 18.0
        button.tintColor = UIColor.white
    }
    
    static func seePassword(_ button: UIButton)
    {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.backgroundColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10.0
        button.tintColor = UIColor.lightGray
    }
    
    static func styleColoredButton(_ button: UIButton, redVal: Float, greenVal: Float, blueVal: Float)
    {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.backgroundColor = UIColor.init(red: CGFloat(redVal/255),green: CGFloat(greenVal/255), blue: CGFloat(blueVal/255), alpha: 1).cgColor
        button.layer.cornerRadius = 18.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowWhiteBoarderButton(_ button: UIButton)
    {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 8
        button.tintColor = UIColor.white
        //button.titleLabel?.textAlignment = .center
        //button.contentHorizontalAlignment = UIControlContentHor
    }
    
    //23:51 Video
    static func isPasswordValid(_ password : String) -> Bool
    {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func refreshCompare()
    {
        
    }
 */
    
}
