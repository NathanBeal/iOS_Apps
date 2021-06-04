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
    let ALonelyStar = SKSpriteNode(imageNamed: "LoneStar")
    override func didMove(to view: SKView)//runs as soon as started
    {
        let background = SKSpriteNode(imageNamed: "backgroundOld")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/3)
        background.zPosition = 0
        self.addChild(background)
        
        let gameLabel = SKLabelNode()
        gameLabel.text =  "A LONELY STAR"
        gameLabel.fontName = "Hoefler Text"
        gameLabel.fontSize = 90
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
        
        
        
        ALonelyStar.setScale(0.17)//allows to change size of ship
        if   (defaults.integer(forKey: "Score") < 1)
        {
            ALonelyStar.position = CGPoint(x: self.size.width/2, y: self.size.height/2.0)
            ALonelyStar.zPosition = 10
             self.addChild(ALonelyStar)
        }else{
            spawnStar()
        }
        
        let rotateStar = SKAction.rotate(byAngle: 1.5, duration: 1)
        let rotateForever = SKAction.repeatForever(rotateStar)
        ALonelyStar.run(rotateForever)
        
       //Add Background Stars
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
        
        defaults.set(Variables.starMaxHealth, forKey: "SHMax")
        defaults.set(Variables.bhMaxHealth, forKey: "BHMax")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let moveStar = SKAction.moveTo(x: self.size.width + ALonelyStar.size.width, duration: 1.2)
        let rotateStar = SKAction.rotate(byAngle: 8, duration: 1.2)
        ALonelyStar.run(moveStar)
        ALonelyStar.run(rotateStar)
        
        
        let wait = SKAction.wait(forDuration: 1.2)
        let changeScene = SKAction.run(toGameScene)
        let endSequence = SKAction.sequence([wait, changeScene])
        self.run(endSequence)
    }
    
    func spawnStar()
    {
        ALonelyStar.position = CGPoint(x: 0-ALonelyStar.size.width, y: self.size.height/2.0)
        ALonelyStar.zPosition = 10
        self.addChild(ALonelyStar)
        let moveStar = SKAction.moveTo(x: self.size.width/2, duration: 1.4)
        let rotateStar = SKAction.rotate(byAngle: 4, duration: 1.4)//in radians
        ALonelyStar.run(rotateStar)
        ALonelyStar.run(moveStar)
        
    }
    
    func toGameScene()
    {
        let sceneToMoveTo = GameScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  2.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
}


