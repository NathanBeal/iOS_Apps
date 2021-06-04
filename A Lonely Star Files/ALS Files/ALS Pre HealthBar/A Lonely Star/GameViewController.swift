//
//  GameViewController.swift
//  A Lonely Star
//
//  Created by ADAMLANE on 5/9/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController
{
    let defaults = UserDefaults()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let scene = preGame(size: CGSize(width: 1536, height: 2048))
        
        if let view = self.view as! SKView?
        {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
                
            // Present the scene
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            
            //Extra Info
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        let defaults = UserDefaults()
        defaults.set(0, forKey: "Score")
        defaults.set(Variables.starMaxHealth, forKey: "SHMax")
        defaults.set(Variables.bhMaxHealth, forKey: "BHMax")
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
