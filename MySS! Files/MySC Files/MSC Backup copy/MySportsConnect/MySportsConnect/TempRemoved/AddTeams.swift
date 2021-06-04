//
//  AddTeams.swift
//  MySportsConnect
//
//  Created by ADAMLANE on 7/8/19.
//  Copyright © 2019 Nathan Beal Studios. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class AddTeams: SKScene
{
    let Background = SKSpriteNode(imageNamed: "MSCBackground.")
    let MTBackground = SKSpriteNode(imageNamed: "MyTeamsBackground")
    let LocalTeams = SKSpriteNode(imageNamed: "Label")
    let CollegeRecTeams = SKSpriteNode(imageNamed: "Label")
    let ExitButton = SKSpriteNode(imageNamed: "PageExit")
    let PageBackButton = SKSpriteNode(imageNamed: "PageBack")
    let AddTeamButton = SKSpriteNode(imageNamed: "AddTeam")
    
    
    let LocalTeamsLabel = SKLabelNode()
    let CollegeRecTeamsLabel = SKLabelNode()
    let Directions = SKLabelNode()
    
    
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
        
        let TeamBannerRect = CGRect(x: 0, y: self.size.height - 1.25 * self.size.height/10, width: self.size.width, height: 1.25 * self.size.height/10)
    
        MTBackground.size = TeamBannerRect.size
        MTBackground.position = CGPoint(x: self.size.width/2, y: 9.375 * self.size.height/10)
        MTBackground.zPosition = 1
        self.addChild(MTBackground)
        
        AddTeamLabel.position = CGPoint(x: self.size.width/2, y: TeamBannerRect.midY - (TeamBannerRect.midY/50))
        AddTeamLabel.text = "Add Teams"
        AddTeamLabel.fontSize = CGFloat(40 * scaleModifier)
        AddTeamLabel.fontColor = SKColor.white
        AddTeamLabel.zPosition = 2
        AddTeamLabel.alpha = 0
        self.addChild(AddTeamLabel)
        
        AddTeamButton.setScale(CGFloat(0.35 * scaleModifier))
        AddTeamButton.position = CGPoint(x: 9 * self.size.width/10, y: 9.25 * self.size.height/10)
        AddTeamButton.zPosition = 2
        AddTeamButton.alpha = 0
        self.addChild(AddTeamButton)
        
        ExitButton.setScale(CGFloat(0.35 * scaleModifier))
        ExitButton.position = CGPoint(x: 9 * self.size.width/10, y: 9.25 * self.size.height/10)
        ExitButton.zPosition = 2
        self.addChild(ExitButton)
        
        PageBackButton.setScale(CGFloat(0.35 * scaleModifier))
        PageBackButton.position = CGPoint(x: 1 * self.size.width/10, y: 9.25 * self.size.height/10)
        PageBackButton.zPosition = 2
        PageBackButton.alpha = 0
        self.addChild(PageBackButton)
        
        Directions.position = CGPoint(x: 5 * self.size.width/10, y: 8.3 * self.size.height/10)
        Directions.text = "Select Activity Type"
        Directions.fontSize = CGFloat(30 * scaleModifier)
        Directions.fontColor = SKColor.white
        Directions.zPosition = 2
        Directions.alpha = 0
        self.addChild(Directions)
        
        
        
        
        
        //Labels
        LocalTeamsLabel.text = "Local Teams"
        LocalTeamsLabel.fontSize = CGFloat(30 * scaleModifier)
        LocalTeamsLabel.fontColor = SKColor.black
        LocalTeamsLabel.zPosition = 10
        self.addChild(LocalTeamsLabel)
        

        CollegeRecTeamsLabel.text = "College Activities"
        CollegeRecTeamsLabel.fontSize = CGFloat(30 * scaleModifier)
        CollegeRecTeamsLabel.fontColor = SKColor.black
        CollegeRecTeamsLabel.zPosition = 10
        self.addChild(CollegeRecTeamsLabel)
        
        
        //Teams
        LocalTeams.setScale(CGFloat(1.1 * scaleModifier))
        LocalTeams.zPosition = 5
        self.addChild(LocalTeams)
        
        CollegeRecTeams.setScale(CGFloat(1.1 * scaleModifier))
        CollegeRecTeams.zPosition = 5
        self.addChild(CollegeRecTeams)
        
        //PageBack
        if defaults.bool(forKey: "Backwards") == false
        {
            CollegeRecTeams.position = CGPoint(x: 15 * self.size.width/10, y: 5.8 * self.size.height/10)
            LocalTeams.position = CGPoint(x: 15 * self.size.width/10, y: 7.4 * self.size.height/10)
            CollegeRecTeamsLabel.position = CGPoint(x: 15 * self.size.width/10, y: 5.75 * self.size.height/10)
            LocalTeamsLabel.position = CGPoint(x: 15 * self.size.width/10, y: 7.35 * self.size.height/10)
        }else{
            CollegeRecTeams.position = CGPoint(x: -5 * self.size.width/10, y: 5.8 * self.size.height/10)
            LocalTeams.position = CGPoint(x: -5 * self.size.width/10, y: 7.4 * self.size.height/10)
            CollegeRecTeamsLabel.position = CGPoint(x: -5 * self.size.width/10, y: 5.75 * self.size.height/10)
            LocalTeamsLabel.position = CGPoint(x: -5 * self.size.width/10, y: 7.35 * self.size.height/10)
            defaults.set(false, forKey: "Backwards")
            print("here")
        }
        
        self.run(SKAction.run(slideIn))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            let buttonWidth = LocalTeams.size.width
            let buttonHeight = LocalTeams.size.height
            
            
            
            if (pointOfTouch.x > 5 * self.size.width/10 - buttonWidth/2 && pointOfTouch.x < 5 * self.size.width/10 + buttonWidth/2) && (pointOfTouch.y < 2.6 * self.size.height/10 + buttonHeight/2 && pointOfTouch.y > 2.6 * self.size.height/10 - buttonHeight/2)
            {
                //print("true")
                self.run(SKAction.run(slideOut))
                
                let wait = SKAction.wait(forDuration: 0.75)
                let changeScene = SKAction.run(sceneLocalTeams)
                let sequence = SKAction.sequence([wait, changeScene])
                self.run(sequence)
            }
            
            if (pointOfTouch.x > 5 * self.size.width/10 - buttonWidth/2 && pointOfTouch.x < 5 * self.size.width/10 + buttonWidth/2) && (pointOfTouch.y < 4.2 * self.size.height/10 + buttonHeight/2 && pointOfTouch.y > 4.2 * self.size.height/10 - buttonHeight/2)
            {
                self.run(SKAction.run(slideOut))
                
                let wait = SKAction.wait(forDuration: 0.75)
                let changeScene = SKAction.run(RecActivities)
                let sequence = SKAction.sequence([wait, changeScene])
                self.run(sequence)
            }
            
            //Back
            if (pointOfTouch.x > 1 * self.size.width/10 - AddTeamButton.size.width/2 && pointOfTouch.x < 1 * self.size.width/10 + AddTeamButton.size.width/2) && (pointOfTouch.y < 0.75 * self.size.height/10 + AddTeamButton.size.height/2 && pointOfTouch.y > 0.75 * self.size.height/10 - AddTeamButton.size.height/2)
            {
                self.run(SKAction.run(pageBack))
                
                let wait = SKAction.wait(forDuration: 0.75)
                let changeScene = SKAction.run(sceneMyTeams)
                let sequence = SKAction.sequence([wait, changeScene])
                self.run(sequence)
            }
            
            //Exit
            if (pointOfTouch.x > 9 * self.size.width/10 - AddTeamButton.size.width/2 && pointOfTouch.x < 9 * self.size.width/10 + AddTeamButton.size.width/2) && (pointOfTouch.y < 0.75 * self.size.height/10 + AddTeamButton.size.height/2 && pointOfTouch.y > 0.75 * self.size.height/10 - AddTeamButton.size.height/2)
            {
                self.run(SKAction.run(exitFade))
                
                let wait = SKAction.wait(forDuration: 0.75)
                let changeScene = SKAction.run(sceneMyTeams)
                let sequence = SKAction.sequence([wait, changeScene])
                self.run(sequence)
            }
            
        }
    }
    
    func slideIn()
    {
        let slideIn = SKAction.moveTo(x: 5 * self.size.width/10, duration: 0.75)
        let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.75)
        
        Directions.run(fadeIn)
        AddTeamLabel.run(fadeIn)
        PageBackButton.run(fadeIn)
        
        AddTeamLabel.run(slideIn)
        LocalTeams.run(slideIn)
        CollegeRecTeams.run(slideIn)
        LocalTeamsLabel.run(slideIn)
        CollegeRecTeamsLabel.run(slideIn)
    }
    
    func slideOut()
    {
        let slideOut = SKAction.moveTo(x: -5 * self.size.width/10, duration: 0.75)
        let fadeOut = SKAction.fadeOut(withDuration: 0.75)
        
        Directions.run(fadeOut)
        
        LocalTeams.run(slideOut)
        CollegeRecTeams.run(slideOut)
        LocalTeamsLabel.run(slideOut)
        CollegeRecTeamsLabel.run(slideOut)
    }
    
    
    
    func sceneLocalTeams()
    {
        let sceneToMoveTo = LocalTeamsScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func RecActivities()
    {
        let sceneToMoveTo = RecActivitiesScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func pageBack()
    {
        let slideOut = SKAction.moveTo(x: 15 * self.size.width/10, duration: 0.75)
        let fadeOut = SKAction.fadeOut(withDuration: 0.75)
        
        Directions.run(fadeOut)
        
        LocalTeams.run(slideOut)
        CollegeRecTeams.run(slideOut)
        LocalTeamsLabel.run(slideOut)
        CollegeRecTeamsLabel.run(slideOut)
    }
    
    func exitFade()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.75)
        
        let fadeOutExit = SKAction.fadeOut(withDuration: 0.375)
        let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.375)
        
        AddTeamButton.run(fadeIn)
        ExitButton.run(fadeOutExit)
        
        Directions.run(fadeOut)
        AddTeamLabel.run(fadeOut)
        PageBackButton.run(fadeOut)
        LocalTeams.run(fadeOut)
        CollegeRecTeams.run(fadeOut)
        LocalTeamsLabel.run(fadeOut)
        CollegeRecTeamsLabel.run(fadeOut)
    }
    
    func sceneMyTeams()
    {
        let sceneToMoveTo = MyTeams(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
}
