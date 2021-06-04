//
//  GameOverScene.swift
//  A Lonely Star
//
//  Created by ADAMLANE on 5/10/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene
{
    let noLabel = SKLabelNode()
    let yesLabel = SKLabelNode()
    
    var yesRect = CGRect() //set this up
    var noRect = CGRect()
    
    
    override func didMove(to view: SKView)//runs as soon as started
    {
        defaults.set(Variables.bhMaxHealth , forKey: "BHMax")
        defaults.set(Variables.starMaxHealth, forKey: "BHMax")
        
        //Background
        let background = SKSpriteNode(imageNamed: "gameOverBackground")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        
        let deaths = (Int)(defaults.integer(forKey: "Score"))
        
        
        let gameOverLabel = SKLabelNode()
        let yesLabel = SKLabelNode()
        let noLabel = SKLabelNode()
        
        gameOverLabel.fontName = "Courier New"
        yesLabel.fontName = "Hoefler Text"
        noLabel.fontName = "Hoefler Text"
        
        yesLabel.fontColor = SKColor.yellow
        noLabel.fontColor = SKColor.yellow
        
        gameOverLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        yesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        noLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        
        if deaths == 0
        {
            gameOverLabel.text = "try again?"
            yesLabel.text = "yes"
            noLabel.text = "no"
            gameOverLabel.fontSize = 180
            yesLabel.fontSize = 160
            noLabel.fontSize = 160
            gameOverLabel.fontColor = SKColor.white
            //yesLabel.fontColor = SKColor.white
            //noLabel.fontColor = SKColor.white
            yesLabel.position = CGPoint(x: self.size.width * 0.30, y: self.size.height/2.25)
            noLabel.position = CGPoint(x: self.size.width * 0.70, y: self.size.height/2.25)
        }
        if deaths == 1 || deaths == 4 || deaths == 6 || deaths == 8 || deaths == 9
        {
            gameOverLabel.text = ""
            yesLabel.text = "Advance"
            noLabel.text = "Exit"
            gameOverLabel.fontSize = 180
            yesLabel.fontSize = 120
            noLabel.fontSize = 120
            gameOverLabel.fontColor = SKColor.white
            //yesLabel.fontColor = SKColor.white
            //noLabel.fontColor = SKColor.white
            yesLabel.position = CGPoint(x: self.size.width * 0.30, y: self.size.height/2)
            noLabel.position = CGPoint(x: self.size.width * 0.70, y: self.size.height/2)
        }
        
        if deaths == 2
        {
            gameOverLabel.text = "give up?"
            yesLabel.text = "no"
            noLabel.text = "yes"
            gameOverLabel.fontSize = 180
            yesLabel.fontSize = 160
            noLabel.fontSize = 160
            gameOverLabel.fontColor = SKColor.white
            //yesLabel.fontColor = SKColor.white
            //noLabel.fontColor = SKColor.white
            yesLabel.position = CGPoint(x: self.size.width * 0.30, y: self.size.height/2.25)
            noLabel.position = CGPoint(x: self.size.width * 0.70, y: self.size.height/2.25)
        }
        if deaths == 3
        {
            gameOverLabel.text = "performing below expectations."
            yesLabel.text = "CONTINUE"
            noLabel.text = "quit"
            gameOverLabel.fontSize = 75
            yesLabel.fontSize = 67
            noLabel.fontSize = 67
            gameOverLabel.fontColor = SKColor.white
            //yesLabel.fontColor = SKColor.white
            //noLabel.fontColor = SKColor.white
            yesLabel.position = CGPoint(x: self.size.width * 0.30, y: self.size.height/2.15)
            noLabel.position = CGPoint(x: self.size.width * 0.70, y: self.size.height/2.15)
        }
        if deaths == 5
        {
            gameOverLabel.text = "give up."
            yesLabel.text = "NO"
            noLabel.text = "yes"
            gameOverLabel.fontSize = 180
            yesLabel.fontSize = 160
            noLabel.fontSize = 160
            gameOverLabel.fontColor = SKColor.white
            //yesLabel.fontColor = SKColor.white
            //noLabel.fontColor = SKColor.white
            yesLabel.position = CGPoint(x: self.size.width * 0.30, y: self.size.height/2.4)
            noLabel.position = CGPoint(x: self.size.width * 0.70, y: self.size.height/2.4)
        }
        if deaths == 7
        {
            gameOverLabel.text = "pointless."
            yesLabel.text = "Disagree"
            noLabel.text = "Agree"
            gameOverLabel.fontSize = 140
            yesLabel.fontSize = 124
            noLabel.fontSize = 124
            gameOverLabel.fontColor = SKColor.white
           // yesLabel.fontColor = SKColor.white
            //noLabel.fontColor = SKColor.white
            yesLabel.position = CGPoint(x: self.size.width * 0.30, y: self.size.height/2.25)
            noLabel.position = CGPoint(x: self.size.width * 0.70, y: self.size.height/2.25)
        }
        if deaths == 10 //Good
        {
            gameOverLabel.text = "*abyssal silence ensues*"
            yesLabel.text = "PERSERVERE"
            noLabel.text = "SECEDE"
            gameOverLabel.fontSize = 95
            yesLabel.fontSize = 81
            noLabel.fontSize = 81
            gameOverLabel.fontColor = SKColor.red
            //yesLabel.fontColor = SKColor.white
            //noLabel.fontColor = SKColor.white
            yesLabel.position = CGPoint(x: self.size.width * 0.30, y: self.size.height/2.17)
            noLabel.position = CGPoint(x: self.size.width * 0.70, y: self.size.height/2.17)
        }
        if deaths > 10
        {
            gameOverLabel.text = ""
            yesLabel.text = "perservere"
            noLabel.text = "secede"
            gameOverLabel.fontSize = 100
            yesLabel.fontSize = 90
            noLabel.fontSize = 90
            gameOverLabel.fontColor = SKColor.white
            yesLabel.position = CGPoint(x: self.size.width * 0.30, y: self.size.height/2.1)
            noLabel.position = CGPoint(x: self.size.width * 0.70, y: self.size.height/2.1)
            
        }
        
        
        gameOverLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/1.8)
        
        
        gameOverLabel.zPosition = 1
        yesLabel.zPosition = 1
        noLabel.zPosition = 1
        self.addChild(gameOverLabel)
        self.addChild(yesLabel)
        self.addChild(noLabel)
        
        
        yesRect = CGRect(x: 0, y: 180, width: 449+25, height: 200.0)
        noRect = CGRect(x: 449 + 25, y: 180, width: self.size.width, height: 200.0)
        //noRect = CGRect(x:self.size.width * 0.322, y: self.size.height * 0.106, width: self.size.width * 0.104, height: self.size.height * 0.0439)
        //print("Width: \(self.size.width) ... Height: \(self.size.height)")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            //print("\(pointOfTouch.x)   \(pointOfTouch.y)")
            print("\(self.size.width)")
            if yesRect.contains(pointOfTouch)
            {
                let sceneToMoveTo = TitleScreen(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration:  1.0)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
            if noRect.contains(pointOfTouch)
            {
                //let sceneToMoveTo = blackOutScene(size: self.size)
                let sceneToMoveTo = gameExit(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration:  1.0)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
        }
    }
}
