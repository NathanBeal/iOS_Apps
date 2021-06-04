//
//  Divisions.swift
//  MySportsConnect
//
//  Created by ADAMLANE on 7/9/19.
//  Copyright © 2019 Nathan Beal Studios. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Divisions: SKScene
{
    let gameArea: CGRect
    
    let Background = SKSpriteNode(imageNamed: "MSCBackground.")
    let MTBackground = SKSpriteNode(imageNamed: "MyTeamsBackground")
    let ExitButton = SKSpriteNode(imageNamed: "PageExit")
    let PageBackButton = SKSpriteNode(imageNamed: "PageBack")
    let AddTeamButton = SKSpriteNode(imageNamed: "AddTeam")
    
    let Directions = SKLabelNode()
    let AddTeamLabel = SKLabelNode()
    
    var TeamBannerRect = CGRect()
    
    //League Info
    var temp1Rect = CGRect()
    var temp2Rect = CGRect()
    var temp3Rect = CGRect()
    var temp4Rect = CGRect()
    
    var Divisions:[String] = Array()
    
    var Division1 = SKShapeNode()
    let Division1Label = SKLabelNode()
    var Division2 = SKShapeNode()
    let Division2Label = SKLabelNode()
    var Division3 = SKShapeNode()
    let Division3Label = SKLabelNode()
    var Division4 = SKShapeNode()
    let Division4Label = SKLabelNode()
    var Division5 = SKShapeNode()
    let Division5Label = SKLabelNode()
    
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
        let path = Bundle.main.path(forResource: defaults.string(forKey: "League"), ofType: "txt")
        var dataString = ""
        do{
            dataString = try String (contentsOfFile: path!)
            //print(dataString)
        }catch _ as NSError{
            print("issue reading")
        }
        let lines:[String] = dataString.components(separatedBy: "\n")
        Divisions = lines[0].components(separatedBy: ".")
        
        Background.size = self.size
        Background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        Background.zPosition = 0
        self.addChild(Background)
        
        //Adjustors
        if (defaults.double(forKey: "FrameWidth") == 414 && defaults.double(forKey: "FrameHeight") == 896) || (defaults.double(forKey: "FrameWidth") == 375 && defaults.double(forKey: "FrameHeight") == 812)
        {
            TeamBannerRect = CGRect(x: -0.1 * self.size.width/10, y: self.size.height - 1.25 * self.size.height/10, width: 1.02 * self.size.width, height: 1.27 * self.size.height/10)
            AddTeamLabel.position = CGPoint(x: self.size.width/2, y: 0.985 * TeamBannerRect.midY)
        }else{
            TeamBannerRect = CGRect(x: 0, y: self.size.height - 1.25 * self.size.height/10, width: self.size.width, height: 1.25 * self.size.height/10)
            AddTeamLabel.position = CGPoint(x: self.size.width/2, y: TeamBannerRect.midY)
        }
        MTBackground.size = TeamBannerRect.size
        MTBackground.position = CGPoint(x: self.size.width/2, y: 9.375 * self.size.height/10)
        MTBackground.zPosition = 1
        self.addChild(MTBackground)
        
        
        AddTeamLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        AddTeamLabel.position = CGPoint(x: self.size.width/2, y: AddTeamLabel.position.y)
        AddTeamLabel.text = "Add Teams"
        AddTeamLabel.fontSize = CGFloat(40 * scaleModifier)
        AddTeamLabel.fontColor = SKColor.white
        AddTeamLabel.zPosition = 2
        self.addChild(AddTeamLabel)
        
        AddTeamButton.setScale(CGFloat(0.35 * scaleModifier))
        AddTeamButton.position = CGPoint(x: 9 * TeamBannerRect.width/10, y: AddTeamLabel.position.y)
        AddTeamButton.zPosition = 2
        AddTeamButton.alpha = 0
        self.addChild(AddTeamButton)
        
        ExitButton.setScale(CGFloat(0.35 * scaleModifier))
        ExitButton.position = CGPoint(x: 9 * TeamBannerRect.width/10, y: AddTeamLabel.position.y)
        ExitButton.zPosition = 2
        self.addChild(ExitButton)
        
        PageBackButton.setScale(CGFloat(0.35 * scaleModifier))
        PageBackButton.position = CGPoint(x: 1 * TeamBannerRect.width/10, y: AddTeamLabel.position.y)
        PageBackButton.zPosition = 2
        self.addChild(PageBackButton)
        
        Directions.position = CGPoint(x: 5 * self.size.width/10, y: 8.3 * self.size.height/10)
        Directions.text = "Choose The Division"
        Directions.fontSize = CGFloat(30 * scaleModifier)
        Directions.fontColor = SKColor.white
        Directions.zPosition = 2
        Directions.alpha = 0
        self.addChild(Directions)
        
        
        temp1Rect = CGRect(x: 1 * self.size.width/10, y: 6.8 * self.size.height/10, width: 8 * self.size.width/10, height: 1.25 * self.size.height/10)
        temp2Rect = CGRect(x: 1 * self.size.width/10, y: 5.3 * self.size.height/10, width: 8 * self.size.width/10, height: 1.25 * self.size.height/10)
        temp3Rect = CGRect(x: 1 * self.size.width/10, y: 3.8 * self.size.height/10, width: 8 * self.size.width/10, height: 1.25 * self.size.height/10)
        temp4Rect = CGRect(x: 1 * self.size.width/10, y: 2.3 * self.size.height/10, width: 8 * self.size.width/10, height: 1.25 * self.size.height/10)
        
        
        
        //All Registered Leagues
        let temp1Rect = CGRect(x: 1 * self.size.width/10, y: 6.8 * self.size.height/10, width: 8 * self.size.width/10, height: 1.25 * self.size.height/10)
        Division1 = SKShapeNode.init(rect: temp1Rect)
        Division1.fillColor = Colors.white
        Division1.zPosition = 1
        Division1.strokeColor = SKColor.black
        Division1.lineWidth = 2
        Division1.alpha = 0
        self.addChild(Division1)
        
        Division1Label.position = CGPoint(x: self.size.width/2, y: temp1Rect.midY)
        Division1Label.text = Divisions[0]
        Division1Label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        Division1Label.fontSize = CGFloat(27 * scaleModifier)
        Division1Label.fontColor = Colors.black
        Division1Label.zPosition = 11
        Division1Label.fontName = "HelveticaNeue-Light"
        Division1Label.alpha = 0
        self.addChild(Division1Label)
        
        let temp2Rect = CGRect(x: 1 * self.size.width/10, y: 5.3 * self.size.height/10, width: 8 * self.size.width/10, height: 1.25 * self.size.height/10)
        Division2 = SKShapeNode.init(rect: temp2Rect)
        Division2.fillColor = Colors.white
        Division2.zPosition = 1
        Division2.strokeColor = SKColor.black
        Division2.lineWidth = 2
        Division2.alpha = 0
        self.addChild(Division2)
        Division2Label.position = CGPoint(x: self.size.width/2, y: temp2Rect.midY)
        Division2Label.text = Divisions[1]
        Division2Label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        Division2Label.fontSize = CGFloat(27 * scaleModifier)
        Division2Label.fontColor = Colors.black
        Division2Label.zPosition = 11
        Division2Label.fontName = "HelveticaNeue-Light"
        Division2Label.alpha = 0
        self.addChild(Division2Label)
        
        let temp3Rect = CGRect(x: 1 * self.size.width/10, y: 3.8 * self.size.height/10, width: 8 * self.size.width/10, height: 1.25 * self.size.height/10)
        Division3 = SKShapeNode.init(rect: temp3Rect)
        Division3.fillColor = Colors.white
        Division3.zPosition = 1
        Division3.strokeColor = SKColor.black
        Division3.lineWidth = 2
        Division3.alpha = 0
        self.addChild(Division3)
        
        Division3Label.position = CGPoint(x: self.size.width/2, y: temp3Rect.midY)
        Division3Label.text = Divisions[2]
        Division3Label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        Division3Label.fontSize = CGFloat(27 * scaleModifier)
        Division3Label.fontColor = Colors.black
        Division3Label.zPosition = 11
        Division3Label.fontName = "HelveticaNeue-Light"
        Division3Label.alpha = 0
        self.addChild(Division3Label)
        
        let temp4Rect = CGRect(x: 1 * self.size.width/10, y: 2.3 * self.size.height/10, width: 8 * self.size.width/10, height: 1.25 * self.size.height/10)
        Division4 = SKShapeNode.init(rect: temp4Rect)
        Division4.fillColor = Colors.white
        Division4.zPosition = 1
        Division4.strokeColor = SKColor.black
        Division4.lineWidth = 2
        Division4.alpha = 0
        self.addChild(Division4)
        
        Division4Label.position = CGPoint(x: self.size.width/2, y: temp4Rect.midY)
        Division4Label.text = Divisions[3]
        Division4Label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        Division4Label.fontSize = CGFloat(27 * scaleModifier)
        Division4Label.fontColor = Colors.black
        Division4Label.zPosition = 11
        Division4Label.fontName = "HelveticaNeue-Light"
        Division4Label.alpha = 0
        self.addChild(Division4Label)
        
        let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.5)
        Directions.run(fadeIn)
        Division1.run(fadeIn)
        Division1Label.run(fadeIn)
        Division2.run(fadeIn)
        Division2Label.run(fadeIn)
        Division3.run(fadeIn)
        Division3Label.run(fadeIn)
        Division4.run(fadeIn)
        Division4Label.run(fadeIn)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            
            //Division 1
            if (pointOfTouch.x > 5 * self.size.width/10 - temp1Rect.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + temp1Rect.size.width/2) && (pointOfTouch.y < 3.2 * self.size.height/10 + temp1Rect.size.height/2 && pointOfTouch.y > 3.2 * self.size.height/10 - temp1Rect.size.height/2)
            {
                defaults.set(Divisions[0], forKey: "DivisionIdentifier")
                //defaults.set("Pre", forKey: "DivTextIdentifier")
                
                let substring = Divisions[0].prefix(3)
                defaults.set(substring, forKey: "DivTextIdentifier")
                
                self.run(SKAction.run(slideOut))
                let wait = SKAction.wait(forDuration: 0.75)
                let changeScene = SKAction.run(sceneLocalDivisionalTeams)
                let sequence = SKAction.sequence([wait, changeScene])
                self.run(sequence)
            }
            
            //Division 2
            if (pointOfTouch.x > 5 * self.size.width/10 - temp1Rect.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + temp1Rect.size.width/2) && (pointOfTouch.y < 4.7 * self.size.height/10 + temp1Rect.size.height/2 && pointOfTouch.y > 4.7 * self.size.height/10 - temp1Rect.size.height/2)
            {
                defaults.set(Divisions[1], forKey: "DivisionIdentifier")
                
                let substring = Divisions[1].prefix(3)
                defaults.set(substring, forKey: "DivTextIdentifier")
                
                self.run(SKAction.run(slideOut))
                let wait = SKAction.wait(forDuration: 0.75)
                let changeScene = SKAction.run(sceneLocalDivisionalTeams)
                let sequence = SKAction.sequence([wait, changeScene])
                self.run(sequence)
            }
            
            //Division 3
            if (pointOfTouch.x > 5 * self.size.width/10 - temp1Rect.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + temp1Rect.size.width/2) && (pointOfTouch.y < 6.2 * self.size.height/10 + temp1Rect.size.height/2 && pointOfTouch.y > 6.2 * self.size.height/10 - temp1Rect.size.height/2)
            {
                defaults.set(Divisions[2], forKey: "DivisionIdentifier")
                
                let substring = Divisions[2].prefix(3)
                defaults.set(substring, forKey: "DivTextIdentifier")
                
                self.run(SKAction.run(slideOut))
                let wait = SKAction.wait(forDuration: 0.75)
                let changeScene = SKAction.run(sceneLocalDivisionalTeams)
                let sequence = SKAction.sequence([wait, changeScene])
                self.run(sequence)
            }
            
            //Division 4
            if (pointOfTouch.x > 5 * self.size.width/10 - temp1Rect.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + temp1Rect.size.width/2) && (pointOfTouch.y < 7.7 * self.size.height/10 + temp1Rect.size.height/2 && pointOfTouch.y > 7.7 * self.size.height/10 - temp1Rect.size.height/2)
            {
                defaults.set(Divisions[3], forKey: "DivisionIdentifier")
                let substring = Divisions[3].prefix(3)
                defaults.set(substring, forKey: "DivTextIdentifier")
                
                self.run(SKAction.run(slideOut))
                let wait = SKAction.wait(forDuration: 0.75)
                let changeScene = SKAction.run(sceneLocalDivisionalTeams)
                let sequence = SKAction.sequence([wait, changeScene])
                self.run(sequence)
            }
            
            //Back
            if (pointOfTouch.x > 1 * self.size.width/10 - AddTeamButton.size.width/2 && pointOfTouch.x < 1 * self.size.width/10 + AddTeamButton.size.width/2) && (pointOfTouch.y < self.size.height - AddTeamButton.position.y + AddTeamButton.size.height/2 && pointOfTouch.y > self.size.height - AddTeamButton.position.y - AddTeamButton.size.height/2)
            {
                self.run(SKAction.run(pageBack))
                
                let wait = SKAction.wait(forDuration: 0.75)
                let changeScene = SKAction.run(sceneLocalLeague)
                let sequence = SKAction.sequence([wait, changeScene])
                self.run(sequence)
            }
            
            //Exit
            if (pointOfTouch.x > 9 * self.size.width/10 - AddTeamButton.size.width/2 && pointOfTouch.x < 9 * self.size.width/10 + AddTeamButton.size.width/2) && (pointOfTouch.y < self.size.height - AddTeamButton.position.y + AddTeamButton.size.height/2 && pointOfTouch.y > self.size.height - AddTeamButton.position.y - AddTeamButton.size.height/2)
            {
                self.run(SKAction.run(exitFade))
                
                let wait = SKAction.wait(forDuration: 0.75)
                let changeScene = SKAction.run(sceneMyTeams)
                let sequence = SKAction.sequence([wait, changeScene])
                self.run(sequence)
            }
        }
    }
    
    func slideOut()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        
        Directions.run(fadeOut)
        Division1.run(fadeOut)
        Division1Label.run(fadeOut)
        Division2.run(fadeOut)
        Division2Label.run(fadeOut)
        Division3.run(fadeOut)
        Division3Label.run(fadeOut)
        Division4.run(fadeOut)
        Division4Label.run(fadeOut)
    }
    
    func sceneLocalDivisionalTeams()
    {
        let sceneToMoveTo = Teams(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func exitFade()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        
        let fadeOutExit = SKAction.fadeOut(withDuration: 0.25)
        let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.25)
        
        AddTeamButton.run(fadeIn)
        ExitButton.run(fadeOutExit)
        
        Directions.run(fadeOut)
        AddTeamLabel.run(fadeOut)
        PageBackButton.run(fadeOut)
        Division1.run(fadeOut)
        Division1Label.run(fadeOut)
        Division2.run(fadeOut)
        Division2Label.run(fadeOut)
        Division3.run(fadeOut)
        Division3Label.run(fadeOut)
        Division4.run(fadeOut)
        Division4Label.run(fadeOut)
    }
    
    func pageBack()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        
        defaults.set(true, forKey: "Backwards")
        
        Directions.run(fadeOut)
        Division1.run(fadeOut)
        Division1Label.run(fadeOut)
        Division2.run(fadeOut)
        Division2Label.run(fadeOut)
        Division3.run(fadeOut)
        Division3Label.run(fadeOut)
        Division4.run(fadeOut)
        Division4Label.run(fadeOut)
    }
    
    func sceneLocalLeague()
    {
        let sceneToMoveTo = Leagues(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func sceneMyTeams()
    {
        let sceneToMoveTo = MyTeams(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
}
