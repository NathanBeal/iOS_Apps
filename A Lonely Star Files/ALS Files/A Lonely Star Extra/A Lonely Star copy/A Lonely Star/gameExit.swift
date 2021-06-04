//
//  gameExit.swift
//  A Lonely Star
//
//  Created by ADAMLANE on 5/12/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit

class gameExit: SKScene
{
    override func didMove(to view: SKView)//runs as soon as started
    {
        let background = SKSpriteNode(imageNamed: "gameOverBackground")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let emptyHeart = SKSpriteNode(imageNamed: "emptyHeart")
        emptyHeart.setScale(0.20)
        emptyHeart.position = CGPoint(x: self.size.width/2, y: self.size.height/2.1)
        emptyHeart.zPosition = 2
        self.addChild(emptyHeart)
        
        
        let gameOverLabel = SKLabelNode()//cool font
        gameOverLabel.text = "the user, ran out of heart..."//you
        gameOverLabel.fontSize = 60
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/1.9)
        gameOverLabel.zPosition = 1
        self.addChild(gameOverLabel)
        
        let waitToExit = SKAction.wait(forDuration:  1)
        let changeSceneSequence = SKAction.sequence([waitToExit])
        self.run(changeSceneSequence)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        exit(0)
    }
}
