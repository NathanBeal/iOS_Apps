//
//  GameScene-PostGameScene.swift
//  A Lonely Star
//
//  Created by ADAMLANE on 5/13/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import GameplayKit

//var playerHealth = 100.0//sharing variable

class GSPGS: SKScene
{
    let player = SKSpriteNode(imageNamed: "LoneStar")
    let blackHole = SKSpriteNode(imageNamed: "Black Hole")
    
    override func didMove(to view: SKView)
    {
        //Background
        let background = SKSpriteNode(imageNamed: "backgroundOld")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        //A Lonely Star
        player.setScale(0.15)//allows to change size of ship
        player.position = CGPoint(x: self.size.width/2, y: self.size.height/4)
        player.zPosition = 10
        self.addChild(player)
        
        //Black Hole
        blackHole.setScale(2.8)
        blackHole.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        blackHole.zPosition = 5
        self.addChild(blackHole)
        
        for _ in 0...40//for loop 10->11
        {
            let randomX = CGFloat.random(in: 0 ... self.size.width)
            let randomY = CGFloat.random(in: self.size.height/3 ... 2*self.size.height/3)
            
            let backgroundStar = SKSpriteNode(imageNamed: "Star")
            backgroundStar.setScale(0.05)
            backgroundStar.position = CGPoint(x: randomX, y: randomY)
            backgroundStar.zPosition = 2
            self.addChild(backgroundStar)
            //print("\(randomX) + \(randomY)")
        }
        
        let step1 = SKAction.run(cinematicProgression)
        let step2 = SKAction.wait(forDuration: 3)
        let step3 = SKAction.run(changeScene)
        
        let sequence = SKAction.sequence([step1,step2,step3])
        self.run(sequence)
    }
    
    func cinematicProgression()
    {
        let moveStar = SKAction.moveTo(y: self.size.height/2, duration: 3)
        let shrinkStar = SKAction.resize(toWidth: 150, height: 150, duration: 3)
        let waitToShrink = SKAction.wait(forDuration: 0.5)
        let moveSequence = SKAction.sequence([moveStar])
        let shrinkSequence = SKAction.sequence([waitToShrink, shrinkStar])
        
        player.run(shrinkSequence)
        player.run(moveSequence)
    }
    
    func changeScene()
    {
        let sceneToMoveTo = PostGameScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 2.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
}
