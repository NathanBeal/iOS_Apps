//
//  GameViewController.swift
//  Card Counting Co.
//
//  Created by ADAMLANE on 6/5/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

let defaults = UserDefaults()
var scaleModifier =  0.74442
class GameViewController: UIViewController
{
    let defaults = UserDefaults()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let scene = intro(size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
        
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        
        let defaults = UserDefaults()
        defaults.set(0, forKey: "Score")
        defaults.set("None", forKey: "Card1")
        defaults.set("None", forKey: "Card2")
        
        //Playing Cards
        defaults.set("None", forKey: "Flop1")
        defaults.set("None", forKey: "Flop2")
        defaults.set("None", forKey: "Flop3")
        defaults.set("None", forKey: "Turn")
        defaults.set("None", forKey: "River")
        
        defaults.set(false, forKey: "PickingCards")
        defaults.set(false, forKey: "flop1")
        defaults.set(false, forKey: "flop2")
        defaults.set(false, forKey: "flop3")
        defaults.set(false, forKey: "turn")
        defaults.set(false, forKey: "river")
        
        defaults.set(-1, forKey: "gameMode")
        defaults.set(-1, forKey: "tempGameMode")
        
        defaults.set(self.view.frame.width, forKey: "FrameWidth")
        defaults.set(self.view.frame.height, forKey: "FrameHeight")
        //print(self.view.frame.width)
        //print(self.view.frame.height)
        
        defaults.set(1.0, forKey: "numberOfPlayers")
        defaults.set(1.0, forKey: "tempNumberOfPlayers")
        
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
