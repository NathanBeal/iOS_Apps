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
        //Background
        let background = SKSpriteNode(imageNamed: "gameOverBackground")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        //GameOver Text
        let gameOverLabel = SKLabelNode()//cool font
        gameOverLabel.text = "try again."
        gameOverLabel.fontSize = 180
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/1.8)
        gameOverLabel.zPosition = 1
        self.addChild(gameOverLabel)
        
        //Yes Label
        let yesLabel = SKLabelNode()//cool font
        yesLabel.text = "yes"
        yesLabel.fontSize = 160
        yesLabel.fontColor = SKColor.white
        yesLabel.position = CGPoint(x: self.size.width * 0.30, y: self.size.height/2.4)
        yesLabel.zPosition = 1
        self.addChild(yesLabel)
        yesRect = CGRect(x: 170, y: 218, width: 159.0, height: 90.0)

        //No Label
        let noLabel = SKLabelNode()//cool font
        noLabel.text = "no"
        noLabel.fontSize = 160
        noLabel.fontColor = SKColor.white
        noLabel.position = CGPoint(x: self.size.width * 0.70, y: self.size.height/2.4)
        noLabel.zPosition = 1
        self.addChild(noLabel)
        noRect = CGRect(x: 495.0, y: 218.0, width: 159.0, height: 90.0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)//iasues
            
            if yesRect.contains(pointOfTouch)
            {
                let sceneToMoveTo = preGame(size: self.size)
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
