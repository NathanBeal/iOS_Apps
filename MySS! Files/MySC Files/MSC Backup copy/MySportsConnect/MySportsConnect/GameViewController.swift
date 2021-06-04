//
//  GameViewController.swift
//  MySportsConnect
//
//  Created by ADAMLANE on 7/8/19.
//  Copyright © 2019 Nathan Beal Studios. All rights reserved.
//
import UIKit
import SpriteKit
import GameplayKit
import UserNotifications

let defaults = UserDefaults()
class GameViewController: UIViewController
{
    let defaults = UserDefaults()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let scene = IntroCard(size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
        defaults.set(self.view.frame.width, forKey: "FrameWidth")
        defaults.set(self.view.frame.height, forKey: "FrameHeight")
        
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        
        
        defaults.set("", forKey: "League")
        defaults.set("", forKey: "DivisionIdentifier")
        
        
        defaults.set("", forKey: "Sport")
        defaults.set("No", forKey: "WithinTeamPages")
        
        
        //print(self.view.frame.width)
        //print(self.view.frame.height)
        
        
        //iPhones 6, 6s, 7, 8
        if self.view.frame.width == 375.0
        {
            defaults.set(0.74442, forKey: "scaleMod")
        }
        
        if self.view.frame.width == 414
        {
            defaults.set(0.74442, forKey: "scaleMod")
        }
    }
    
    override var shouldAutorotate: Bool
    {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
}
