//
//  preGame.swift
//  A Lonely Star
//
//  Created by ADAMLANE on 5/12/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit

class preGame: SKScene
{
    override func didMove(to view: SKView)//runs as soon as started
    {
        let background = SKSpriteNode(imageNamed: "backgroundOld")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let gameLabel = SKLabelNode()
        gameLabel.text =  "A LONELY STAR"
        gameLabel.fontSize = 100
        gameLabel.fontColor = SKColor.yellow
        gameLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/1.7)
        gameLabel.zPosition = 10
        self.addChild(gameLabel)
        
        
        let ttpLabel = SKLabelNode()//cool font
        ttpLabel.text = "Tap to Play"
        ttpLabel.fontSize = 50
        ttpLabel.fontColor = SKColor.white
        ttpLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2.8)
        ttpLabel.zPosition = 10
        
        let fadeInFadeOut = SKAction.sequence([SKAction.fadeIn(withDuration: 1.0),SKAction.fadeOut(withDuration: 1.0)])
        ttpLabel.run( SKAction.repeatForever(fadeInFadeOut))
        self.addChild(ttpLabel)
        
        
        let ALonelyStar = SKSpriteNode(imageNamed: "LoneStar")
        ALonelyStar.setScale(0.15)//allows to change size of ship
        ALonelyStar.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        ALonelyStar.zPosition = 10
        self.addChild(ALonelyStar)
        
       //Add Background Stars
        for i in 0...40//for loop 10->11
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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let sceneToMoveTo = GameScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.5)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition) 
    }
}
