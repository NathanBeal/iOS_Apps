//
//  GameWin.swift
//  A Lonely Star
//
//  Created by ADAMLANE on 5/13/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit

var touch = 0
class GameWin: SKScene
{
    let scoreLabel = SKLabelNode()
    override func didMove(to view: SKView)//runs as soon as started
    {
        let background = SKSpriteNode(imageNamed: "gameOverBackground")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let heart = SKSpriteNode(imageNamed: "Heart")
        heart.setScale(0.20)
        heart.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        heart.zPosition = 2
        self.addChild(heart)
        
        
        let gameOverLabel = SKLabelNode()//cool font
        gameOverLabel.text = "the will of a lonely star prevailed..."
        gameOverLabel.fontSize = 60
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/1.8)
        gameOverLabel.zPosition = 1
        self.addChild(gameOverLabel)
        
        
        //High Score
        let defaults = UserDefaults()
        let deathScore = defaults.integer(forKey: "Score")
        if deathScore == 1
        {
            scoreLabel.text = "Score: \(deathScore) death"
        }else{
            scoreLabel.text = "Score: \(deathScore) deaths"
        }
        scoreLabel.fontSize = 60
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2.3)
        scoreLabel.zPosition = 1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        print(touch)
        if touch == 1
        {
            self.addChild(scoreLabel)
        }
        
        if touch >= 2
        {
            defaults.set(0, forKey: "Score")
            defaults.set(Variables.starMaxHealth, forKey: "SHMax")
            defaults.set(Variables.bhMaxHealth, forKey: "BHMax")
            let sceneToMoveTo = preGame(size: self.size)
            sceneToMoveTo.scaleMode = self.scaleMode
            let myTransition = SKTransition.fade(withDuration: 3.0)
            self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        }
        //reset user data
        touch += 1
    }
}
