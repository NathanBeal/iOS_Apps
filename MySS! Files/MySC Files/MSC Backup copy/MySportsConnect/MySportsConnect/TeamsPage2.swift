//
//  Teams.swift
//  MySportsConnect
//
//  Created by ADAMLANE on 7/9/19.
//  Copyright © 2019 Nathan Beal Studios. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class TeamsPage2: SKScene
{
    let gameArea: CGRect
    
    let Background = SKSpriteNode(imageNamed: "MSCBackground.")
    let MTBackground = SKSpriteNode(imageNamed: "MyTeamsBackground")
    let ExitButton = SKSpriteNode(imageNamed: "PageExit")
    let PageBackButton = SKSpriteNode(imageNamed: "PageBack")
    let AddTeamButton = SKSpriteNode(imageNamed: "AddTeam")
    let TeamPageBack = SKSpriteNode(imageNamed: "PageBack")
    let TeamPageForward = SKSpriteNode(imageNamed: "PageForward")
    
    let Directions = SKLabelNode()
    
    var gameView = false
    var lazyCoding = 0
    
    var temp1 = SKShapeNode()
    var temp2 = SKShapeNode()
    var temp3 = SKShapeNode()
    var temp4 = SKShapeNode()
    var temp5 = SKShapeNode()
    var temp6 = SKShapeNode()
    var temp7 = SKShapeNode()
    var temp8 = SKShapeNode()
    var tempb = SKSpriteNode(imageNamed: "Label2")
    
    var temp1Rect = CGRect()
    var temp2Rect = CGRect()
    var temp3Rect = CGRect()
    var temp4Rect = CGRect()
    var temp5Rect = CGRect()
    var temp6Rect = CGRect()
    var temp7Rect = CGRect()
    var temp8Rect = CGRect()
    
    var temp1Label = SKLabelNode()
    var temp2Label = SKLabelNode()
    var temp3Label = SKLabelNode()
    var temp4Label = SKLabelNode()
    var temp5Label = SKLabelNode()
    var temp6Label = SKLabelNode()
    var temp7Label = SKLabelNode()
    var temp8Label = SKLabelNode()
    
    //Division
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
    
    let DivisionTeams:[String] = Array()
    
    //Page Arrays -> Capacity: 32
    var Page2Teams:[String] = ["None","None","None","None","None","None","None","None"]
    var Page3Teams:[String] = ["None","None","None","None","None","None","None","None"]
    var teamNames: [String] = Array()
    
    let AddTeamLabel = SKLabelNode()
    var TeamBannerRect = CGRect()
    var numberOfTeams = 0
    
    //League Info
    let League1 = SKSpriteNode(imageNamed: "Label")
    let League1Label = SKLabelNode()
    
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
        }catch _ as NSError{
            print("issue reading")
        }
        let lines:[String] = dataString.components(separatedBy: "\n")
        
        let divisions:[String] = lines[0].components(separatedBy: ".")
        
        var divisionSelector = -1
        for index in 0...divisions.count-1
        {
            if divisions[index] == defaults.string(forKey: "DivisionIdentifier")
            {
                divisionSelector = index + 1
            }
        }
        let DivisionTeams = lines[divisionSelector].components(separatedBy: ".")
        
        //Page 2
        if(DivisionTeams.count > 8)
        {
            var bound = 0
            if DivisionTeams.count >= 16
            {
                bound = 16
            }else{
                bound = DivisionTeams.count
            }
            for index in 8...bound-1
            {
                //Page2Teams.append(DivisionTeams[index])
                Page2Teams[index-8] = (DivisionTeams[index])
            }
        }
        
        //Page 3
        if(DivisionTeams.count > 16)
        {
            var bound = 0
            if DivisionTeams.count >= 24
            {
                bound = 24
            }else{
                bound = DivisionTeams.count
            }
            for index in 16...bound-1
            {
                //Page3Teams.append(DivisionTeams[index])
                Page3Teams[index-16] = (DivisionTeams[index])
            }
        }
        
        Background.size = self.size
        Background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        Background.zPosition = 0
        self.addChild(Background)
        
        //Adjustors
        if defaults.double(forKey: "FrameWidth") == 414
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
        AddTeamLabel.text = "Add Teams"
        AddTeamLabel.fontSize = CGFloat(40 * scaleModifier)
        AddTeamLabel.fontColor = SKColor.white
        AddTeamLabel.zPosition = 2
        self.addChild(AddTeamLabel)
        
        AddTeamButton.setScale(CGFloat(0.35 * scaleModifier))
        AddTeamButton.position = CGPoint(x: 9 * TeamBannerRect.width/10, y: TeamBannerRect.midY)
        AddTeamButton.zPosition = 2
        AddTeamButton.alpha = 0
        self.addChild(AddTeamButton)
        
        ExitButton.setScale(CGFloat(0.35 * scaleModifier))
        ExitButton.position = CGPoint(x: 9 * TeamBannerRect.width/10, y: TeamBannerRect.midY)
        ExitButton.zPosition = 2
        self.addChild(ExitButton)
        
        PageBackButton.setScale(CGFloat(0.35 * scaleModifier))
        PageBackButton.position = CGPoint(x: 1 * TeamBannerRect.width/10, y: TeamBannerRect.midY)
        PageBackButton.zPosition = 2
        self.addChild(PageBackButton)
        
        Directions.position = CGPoint(x: 5 * self.size.width/10, y: 8.3 * self.size.height/10)
        Directions.text = "Choose Your Team"
        Directions.fontSize = CGFloat(30 * scaleModifier)
        Directions.fontColor = SKColor.white
        Directions.zPosition = 2
        Directions.alpha = 1
        self.addChild(Directions)
        
        
        temp1Rect = CGRect(x: 2 * self.size.width/10, y: 7.25 * self.size.height/10, width: 6 * self.size.width/10, height: 1.25 * self.size.height/15)
        temp2Rect = CGRect(x: 2 * self.size.width/10, y: 6.25 * self.size.height/10, width: 6 * self.size.width/10, height: 1.25 * self.size.height/15)
        temp3Rect = CGRect(x: 2 * self.size.width/10, y: 5.25 * self.size.height/10, width: 6 * self.size.width/10, height: 1.25 * self.size.height/15)
        temp4Rect = CGRect(x: 2 * self.size.width/10, y: 4.25 * self.size.height/10, width: 6 * self.size.width/10, height: 1.25 * self.size.height/15)
        temp5Rect = CGRect(x: 2 * self.size.width/10, y: 3.25 * self.size.height/10, width: 6 * self.size.width/10, height: 1.25 * self.size.height/15)
        temp6Rect = CGRect(x: 2 * self.size.width/10, y: 2.25 * self.size.height/10, width: 6 * self.size.width/10, height: 1.25 * self.size.height/15)
        temp7Rect = CGRect(x: 2 * self.size.width/10, y: 1.25 * self.size.height/10, width: 6 * self.size.width/10, height: 1.25 * self.size.height/15)
        temp8Rect = CGRect(x: 2 * self.size.width/10, y: 0.25 * self.size.height/10, width: 6 * self.size.width/10, height: 1.25 * self.size.height/15)
        
        //Change Pages
        TeamPageForward.setScale(CGFloat(0.5 * scaleModifier))
        TeamPageForward.position = CGPoint(x: 9 * TeamBannerRect.width/10, y: temp8Rect.midY)
        TeamPageForward.zPosition = 2
        
        TeamPageBack.setScale(CGFloat(0.5 * scaleModifier))
        TeamPageBack.position = CGPoint(x: 1 * TeamBannerRect.width/10, y: temp8Rect.midY)
        TeamPageBack.zPosition = 2
        self.addChild(TeamPageBack)
        
        if Page3Teams[0] != "None"
        {
            self.addChild(TeamPageForward)
        }
        
        ///////////////////////////////////////////////////////////////////////////////////
        //Teams
        let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.75)
        teamNames = Page2Teams
        
        if teamNames[0] != "None"
        {
            //Team 1
            temp1 = SKShapeNode.init(rect: temp1Rect)
            temp1.fillColor = Colors.white
            temp1.zPosition = 1
            temp1.strokeColor = SKColor.black
            temp1.lineWidth = 2
            temp1.alpha = 0
            self.addChild(temp1)
            temp1Label.position = CGPoint(x: self.size.width/2, y: temp1Rect.midY)
            temp1Label.text = teamNames[0]
            temp1Label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            temp1Label.fontSize = CGFloat(27 * scaleModifier)
            temp1Label.fontColor = Colors.black
            temp1Label.zPosition = 11
            temp1Label.alpha = 0
            temp1Label.fontName = "HelveticaNeue-Light"
            self.addChild(temp1Label)
            
            temp1.run(fadeIn); temp1Label.run(fadeIn)
        }
        
        if teamNames[1] != "None"
        {
            //Team 2
            temp2 = SKShapeNode.init(rect: temp2Rect)
            temp2.fillColor = Colors.white
            temp2.zPosition = 1
            temp2.strokeColor = SKColor.black
            temp2.lineWidth = 2
            temp2.alpha = 0
            self.addChild(temp2)
            temp2Label.position = CGPoint(x: self.size.width/2, y: temp2Rect.midY)
            temp2Label.text = teamNames[1]
            temp2Label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            temp2Label.fontSize = CGFloat(27 * scaleModifier)
            temp2Label.fontColor = Colors.black
            temp2Label.zPosition = 11
            temp2Label.alpha = 0
            temp2Label.fontName = "HelveticaNeue-Light"
            self.addChild(temp2Label)
            
            temp2.run(fadeIn); temp2Label.run(fadeIn)
        }
        
        
        if teamNames[2] != "None"
        {
            //Team 3
            temp3 = SKShapeNode.init(rect: temp3Rect)
            temp3.fillColor = Colors.white
            temp3.zPosition = 1
            temp3.strokeColor = SKColor.black
            temp3.lineWidth = 2
            temp3.alpha = 0
            self.addChild(temp3)
            temp3Label.position = CGPoint(x: self.size.width/2, y: temp3Rect.midY)
            temp3Label.text = teamNames[2]
            temp3Label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            temp3Label.fontSize = CGFloat(27 * scaleModifier)
            temp3Label.fontColor = Colors.black
            temp3Label.zPosition = 11
            temp3Label.alpha = 0
            temp3Label.fontName = "HelveticaNeue-Light"
            self.addChild(temp3Label)
            
            temp3.run(fadeIn); temp3Label.run(fadeIn)
        }
        
        
        if teamNames[3] != "None"
        {
            //Team 4
            temp4 = SKShapeNode.init(rect: temp4Rect)
            temp4.fillColor = Colors.white
            temp4.zPosition = 1
            temp4.strokeColor = SKColor.black
            temp4.lineWidth = 2
            temp4.alpha = 0
            self.addChild(temp4)
            temp4Label.position = CGPoint(x: self.size.width/2, y: temp4Rect.midY)
            temp4Label.text = teamNames[3]
            temp4Label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            temp4Label.fontSize = CGFloat(27 * scaleModifier)
            temp4Label.fontColor = Colors.black
            temp4Label.zPosition = 11
            temp4Label.alpha = 0
            temp4Label.fontName = "HelveticaNeue-Light"
            self.addChild(temp4Label)
            
            temp4.run(fadeIn); temp4Label.run(fadeIn)
        }
        
        
        if teamNames[4] != "None"
        {
            //Team 5
            temp5 = SKShapeNode.init(rect: temp5Rect)
            temp5.fillColor = Colors.white
            temp5.zPosition = 1
            temp5.strokeColor = SKColor.black
            temp5.lineWidth = 2
            temp5.alpha = 0
            self.addChild(temp5)
            temp5Label.position = CGPoint(x: self.size.width/2, y: temp5Rect.midY)
            temp5Label.text = teamNames[4]
            temp5Label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            temp5Label.fontSize = CGFloat(27 * scaleModifier)
            temp5Label.fontColor = Colors.black
            temp5Label.zPosition = 11
            temp5Label.alpha = 0
            temp5Label.fontName = "HelveticaNeue-Light"
            self.addChild(temp5Label)
            
            temp5.run(fadeIn);
            temp5Label.run(fadeIn);
        }
        
        
        if teamNames[5] != "None"
        {
            //Team 6
            temp6 = SKShapeNode.init(rect: temp6Rect)
            temp6.fillColor = Colors.white
            temp6.zPosition = 1
            temp6.strokeColor = SKColor.black
            temp6.lineWidth = 2
            temp6.alpha = 0
            self.addChild(temp6)
            temp6Label.position = CGPoint(x: self.size.width/2, y: temp6Rect.midY)
            temp6Label.text = teamNames[5]
            temp6Label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            temp6Label.fontSize = CGFloat(27 * scaleModifier)
            temp6Label.fontColor = Colors.black
            temp6Label.zPosition = 11
            temp6Label.alpha = 0
            temp6Label.fontName = "HelveticaNeue-Light"
            self.addChild(temp6Label)
            
            temp6.run(fadeIn); temp6Label.run(fadeIn)
        }
        
        
        if teamNames[6] != "None"
        {
            //Team 7
            temp7 = SKShapeNode.init(rect: temp7Rect)
            temp7.fillColor = Colors.white
            temp7.zPosition = 1
            temp7.strokeColor = SKColor.black
            temp7.lineWidth = 2
            temp7.alpha = 0
            self.addChild(temp7)
            temp7Label.position = CGPoint(x: self.size.width/2, y: temp7Rect.midY)
            temp7Label.text = teamNames[6]
            temp7Label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            temp7Label.fontSize = CGFloat(27 * scaleModifier)
            temp7Label.fontColor = Colors.black
            temp7Label.zPosition = 11
            temp7Label.alpha = 0
            temp7Label.fontName = "HelveticaNeue-Light"
            self.addChild(temp7Label)
            
            temp7.run(fadeIn); temp7Label.run(fadeIn)
        }
        
        
        if teamNames[7] != "None"
        {
            //Team 8
            temp8 = SKShapeNode.init(rect: temp8Rect)
            temp8.fillColor = Colors.white
            temp8.zPosition = 1
            temp8.strokeColor = SKColor.black
            temp8.lineWidth = 2
            temp8.alpha = 0
            self.addChild(temp8)
            temp8Label.position = CGPoint(x: self.size.width/2, y: temp8Rect.midY)
            temp8Label.text = teamNames[7]
            temp8Label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            temp8Label.fontSize = CGFloat(27 * scaleModifier)
            temp8Label.fontColor = Colors.black
            temp8Label.zPosition = 11
            temp8Label.alpha = 0
            temp8Label.fontName = "HelveticaNeue-Light"
            self.addChild(temp8Label)
            
            temp8.run(fadeIn); temp8Label.run(fadeIn)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if defaults.string(forKey: "Team1") == "None"
        {
            numberOfTeams = 0
        }else{
            if defaults.string(forKey: "Team2") == "None"
            {
                numberOfTeams = 1
            }else{
                if defaults.string(forKey: "Team3") == "None"
                {
                    numberOfTeams = 2
                }else{
                    if defaults.string(forKey: "Team4") == "None"
                    {
                        numberOfTeams = 3
                    }else{
                        if defaults.string(forKey: "Team5") == "None"
                        {
                            numberOfTeams = 4
                        }
                    }
                }
            }
        }
        
        
        
        
        let path = Bundle.main.path(forResource: defaults.string(forKey: "League"), ofType: "txt")
        var dataString = ""
        do{
            dataString = try String (contentsOfFile: path!)
        }catch _ as NSError{
            print("issue reading")
        }
        let lines:[String] = dataString.components(separatedBy: "\n")
        
        let divisions:[String] = lines[0].components(separatedBy: ".")
        
        var divisionSelector = -1
        for index in 0...divisions.count-1
        {
            if divisions[index] == defaults.string(forKey: "DivisionIdentifier")
            {
                divisionSelector = index + 1
            }
        }
        
        
        //let DivisionTeams = lines[divisionSelector].components(separatedBy: ".")
        
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            
            //PageForward
            if Page3Teams[0] != "None"
            {
                if (pointOfTouch.x > 9 * self.size.width/10 - TeamPageForward.size.width/2 && pointOfTouch.x < 9 * self.size.width/10 + TeamPageForward.size.width/2) && (pointOfTouch.y < self.size.height - TeamPageForward.position.y + TeamPageForward.size.height/2 && pointOfTouch.y > self.size.height - TeamPageForward.position.y - TeamPageForward.size.height/2)
                {
                    moveToTeamsPage3()
                }
                
            }
            
            //Page Backward
            if (pointOfTouch.x > 1 * self.size.width/10 - TeamPageForward.size.width/2 && pointOfTouch.x < 1 * self.size.width/10 + TeamPageForward.size.width/2) && (pointOfTouch.y < self.size.height - TeamPageForward.position.y + TeamPageForward.size.height/2 && pointOfTouch.y > self.size.height - TeamPageForward.position.y - TeamPageForward.size.height/2)
            {
                moveToTeamsPage1()
            }
            
            
            var teamName = ""
            
            if gameView == false
            {
                if teamNames[0] != "None"
                {
                    //First Team
                    if (pointOfTouch.x > 5 * self.size.width/10 - temp1Rect.width/2 && pointOfTouch.x < 5 * self.size.width/10 + temp1Rect.width/2) && (pointOfTouch.y < 2.75 * self.size.height/10 + temp1Rect.height/2 && pointOfTouch.y > 2.75 * self.size.height/10 - temp1Rect.height/2)
                    {
                        lazyCoding = 1
                        teamName = temp1Label.text!
                        assignTeam(teamName: teamName)
                        
                        //print("hitZ:")
                        
                        let fadeOut = SKAction.fadeOut(withDuration: 0.375)
                        let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.375)
                        
                        AddTeamButton.run(fadeIn)
                        ExitButton.run(fadeOut)
                        
                        self.run(SKAction.run(slideOut))
                        let wait = SKAction.wait(forDuration: 0.75)
                        let changeScene = SKAction.run(teamAdded)
                        let sequence = SKAction.sequence([wait, changeScene])
                        self.run(sequence)
                    }
                }
                
                
                //Second Team
                if teamNames[1] != "None"
                {
                    if (pointOfTouch.x > 5 * self.size.width/10 - temp1Rect.width/2 && pointOfTouch.x < 5 * self.size.width/10 + temp1Rect.width/2) && (pointOfTouch.y < 3.75 * self.size.height/10 + temp1Rect.height/2 && pointOfTouch.y > 3.75 * self.size.height/10 - temp1Rect.height/2)
                    {
                        lazyCoding = 1
                        teamName = teamNames[1]
                        assignTeam(teamName: teamName)
                        
                        let fadeOut = SKAction.fadeOut(withDuration: 0.375)
                        let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.375)
                        
                        AddTeamButton.run(fadeIn)
                        ExitButton.run(fadeOut)
                        
                        self.run(SKAction.run(slideOut))
                        let wait = SKAction.wait(forDuration: 0.75)
                        let changeScene = SKAction.run(teamAdded)
                        let sequence = SKAction.sequence([wait, changeScene])
                        self.run(sequence)
                    }
                }
                
                
                //Third Team
                if teamNames[2] != "None"
                {
                    if (pointOfTouch.x > 5 * self.size.width/10 - temp1Rect.width/2 && pointOfTouch.x < 5 * self.size.width/10 + temp1Rect.width/2) && (pointOfTouch.y < 4.75 * self.size.height/10 + temp1Rect.height/2 && pointOfTouch.y > 4.75 * self.size.height/10 - temp1Rect.height/2)
                    {
                        lazyCoding = 1
                        teamName = teamNames[2]
                        assignTeam(teamName: teamName)
                        
                        let fadeOut = SKAction.fadeOut(withDuration: 0.375)
                        let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.375)
                        
                        AddTeamButton.run(fadeIn)
                        ExitButton.run(fadeOut)
                        
                        self.run(SKAction.run(slideOut))
                        let wait = SKAction.wait(forDuration: 0.75)
                        let changeScene = SKAction.run(teamAdded)
                        let sequence = SKAction.sequence([wait, changeScene])
                        self.run(sequence)
                    }
                }
                
                
                if teamNames[3] != "None"
                {
                    //Fourth Team
                    if (pointOfTouch.x > 5 * self.size.width/10 - temp1Rect.width/2 && pointOfTouch.x < 5 * self.size.width/10 + temp1Rect.width/2) && (pointOfTouch.y < 5.75 * self.size.height/10 + temp1Rect.height/2 && pointOfTouch.y > 5.75 * self.size.height/10 - temp1Rect.height/2)
                    {
                        lazyCoding = 1
                        teamName = teamNames[3]
                        assignTeam(teamName: teamName)
                        
                        let fadeOut = SKAction.fadeOut(withDuration: 0.375)
                        let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.375)
                        
                        AddTeamButton.run(fadeIn)
                        ExitButton.run(fadeOut)
                        
                        self.run(SKAction.run(slideOut))
                        let wait = SKAction.wait(forDuration: 0.75)
                        let changeScene = SKAction.run(teamAdded)
                        let sequence = SKAction.sequence([wait, changeScene])
                        self.run(sequence)
                    }
                }
                
                
                if teamNames[4] != "None"
                {
                    print(temp5Label.text!)
                    //Fifth Team
                    if (pointOfTouch.x > 5 * self.size.width/10 - temp1Rect.width/2 && pointOfTouch.x < 5 * self.size.width/10 + temp1Rect.width/2) && (pointOfTouch.y < 6.75 * self.size.height/10 + temp1Rect.height/2 && pointOfTouch.y > 6.75 * self.size.height/10 - temp1Rect.height/2)
                    {
                        lazyCoding = 1
                        teamName = teamNames[4]
                        assignTeam(teamName: teamName)
                        
                        let fadeOut = SKAction.fadeOut(withDuration: 0.375)
                        let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.375)
                        
                        AddTeamButton.run(fadeIn)
                        ExitButton.run(fadeOut)
                        
                        self.run(SKAction.run(slideOut))
                        let wait = SKAction.wait(forDuration: 0.75)
                        let changeScene = SKAction.run(teamAdded)
                        let sequence = SKAction.sequence([wait, changeScene])
                        self.run(sequence)
                    }
                }
                
                
                if teamNames[5] != "None"
                {
                    //Sixth Team
                    if (pointOfTouch.x > 5 * self.size.width/10 - temp1Rect.width/2 && pointOfTouch.x < 5 * self.size.width/10 + temp1Rect.width/2) && (pointOfTouch.y < 7.75 * self.size.height/10 + temp1Rect.height/2 && pointOfTouch.y > 7.75 * self.size.height/10 - temp1Rect.height/2)
                    {
                        lazyCoding = 1
                        teamName = teamNames[5]
                        assignTeam(teamName: teamName)
                        
                        let fadeOut = SKAction.fadeOut(withDuration: 0.375)
                        let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.375)
                        
                        AddTeamButton.run(fadeIn)
                        ExitButton.run(fadeOut)
                        
                        self.run(SKAction.run(slideOut))
                        let wait = SKAction.wait(forDuration: 0.75)
                        let changeScene = SKAction.run(teamAdded)
                        let sequence = SKAction.sequence([wait, changeScene])
                        self.run(sequence)
                    }
                }
                
                
                if teamNames[6] != "None"
                {
                    //Seventh Team
                    if (pointOfTouch.x > 5 * self.size.width/10 - temp1Rect.width/2 && pointOfTouch.x < 5 * self.size.width/10 + temp1Rect.width/2) && (pointOfTouch.y < 8.75 * self.size.height/10 + temp1Rect.height/2 && pointOfTouch.y > 8.75 * self.size.height/10 - temp1Rect.height/2)
                    {
                        lazyCoding = 1
                        teamName = teamNames[6]
                        assignTeam(teamName: teamName)
                        
                        let fadeOut = SKAction.fadeOut(withDuration: 0.375)
                        let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.375)
                        
                        AddTeamButton.run(fadeIn)
                        ExitButton.run(fadeOut)
                        
                        self.run(SKAction.run(slideOut))
                        let wait = SKAction.wait(forDuration: 0.75)
                        let changeScene = SKAction.run(teamAdded)
                        let sequence = SKAction.sequence([wait, changeScene])
                        self.run(sequence)
                    }
                }
                
                
                if teamNames[7] != "None"
                {
                    //Eigth Team
                    if (pointOfTouch.x > 5 * self.size.width/10 - temp1Rect.width/2 && pointOfTouch.x < 5 * self.size.width/10 + temp1Rect.width/2) && (pointOfTouch.y < 9.75 * self.size.height/10 + temp1Rect.height/2 && pointOfTouch.y > 9.75 * self.size.height/10 - temp1Rect.height/2)
                    {
                        lazyCoding = 1
                        teamName = teamNames[7]
                        assignTeam(teamName: teamName)
                        
                        let fadeOut = SKAction.fadeOut(withDuration: 0.375)
                        let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.375)
                        
                        AddTeamButton.run(fadeIn)
                        ExitButton.run(fadeOut)
                        
                        self.run(SKAction.run(slideOut))
                        let wait = SKAction.wait(forDuration: 0.75)
                        let changeScene = SKAction.run(teamAdded)
                        let sequence = SKAction.sequence([wait, changeScene])
                        self.run(sequence)
                    }
                }
            }
            
            //Back
            if (pointOfTouch.x > 1 * self.size.width/10 - AddTeamButton.size.width/2 && pointOfTouch.x < 1 * self.size.width/10 + AddTeamButton.size.width/2) && (pointOfTouch.y < self.size.height - AddTeamButton.position.y + AddTeamButton.size.height/2 && pointOfTouch.y > self.size.height - AddTeamButton.position.y - AddTeamButton.size.height/2)
            {
                self.run(SKAction.run(pageBack))
                
                let wait = SKAction.wait(forDuration: 0.75)
                let changeScene = SKAction.run(sceneLocalDivisions)
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
            
            let touchDelay = SKAction.wait(forDuration: 0.1)
            let changeVal = SKAction.run(changeGameViewVal)
            let SKSequence = SKAction.sequence([touchDelay,changeVal])
            self.run(SKSequence)
        }
    }
    
    func changeGameViewVal()
    {
        if lazyCoding == 1
        {
            gameView = true
        }else{
            gameView = false
        }
    }
    
    func assignTeam(teamName: String)
    {
        var combo = teamName
        combo += " ("; combo += String(defaults.string(forKey: "DivisionIdentifier")!);
        combo += ")"
        print(combo)
        
        var textIdentifier = String(defaults.string(forKey: "DivTextIdentifier")!)
        let addOn = String(teamName)
        textIdentifier += addOn
        print(textIdentifier)
        
        
        if defaults.string(forKey: "Team1") == "None"
        {
            defaults.set(combo, forKey: "Team1")
            defaults.set(textIdentifier, forKey: "Team1Txt")
        }else{
            if defaults.string(forKey: "Team2") == "None"
            {
                defaults.set(combo, forKey: "Team2")
                defaults.set(textIdentifier, forKey: "Team2Txt")
            }else{
                if defaults.string(forKey: "Team3") == "None"
                {
                    defaults.set(combo, forKey: "Team3")
                    defaults.set(textIdentifier, forKey: "Team3Txt")
                }else{
                    if defaults.string(forKey: "Team4") == "None"
                    {
                        defaults.set(combo, forKey: "Team4")
                        defaults.set(textIdentifier, forKey: "Team4Txt")
                    }else{
                        if defaults.string(forKey: "Team5") == "None"
                        {
                            print("Team 5 just got assigned")
                            defaults.set(combo, forKey: "Team5")
                            defaults.set(textIdentifier, forKey: "Team5Txt")
                            //print(defaults.string(forKey: "Team5")!)
                            //print(defaults.string(forKey: "Team5Txt")!)
                        }
                    }
                }
            }
        }
    }
    func moveToTeamsPage1()
    {
        let sceneToMoveTo = Teams(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func moveToTeamsPage3()
    {
        let sceneToMoveTo = TeamsPage3(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func slideOut()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        
        Directions.run(fadeOut)
        temp1.run(fadeOut); temp2.run(fadeOut); temp3.run(fadeOut); temp4.run(fadeOut); temp5.run(fadeOut); temp6.run(fadeOut); temp7.run(fadeOut); temp8.run(fadeOut)
        temp1Label.run(fadeOut); temp2Label.run(fadeOut); temp3Label.run(fadeOut); temp4Label.run(fadeOut); temp5Label.run(fadeOut); temp6Label.run(fadeOut); temp7Label.run(fadeOut); temp8Label.run(fadeOut)
        
        TeamPageForward.run(fadeOut)
        TeamPageBack.run(fadeOut)
    }
    
    func exitFade()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        
        let fadeOutExit = SKAction.fadeOut(withDuration: 0.25)
        let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.25)
        
        AddTeamButton.run(fadeIn)
        ExitButton.run(fadeOutExit)
        
        Directions.run(fadeOut)
        temp1.run(fadeOut); temp2.run(fadeOut); temp3.run(fadeOut); temp4.run(fadeOut); temp5.run(fadeOut); temp6.run(fadeOut); temp7.run(fadeOut); temp8.run(fadeOut)
        temp1Label.run(fadeOut); temp2Label.run(fadeOut); temp3Label.run(fadeOut); temp4Label.run(fadeOut); temp5Label.run(fadeOut); temp6Label.run(fadeOut); temp7Label.run(fadeOut); temp8Label.run(fadeOut)
        
        TeamPageForward.run(fadeOut)
        TeamPageBack.run(fadeOut)
    }
    
    func teamAdded()
    {
        if numberOfTeams == 0
        {
            defaults.set("None", forKey: "Team2")
            defaults.set("None", forKey: "Team3")
            defaults.set("None", forKey: "Team4")
            defaults.set("None", forKey: "Team5")
            
            defaults.set("None", forKey: "Team2Txt")
            defaults.set("None", forKey: "Team3Txt")
            defaults.set("None", forKey: "Team4Txt")
            defaults.set("None", forKey: "Team5Txt")
        }else{
            if numberOfTeams == 1
            {
                defaults.set("None", forKey: "Team3")
                defaults.set("None", forKey: "Team4")
                defaults.set("None", forKey: "Team5")
                
                defaults.set("None", forKey: "Team3Txt")
                defaults.set("None", forKey: "Team4Txt")
                defaults.set("None", forKey: "Team5Txt")
            }else{
                if numberOfTeams == 2
                {
                    defaults.set("None", forKey: "Team4")
                    defaults.set("None", forKey: "Team5")
                    
                    defaults.set("None", forKey: "Team4Txt")
                    defaults.set("None", forKey: "Team5Txt")
                }else{
                    if numberOfTeams == 3
                    {
                        defaults.set("None", forKey: "Team5")
                        
                        defaults.set("None", forKey: "Team5Txt")
                    }
                }
            }
        }
        
        
        if defaults.string(forKey: "Team5") == defaults.string(forKey: "Team4") && defaults.string(forKey: "Team4") != "None"
        {
            defaults.set("None", forKey: "Team5")
            defaults.set("None", forKey: "Team5Txt")
        }
        if defaults.string(forKey: "Team4") == defaults.string(forKey: "Team3") && defaults.string(forKey: "Team3") != "None"
        {
            defaults.set("None", forKey: "Team4")
            defaults.set("None", forKey: "Team4Txt")
        }
        if defaults.string(forKey: "Team3") == defaults.string(forKey: "Team2") && defaults.string(forKey: "Team2") != "None"
        {
            defaults.set("None", forKey: "Team3")
            defaults.set("None", forKey: "Team3Txt")
        }
        if defaults.string(forKey: "Team2") == defaults.string(forKey: "Team1") && defaults.string(forKey: "Team1") != "None"
        {
            defaults.set("None", forKey: "Team2")
            defaults.set("None", forKey: "Team2Txt")
        }
        
        let sceneToMoveTo = MyTeams(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func pageBack()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        
        Directions.run(fadeOut)
        temp1.run(fadeOut); temp2.run(fadeOut); temp3.run(fadeOut); temp4.run(fadeOut); temp5.run(fadeOut); temp6.run(fadeOut); temp7.run(fadeOut); temp8.run(fadeOut)
        temp1Label.run(fadeOut); temp2Label.run(fadeOut); temp3Label.run(fadeOut); temp4Label.run(fadeOut); temp5Label.run(fadeOut); temp6Label.run(fadeOut); temp7Label.run(fadeOut); temp8Label.run(fadeOut)
        
        TeamPageForward.run(fadeOut)
        TeamPageBack.run(fadeOut)
    }
    
    func sceneLocalDivisions()
    {
        let sceneToMoveTo = Divisions(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func sceneMyTeams()
    {
        if numberOfTeams == 0
        {
            defaults.set("None", forKey: "Team2")
            defaults.set("None", forKey: "Team3")
            defaults.set("None", forKey: "Team4")
            defaults.set("None", forKey: "Team5")
            
            defaults.set("None", forKey: "Team2Txt")
            defaults.set("None", forKey: "Team3Txt")
            defaults.set("None", forKey: "Team4Txt")
            defaults.set("None", forKey: "Team5Txt")
        }else{
            if numberOfTeams == 1
            {
                defaults.set("None", forKey: "Team3")
                defaults.set("None", forKey: "Team4")
                defaults.set("None", forKey: "Team5")
                
                defaults.set("None", forKey: "Team3Txt")
                defaults.set("None", forKey: "Team4Txt")
                defaults.set("None", forKey: "Team5Txt")
            }else{
                if numberOfTeams == 2
                {
                    defaults.set("None", forKey: "Team4")
                    defaults.set("None", forKey: "Team5")
                    
                    defaults.set("None", forKey: "Team4Txt")
                    defaults.set("None", forKey: "Team5Txt")
                }else{
                    if numberOfTeams == 3
                    {
                        defaults.set("None", forKey: "Team5")
                        
                        defaults.set("None", forKey: "Team5Txt")
                    }
                }
            }
        }
        
        let sceneToMoveTo = MyTeams(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
}
