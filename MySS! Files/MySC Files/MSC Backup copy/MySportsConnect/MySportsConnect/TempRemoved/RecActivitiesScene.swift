//
//  RecActivitiesScene.swift
//  MySportsConnect
//
//  Created by ADAMLANE on 7/9/19.
//  Copyright © 2019 Nathan Beal Studios. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class RecActivitiesScene: SKScene
{
    let Background = SKSpriteNode(imageNamed: "MSCBackground.")
    let MTBackground = SKSpriteNode(imageNamed: "MyTeamsBackground")
    let SportBaseball = SKSpriteNode(imageNamed: "Label")
    let SportBaseballLabel = SKLabelNode()
    let ExitButton = SKSpriteNode(imageNamed: "PageExit")
    
    let LocalTeamsLabel = SKLabelNode()
    let CollegeRecTeamsLabel = SKLabelNode()
    let AddTeamLabel = SKLabelNode()
    
    let gameArea: CGRect
    
    //Used for boundaries
    override init(size: CGSize)
    {
        gameArea = CGRect(x: 0, y: 0, width: defaults.double(forKey: "FrameWidth"), height: defaults.double(forKey: "FrameHeight"))
        super.init(size: size)
    }
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView)
    {
        Background.size = self.size
        Background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        Background.zPosition = 0
        self.addChild(Background)
        
        MTBackground.setScale(CGFloat(0.5 * scaleModifier))
        MTBackground.position = CGPoint(x: self.size.width/2, y: 10.8 * self.size.height/10)
        MTBackground.zPosition = 1
        self.addChild(MTBackground)
        
        AddTeamLabel.position = CGPoint(x: 15 * self.size.width/10, y: 9.1 * self.size.height/10)
        AddTeamLabel.text = "Add Teams"
        AddTeamLabel.fontSize = CGFloat(40 * scaleModifier)
        AddTeamLabel.fontColor = SKColor.white
        AddTeamLabel.zPosition = 2
        self.addChild(AddTeamLabel)
        
        ExitButton.setScale(CGFloat(0.35 * scaleModifier))
        ExitButton.position = CGPoint(x: 9 * self.size.width/10, y: 9.25 * self.size.height/10)
        ExitButton.zPosition = 2
        self.addChild(ExitButton)
        
        //Different Sports
        SportBaseballLabel.position = CGPoint(x: 15 * self.size.width/10, y: 7.65 * self.size.height/10)
        SportBaseballLabel.text = "dfs"
        SportBaseballLabel.fontSize = CGFloat(30 * scaleModifier)
        SportBaseballLabel.fontColor = SKColor.black
        SportBaseballLabel.zPosition = 10
        self.addChild(SportBaseballLabel)
        SportBaseball.setScale(CGFloat(1.1 * scaleModifier))
        SportBaseball.position = CGPoint(x: 15 * self.size.width/10, y: 7.75 * self.size.height/10)
        SportBaseball.zPosition = 5
        self.addChild(SportBaseball)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            
            if (pointOfTouch.x > 5 * self.size.width/10 - SportBaseball.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + SportBaseball.size.width/2) && (pointOfTouch.y < 2.25 * self.size.height/10 + SportBaseball.size.height/2 && pointOfTouch.y > 2.25 * self.size.height/10 - SportBaseball.size.height/2)
            {
                /*
                self.run(SKAction.run(slideOut))
                let wait = SKAction.wait(forDuration: 0.75)
                let changeScene = SKAction.run(sceneLocalTeams)
                let sequence = SKAction.sequence([wait, changeScene])
                self.run(sequence)
                */
            }
            
            
        }
    }
    
    func slideIn()
    {
        let slideIn = SKAction.moveTo(x: 5 * self.size.width/10, duration: 0.75)
        AddTeamLabel.run(slideIn)
        SportBaseball.run(slideIn)
        SportBaseballLabel.run(slideIn)
    }
    func slideOut()
    {
        let slideOut = SKAction.moveTo(x: -5 * self.size.width/10, duration: 0.75)
        AddTeamLabel.run(slideOut)
        SportBaseball.run(slideOut)
        SportBaseballLabel.run(slideOut)
    }
}
