//
//  Leagues.swift
//  MySportsConnect
//
//  Created by ADAMLANE on 7/9/19.
//  Copyright © 2019 Nathan Beal Studios. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Leagues: SKScene
{
    let gameArea: CGRect
    
    override init(size: CGSize)
    {
        gameArea = CGRect(x: 0, y: 0, width: defaults.double(forKey: "FrameWidth"), height: defaults.double(forKey: "FrameHeight"))
        super.init(size: size)
    }
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    let Background = SKSpriteNode(imageNamed: "MSCBackground.")
    let MTBackground = SKSpriteNode(imageNamed: "MyTeamsBackground")
    let ExitButton = SKSpriteNode(imageNamed: "PageExit")
    let PageBackButton = SKSpriteNode(imageNamed: "PageBack")
    let AddTeamButton = SKSpriteNode(imageNamed: "AddTeam")
    
    var League1 = SKShapeNode()
    var League1Rect = CGRect(x: 1 * selfWidth/10, y: 7.3 * selfHeight/10, width: 8 * selfWidth/10, height: 1.25 * selfHeight/10)
    
    // WILL BE ADDED BACK WHEN NECESSARY
    /*
     var League2 = SKShapeNode()
     var League2Rect = CGRect(x: 1 * selfWidth/10, y: 5.8 * selfHeight/10, width: 8 * selfWidth/10, height: 1.25 * selfHeight/10)
     
     var League3 = SKShapeNode()
     var League3Rect = CGRect(x: 1 * selfWidth/10, y: 4.3 * selfHeight/10, width: 8 * selfWidth/10, height: 1.25 * selfHeight/10)
     
     var League3 = SKShapeNode()
     var League4Rect = CGRect(x: 1 * selfWidth/10, y: 2.8 * selfHeight/10, width: 8 * selfWidth/10, height: 1.25 * selfHeight/10)
     
     var League5 = SKShapeNode()
     var League5Rect = CGRect(x: 1 * selfWidth/10, y: 1.3 * selfHeight/10, width: 8 * selfWidth/10, height: 1.25 * selfHeight/10)
     */
    
    
    let Directions = SKLabelNode()
    let AddTeamLabel = SKLabelNode()
    
    //League Info
    //let League1 = SKSpriteNode(imageNamed: "Label")
    let League1Label = SKLabelNode()
    
    
    
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
        self.addChild(PageBackButton)
        
        Directions.position = CGPoint(x: 5 * self.size.width/10, y: 8.3 * self.size.height/10)
        Directions.text = "Select A League"
        Directions.fontSize = CGFloat(30 * scaleModifier)
        Directions.fontColor = SKColor.white
        Directions.zPosition = 2
        Directions.alpha = 0
        self.addChild(Directions)
        
        //All Registered Leagues
        
        
        
        League1 = SKShapeNode.init(rect: League1Rect)
        League1.fillColor = SKColor.white
        League1.zPosition = 5
        League1.strokeColor = SKColor.black
        League1.lineWidth = 2
        
        League1Label.position = CGPoint(x: self.size.width/2, y: League1Rect.midY)
        League1Label.text = "HVNABA"
        League1Label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        League1Label.fontSize = CGFloat(30 * scaleModifier)
        League1Label.fontColor = SKColor.black
        League1Label.zPosition = 10
        League1Label.fontName = "Avenir-BlackOblique"
        League1Label.alpha = 0
        
        self.addChild(League1)
        self.addChild(League1Label)
        
        let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.75)
        League1.run(fadeIn)
        League1Label.run(fadeIn)
        
        
        
        
        
        if defaults.bool(forKey: "Backwards") == false
        {
            League1Label.position = CGPoint(x: 15 * self.size.width/10, y: 7.35 * self.size.height/10)
            League1.position = CGPoint(x: 15 * self.size.width/10, y: 7.4 * self.size.height/10)
            
        }else{
            League1Label.position = CGPoint(x: -5 * self.size.width/10, y: 7.35 * self.size.height/10)
            League1.position = CGPoint(x: -5 * self.size.width/10, y: 7.4 * self.size.height/10)
        }
        
        self.run(SKAction.run(slideIn))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            
            if (pointOfTouch.x > 5 * self.size.width/10 - League1Rect.width/2 && pointOfTouch.x < 5 * self.size.width/10 + League1Rect.width/2) && (pointOfTouch.y < 2.7 * self.size.height/10 + League1Rect.height/2 && pointOfTouch.y > 2.7 * self.size.height/10 - League1Rect.height/2)
            {
                defaults.set("HVNABA", forKey: "League")
                self.run(SKAction.run(slideOut))
                let wait = SKAction.wait(forDuration: 0.75)
                let changeScene = SKAction.run(sceneLocalDivisions)
                let sequence = SKAction.sequence([wait, changeScene])
                self.run(sequence)
            }
            
            //Back
            if (pointOfTouch.x > 1 * self.size.width/10 - AddTeamButton.size.width/2 && pointOfTouch.x < 1 * self.size.width/10 + AddTeamButton.size.width/2) && (pointOfTouch.y < 0.75 * self.size.height/10 + AddTeamButton.size.height/2 && pointOfTouch.y > 0.75 * self.size.height/10 - AddTeamButton.size.height/2)
            {
                self.run(SKAction.run(pageBack))
                
                let wait = SKAction.wait(forDuration: 0.75)
                //let changeScene = SKAction.run(sceneLocalTeams)
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
        League1.run(slideIn)
        League1Label.run(slideIn)
    }
    func slideOut()
    {
        let slideOut = SKAction.moveTo(x: -5 * self.size.width/10, duration: 0.75)
        let fadeOut = SKAction.fadeOut(withDuration: 0.75)
        
        Directions.run(fadeOut)
        League1.run(slideOut)
        League1Label.run(slideOut)
    }
    
    func sceneLocalDivisions()
    {
        let sceneToMoveTo = Divisions(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
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
        League1.run(fadeOut)
        League1Label.run(fadeOut)
    }
    
    //REPLACING CUT
    func sceneMyTeams()
    {
        let sceneToMoveTo = MyTeams(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func pageBack()
    {
        let slideOut = SKAction.moveTo(x: 15 * self.size.width/10, duration: 0.75)
        let fadeOut = SKAction.fadeOut(withDuration: 0.75)
        
        defaults.set(true, forKey: "Backwards")
        
        Directions.run(fadeOut)
        League1.run(slideOut)
        League1Label.run(slideOut)
    }
    
    //CUT OUT FOR NOW
    /*
     func sceneLocalTeams()
     {
     let sceneToMoveTo = LocalTeamsScene(size: self.size)
     sceneToMoveTo.scaleMode = self.scaleMode
     let myTransition = SKTransition.fade(withDuration:  0.0)
     self.view!.presentScene(sceneToMoveTo, transition: myTransition)
     }
     */
}
