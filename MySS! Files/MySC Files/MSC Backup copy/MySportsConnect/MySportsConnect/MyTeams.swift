//
//  MyTeams.swift
//  MySportsConnect
//
//  Created by ADAMLANE on 7/8/19.
//  Copyright © 2019 Nathan Beal Studios. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class MyTeams: SKScene
{
    //Sprite Node
    let Background = SKSpriteNode(imageNamed: "MSCBackground.")
    let AddTeamButton = SKSpriteNode(imageNamed: "AddTeam")
    let ExitButton = SKSpriteNode(imageNamed: "PageExit")
    let ExitDelete = SKSpriteNode(imageNamed: "PageExit")
    let DeleteTeamButton = SKSpriteNode(imageNamed: "DeleteTeamButton1")
    let RemoveTeam = SKSpriteNode(imageNamed: "DeleteTeamButton2")
    let MyScheduleLogo = SKSpriteNode(imageNamed: "MySchedule")
    let MyTeamsLogo = SKSpriteNode(imageNamed: "MyTeamLogo")
    
    //Teams
    var Team1 = SKShapeNode(); var Team1Rect = CGRect(); let Team1Label = SKLabelNode()
    var Team2 = SKShapeNode(); var Team2Rect = CGRect(); let Team2Label = SKLabelNode()
    var Team3 = SKShapeNode(); var Team3Rect = CGRect(); let Team3Label = SKLabelNode()
    var Team4 = SKShapeNode(); var Team4Rect = CGRect(); let Team4Label = SKLabelNode()
    var Team5 = SKShapeNode(); var Team5Rect = CGRect(); let Team5Label = SKLabelNode()
    
    //Banner
    var TeamBannerRect = CGRect(); var TeamBanner = SKShapeNode()
    var TeamBannerMenuRect = CGRect(); var TeamBannerMenu = SKShapeNode()
    
    //Bottom Labels
    let MySportsLabel = SKLabelNode(); let myTeamsLabel = SKLabelNode()
    let AddTeamLabel = SKLabelNode(); let myScheduleLabel = SKLabelNode()
    
    //Deleting Team Variables
    var deletingTeam = false
    var deletion = 0
    
    
    //Used for boundaries
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
    
    override func didMove(to view: SKView)
    {
        Team1Rect = CGRect(x: 1 * self.size.width/10, y: 7.375 * self.size.height/10, width: 8 * self.size.width/10, height: 1.25 * self.size.height/10)
        Team2Rect = CGRect(x: 1 * self.size.width/10, y: 5.875 * self.size.height/10, width: 8 * self.size.width/10, height: 1.25 * self.size.height/10)
        Team3Rect = CGRect(x: 1 * self.size.width/10, y: 4.375 * self.size.height/10, width: 8 * self.size.width/10, height: 1.25 * self.size.height/10)
        Team4Rect = CGRect(x: 1 * self.size.width/10, y: 2.875 * self.size.height/10, width: 8 * self.size.width/10, height: 1.25 * self.size.height/10)
        Team5Rect = CGRect(x: 1 * self.size.width/10, y: 1.375 * self.size.height/10, width: 8 * self.size.width/10, height: 1.25 * self.size.height/10)
        
        Background.size = self.size
        Background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        Background.zPosition = 0
        self.addChild(Background)
        
        if (defaults.double(forKey: "FrameWidth") == 414 && defaults.double(forKey: "FrameHeight") == 896) || (defaults.double(forKey: "FrameWidth") == 375 && defaults.double(forKey: "FrameHeight") == 812)
        {
            TeamBannerRect = CGRect(x: -0.1 * self.size.width/10, y: self.size.height - 1.25 * self.size.height/10, width: 1.02 * self.size.width, height: 1.27 * self.size.height/10)
            TeamBannerMenuRect = CGRect(x: -0.1 * self.size.width/10, y: -0.02 * self.size.height/10, width: 1.02 * self.size.width, height: 1.27 * self.size.height/10)
            MySportsLabel.position = CGPoint(x: self.size.width/2, y: 0.985 * TeamBannerRect.midY)
        }else{
            TeamBannerRect = CGRect(x: 0, y: self.size.height - 1.25 * self.size.height/10, width: self.size.width, height: 1.25 * self.size.height/10)
            TeamBannerMenuRect = CGRect(x: 0, y: 0, width: self.size.width, height: 1.25 * self.size.height/10)
            MySportsLabel.position = CGPoint(x: self.size.width/2, y: TeamBannerRect.midY)
        }
        
        //TeamBannerRect = CGRect(x: 0, y: self.size.height - 1.25 * self.size.height/10, width: self.size.width, height: 1.25 * self.size.height/10)
        TeamBanner = SKShapeNode.init(rect: TeamBannerRect)
        
        TeamBanner.fillColor = Colors.LafMaroon
        TeamBanner.zPosition = 1
        TeamBanner.strokeColor = SKColor.black
        TeamBanner.lineWidth = 4
        self.addChild(TeamBanner)
        
        TeamBannerMenu = SKShapeNode.init(rect: TeamBannerMenuRect)
        TeamBannerMenu.fillColor = Colors.LafMaroon
        TeamBannerMenu.zPosition = 10
        TeamBannerMenu.strokeColor = Colors.black
        TeamBannerMenu.lineWidth = 4
        
        MySportsLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        MySportsLabel.text = "MyTeams"
        MySportsLabel.fontName = "HelveticaNeue"
        MySportsLabel.fontSize = CGFloat(40 * scaleModifier)
        MySportsLabel.fontColor = SKColor.white
        MySportsLabel.zPosition = 10
        MySportsLabel.alpha = 0
        self.addChild(MySportsLabel)
        
        AddTeamButton.setScale(CGFloat(0.35 * scaleModifier))
        AddTeamButton.position = CGPoint(x: 9 * TeamBannerRect.width/10, y: MySportsLabel.position.y)
        AddTeamButton.zPosition = 2
        AddTeamButton.alpha = 0
        if defaults.string(forKey: "Team1") != "None" && defaults.string(forKey: "Team2") != "None" && defaults.string(forKey: "Team3") != "None" && defaults.string(forKey: "Team4") != "None" && defaults.string(forKey: "Team5") != "None"
        {
        }else{
            self.addChild(AddTeamButton)
        }
        
        ExitButton.position = CGPoint(x: 9 * TeamBannerRect.width/10, y:  MySportsLabel.position.y)
        ExitButton.setScale(CGFloat(0.35 * scaleModifier))
        ExitButton.zPosition = 2
        ExitButton.alpha = 0
        self.addChild(ExitButton)
        
        DeleteTeamButton.position = CGPoint(x: TeamBannerRect.width/10, y: MySportsLabel.position.y)
        DeleteTeamButton.setScale(CGFloat(0.35 * scaleModifier))
        DeleteTeamButton.zPosition = 2
        DeleteTeamButton.alpha = 0
        
        ExitDelete.position = CGPoint(x: TeamBannerRect.width/10, y: MySportsLabel.position.y)
        ExitDelete.setScale(CGFloat(0.35 * scaleModifier))
        ExitDelete.zPosition = 2
        ExitDelete.alpha = 0
        self.addChild(ExitDelete)
        
        RemoveTeam.setScale(CGFloat(0.45 * scaleModifier))
        RemoveTeam.zPosition = 2
        
        //MyTeams Logo
        MyTeamsLogo.setScale(CGFloat(1 * scaleModifier))
        MyTeamsLogo.position = CGPoint(x: TeamBannerMenuRect.midX/2, y: TeamBannerMenuRect.midY + (TeamBannerRect.midY/60))
        MyTeamsLogo.zPosition = 15
        
        myTeamsLabel.position = CGPoint(x: TeamBannerMenuRect.midX/2, y: TeamBannerMenuRect.midY - (TeamBannerRect.midY/20))
        myTeamsLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        myTeamsLabel.text = "MyTeams"
        myTeamsLabel.fontName = "HelveticaNeue"
        myTeamsLabel.fontSize = CGFloat(15 * scaleModifier)
        myTeamsLabel.fontColor = SKColor.white
        myTeamsLabel.zPosition = 15
        
        //MySchedule Logo
        MyScheduleLogo.setScale(CGFloat(1 * scaleModifier))
        MyScheduleLogo.position = CGPoint(x: 3 * TeamBannerMenuRect.midX/2, y: TeamBannerMenuRect.midY + (TeamBannerRect.midY/60))
        MyScheduleLogo.zPosition = 15
        
        myScheduleLabel.position = CGPoint(x: 3 * TeamBannerMenuRect.midX/2, y: TeamBannerMenuRect.midY - (TeamBannerRect.midY/20))
        myScheduleLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        myScheduleLabel.text = "MySchedule"
        myScheduleLabel.fontName = "HelveticaNeue"
        myScheduleLabel.fontSize = CGFloat(15 * scaleModifier)
        myScheduleLabel.fontColor = SKColor.white
        myScheduleLabel.zPosition = 15
        
        let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.5)
        
        
        //Menu
        if defaults.string(forKey: "Team1") == "None" && defaults.string(forKey: "Team2") == "None" && defaults.string(forKey: "Team3") == "None" && defaults.string(forKey: "Team4") == "None" && defaults.string(forKey: "Team5") == "None"
        {}else{
            self.addChild(DeleteTeamButton)
            self.addChild(TeamBannerMenu)
            self.addChild(MyScheduleLogo)
            self.addChild(myScheduleLabel)
            self.addChild(MyTeamsLogo)
            self.addChild(myTeamsLabel)
        }
        
        if defaults.string(forKey: "Team1") != "None"
        {
            let path = Bundle.main.path(forResource: defaults.string(forKey: "Team1Txt"), ofType: "txt")
            var dataString = ""
            do{ dataString = try String (contentsOfFile: path!)}catch _ as NSError{}
            let lines:[String] = dataString.components(separatedBy: "\n")
            let colors = lines[0].components(separatedBy: ".")
            let team1Colors = colorScheme(primaryColor: colors[0], secondaryColor: colors[1])
            
            Team1 = SKShapeNode.init(rect: Team1Rect)
            Team1.fillColor = team1Colors[0]
            Team1.zPosition = 10
            Team1.strokeColor = SKColor.black
            Team1.lineWidth = 4
            
            Team1Label.position = CGPoint(x: self.size.width/2, y: Team1Rect.midY)
            Team1Label.text = defaults.string(forKey: "Team1")
            Team1Label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            Team1Label.fontSize = CGFloat(28 * scaleModifier)
            Team1Label.fontColor = team1Colors[1]
            Team1Label.zPosition = 11
            Team1Label.fontName = "Avenir-BlackOblique"
            Team1Label.alpha = 0
            
            self.addChild(Team1)
            self.addChild(Team1Label)
            
            let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.5)
            Team1.run(fadeIn)
            Team1Label.run(fadeIn)
        }
        if defaults.string(forKey: "Team2") != "None"
        {
            let path = Bundle.main.path(forResource: defaults.string(forKey: "Team2Txt"), ofType: "txt")
            var dataString = ""
            do{ dataString = try String (contentsOfFile: path!)}catch _ as NSError{}
            let lines:[String] = dataString.components(separatedBy: "\n")
            let colors = lines[0].components(separatedBy: ".")
            let team2Colors = colorScheme(primaryColor: colors[0], secondaryColor: colors[1])
            
            Team2 = SKShapeNode.init(rect: Team2Rect)
            Team2.fillColor = team2Colors[0]
            Team2.zPosition = 10
            Team2.strokeColor = SKColor.black
            Team2.lineWidth = 4
            
            Team2Label.position = CGPoint(x: self.size.width/2, y: Team2Rect.midY)
            Team2Label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            Team2Label.text = defaults.string(forKey: "Team2")
            Team2Label.fontSize = CGFloat(28 * scaleModifier)
            Team2Label.fontColor = team2Colors[1]
            Team2Label.zPosition = 11
            Team2Label.fontName = "Avenir-BlackOblique"
            Team2Label.alpha = 0
            
            self.addChild(Team2)
            self.addChild(Team2Label)
            
            let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.5)
            Team2.run(fadeIn)
            Team2Label.run(fadeIn)
        }
        
        if defaults.string(forKey: "Team3") != "None"
        {
            let path3 = Bundle.main.path(forResource: defaults.string(forKey: "Team3Txt"), ofType: "txt")
            var dataString3 = ""
            do{ dataString3 = try String (contentsOfFile: path3!)}catch _ as NSError{}
            let lines3:[String] = dataString3.components(separatedBy: "\n")
            let colors3 = lines3[0].components(separatedBy: ".")
            let team3Colors = colorScheme(primaryColor: colors3[0], secondaryColor: colors3[1])
            
            Team3 = SKShapeNode.init(rect: Team3Rect)
            Team3.fillColor = team3Colors[0]
            Team3.zPosition = 10
            Team3.strokeColor = SKColor.black
            Team3.lineWidth = 4
            
            Team3Label.position = CGPoint(x: self.size.width/2, y: Team3Rect.midY)
            Team3Label.text = defaults.string(forKey: "Team3")
            Team3Label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            Team3Label.fontSize = CGFloat(28 * scaleModifier)
            Team3Label.fontColor = team3Colors[1]
            Team3Label.zPosition = 11
            Team3Label.fontName = "Avenir-BlackOblique"
            Team3Label.alpha = 0
            
            self.addChild(Team3)
            self.addChild(Team3Label)
            
            let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.5)
            Team3.run(fadeIn)
            Team3Label.run(fadeIn)
        }
        if defaults.string(forKey: "Team4") != "None"
        {
            let path4 = Bundle.main.path(forResource: defaults.string(forKey: "Team4Txt"), ofType: "txt")
            var dataString4 = ""
            do{ dataString4 = try String (contentsOfFile: path4!)}catch _ as NSError{}
            let lines4:[String] = dataString4.components(separatedBy: "\n")
            let colors4 = lines4[0].components(separatedBy: ".")
            let team4Colors = colorScheme(primaryColor: colors4[0], secondaryColor: colors4[1])
            
            Team4 = SKShapeNode.init(rect: Team4Rect)
            Team4.fillColor = team4Colors[0]
            Team4.zPosition = 10
            Team4.strokeColor = SKColor.black
            Team4.lineWidth = 4
            
            Team4Label.position = CGPoint(x: self.size.width/2, y: Team4Rect.midY)
            Team4Label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            Team4Label.text = defaults.string(forKey: "Team4")
            Team4Label.fontSize = CGFloat(28 * scaleModifier)
            Team4Label.fontColor = team4Colors[1]
            Team4Label.zPosition = 11
            Team4Label.fontName = "Avenir-BlackOblique"
            Team4Label.alpha = 0
            
            self.addChild(Team4)
            self.addChild(Team4Label)
            
            let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.5)
            Team4.run(fadeIn)
            Team4Label.run(fadeIn)
        }
        
        if defaults.string(forKey: "Team5") != "None"
        {
            let path5 = Bundle.main.path(forResource: defaults.string(forKey: "Team5Txt"), ofType: "txt")
            var dataString5 = ""
            do{ dataString5 = try String (contentsOfFile: path5!)}catch _ as NSError{}
            let lines5:[String] = dataString5.components(separatedBy: "\n")
            let colors5 = lines5[0].components(separatedBy: ".")
            let team5Colors = colorScheme(primaryColor: colors5[0], secondaryColor: colors5[1])
            
            Team5 = SKShapeNode.init(rect: Team5Rect)
            Team5.fillColor = team5Colors[0]
            Team5.zPosition = 10
            Team5.strokeColor = SKColor.black
            Team5.lineWidth = 4
            
            Team5Label.position = CGPoint(x: self.size.width/2, y: Team5Rect.midY)
            Team5Label.text = defaults.string(forKey: "Team5")
            Team5Label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            Team5Label.fontSize = CGFloat(28 * scaleModifier)
            Team5Label.fontColor = team5Colors[1]
            Team5Label.zPosition = 11
            Team5Label.fontName = "Avenir-BlackOblique"
            Team5Label.alpha = 0
            
            self.addChild(Team5)
            self.addChild(Team5Label)
            
            let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.5)
            Team5.run(fadeIn)
            Team5Label.run(fadeIn)
        }
        
        //let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.5)
        MySportsLabel.run(fadeIn)
        AddTeamButton.run(fadeIn)
        DeleteTeamButton.run(fadeIn)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            
            //print(defaults.string(forKey: "Team6")!)
            if defaults.string(forKey: "Team1") != "None" && defaults.string(forKey: "Team2") != "None" && defaults.string(forKey: "Team3") != "None" && defaults.string(forKey: "Team4") != "None" && defaults.string(forKey: "Team5") != "None" && defaults.string(forKey: "Team6") != "None"
            {
                //print("locked up")
            }else{
                if deletingTeam == true
                {
                    let fadeOut = SKAction.fadeOut(withDuration: 0.375)
                    let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.375)
                    
                    //Stop
                    if (pointOfTouch.x > 1 * self.size.width/10 - AddTeamButton.size.width/2 && pointOfTouch.x < 1 * self.size.width/10 + AddTeamButton.size.width/2) && (pointOfTouch.y < self.size.height - AddTeamButton.position.y + AddTeamButton.size.height/2 && pointOfTouch.y > self.size.height - AddTeamButton.position.y - AddTeamButton.size.height/2)
                    {
                        ExitDelete.run(fadeOut)
                        RemoveTeam.removeFromParent()
                        DeleteTeamButton.run(fadeIn)
                        deletion = 0
                        
                        
                        if defaults.string(forKey: "Team1") != "None" && defaults.string(forKey: "Team2") != "None" && defaults.string(forKey: "Team3") != "None" && defaults.string(forKey: "Team4") != "None" && defaults.string(forKey: "Team5") != "None"
                        {
                            Team5.run(SKAction.moveBy(x: -0.75 * self.size.width/10, y: 0, duration: 0.25))
                            Team5Label.run(SKAction.moveBy(x: -0.75 * self.size.width/10, y: 0, duration: 0.25))
                        }else{
                            if defaults.string(forKey: "Team1") != "None" && defaults.string(forKey: "Team2") != "None" && defaults.string(forKey: "Team3") != "None" && defaults.string(forKey: "Team4") != "None" && defaults.string(forKey: "Team5") == "None"
                            {
                                Team4.run(SKAction.moveBy(x: -0.75 * self.size.width/10, y: 0, duration: 0.25))
                                Team4Label.run(SKAction.moveBy(x: -0.75 * self.size.width/10, y: 0, duration: 0.25))
                            }else{
                                if defaults.string(forKey: "Team1") != "None" && defaults.string(forKey: "Team2") != "None" && defaults.string(forKey: "Team3") != "None" && defaults.string(forKey: "Team4") == "None" && defaults.string(forKey: "Team5") == "None"
                                {
                                    Team3.run(SKAction.moveBy(x: -0.75 * self.size.width/10, y: 0, duration: 0.25))
                                    Team3Label.run(SKAction.moveBy(x: -0.75 * self.size.width/10, y: 0, duration: 0.25))
                                }else{
                                    if defaults.string(forKey: "Team1") != "None" && defaults.string(forKey: "Team2") != "None" && defaults.string(forKey: "Team3") == "None" && defaults.string(forKey: "Team4") == "None" && defaults.string(forKey: "Team5") == "None"
                                    {
                                        Team2.run(SKAction.moveBy(x: -0.75 * self.size.width/10, y: 0, duration: 0.25))
                                        Team2Label.run(SKAction.moveBy(x: -0.75 * self.size.width/10, y: 0, duration: 0.25))
                                    }else{
                                        if defaults.string(forKey: "Team1") != "None" && defaults.string(forKey: "Team2") == "None" && defaults.string(forKey: "Team3") == "None" && defaults.string(forKey: "Team4") == "None" && defaults.string(forKey: "Team5") == "None"
                                        {
                                            Team1.run(SKAction.moveBy(x: -0.75 * self.size.width/10, y: 0, duration: 0.25))
                                            Team1Label.run(SKAction.moveBy(x: -0.75 * self.size.width/10, y: 0, duration: 0.25))
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                    
                    //Remove Team 5
                    if (pointOfTouch.x > 2 * self.size.width/20 - RemoveTeam.size.width/2 && pointOfTouch.x < 2 * self.size.width/20 + RemoveTeam.size.width/2) && (pointOfTouch.y < self.size.height - Team5Rect.midY + RemoveTeam.size.height/2 && pointOfTouch.y > self.size.height - Team5Rect.midY - RemoveTeam.size.height/2)
                    {
                        defaults.set("None", forKey: "Team5")
                        defaults.set("None", forKey: "Team5Txt")
                        
                        RemoveTeam.removeFromParent()
                        Team5.removeFromParent()
                        Team5Label.removeFromParent()
                        
                        self.addChild(AddTeamButton)
                        ExitDelete.run(fadeOut)
                        RemoveTeam.removeFromParent()
                        DeleteTeamButton.run(fadeIn)
                        deletion = 0
                    }
                    
                    //Remove Team 4
                    if (pointOfTouch.x > 2 * self.size.width/20 - RemoveTeam.size.width/2 && pointOfTouch.x < 2 * self.size.width/20 + RemoveTeam.size.width/2) && (pointOfTouch.y < self.size.height - Team4Rect.midY + RemoveTeam.size.height/2 && pointOfTouch.y > self.size.height - Team4Rect.midY - RemoveTeam.size.height/2)
                    {
                        defaults.set("None", forKey: "Team4")
                        defaults.set("None", forKey: "Team4Txt")
                        
                        RemoveTeam.removeFromParent()
                        Team4.removeFromParent()
                        Team4Label.removeFromParent()
                        
                        ExitDelete.run(fadeOut)
                        RemoveTeam.removeFromParent()
                        DeleteTeamButton.run(fadeIn)
                        deletion = 0
                    }
                    
                    //Remove Team 3
                    if (pointOfTouch.x > 2 * self.size.width/20 - RemoveTeam.size.width/2 && pointOfTouch.x < 2 * self.size.width/20 + RemoveTeam.size.width/2) && (pointOfTouch.y < self.size.height - Team3Rect.midY + RemoveTeam.size.height/2 && pointOfTouch.y > self.size.height - Team3Rect.midY - RemoveTeam.size.height/2)
                    {
                        defaults.set("None", forKey: "Team3")
                        defaults.set("None", forKey: "Team3Txt")
                        
                        RemoveTeam.removeFromParent()
                        Team3.removeFromParent()
                        Team3Label.removeFromParent()
                        
                        ExitDelete.run(fadeOut)
                        RemoveTeam.removeFromParent()
                        DeleteTeamButton.run(fadeIn)
                        deletion = 0
                    }
                    //Remove Team 2
                    if (pointOfTouch.x > 2 * self.size.width/20 - RemoveTeam.size.width/2 && pointOfTouch.x < 2 * self.size.width/20 + RemoveTeam.size.width/2) && (pointOfTouch.y < self.size.height - Team2Rect.midY + RemoveTeam.size.height/2 && pointOfTouch.y > self.size.height - Team2Rect.midY - RemoveTeam.size.height/2)
                    {
                        defaults.set("None", forKey: "Team2")
                        defaults.set("None", forKey: "Team2Txt")
                        
                        RemoveTeam.removeFromParent()
                        Team2.removeFromParent()
                        Team2Label.removeFromParent()
                        
                        ExitDelete.run(fadeOut)
                        RemoveTeam.removeFromParent()
                        DeleteTeamButton.run(fadeIn)
                        deletion = 0
                    }
                    
                    //Remove Team 1
                    if (pointOfTouch.x > 2 * self.size.width/20 - RemoveTeam.size.width/2 && pointOfTouch.x < 2 * self.size.width/20 + RemoveTeam.size.width/2) && (pointOfTouch.y < self.size.height - Team1Rect.midY + RemoveTeam.size.height/2 && pointOfTouch.y > self.size.height - Team1Rect.midY - RemoveTeam.size.height/2)
                    {
                        defaults.set("None", forKey: "Team1")
                        defaults.set("None", forKey: "Team1Txt")
                        
                        RemoveTeam.removeFromParent()
                        Team1.position = CGPoint(x: 1 * selfWidth/10, y: 12 * selfHeight/10)
                        Team1Label.removeFromParent();
                        
                        ExitDelete.run(fadeOut)
                        RemoveTeam.removeFromParent()
                        DeleteTeamButton.run(fadeIn)
                        deletion = 0
                        
                        TeamBannerMenu.removeFromParent()
                        DeleteTeamButton.removeFromParent()
                        myTeamsLabel.removeFromParent()
                        MyTeamsLogo.removeFromParent()
                        MyScheduleLogo.removeFromParent()
                        myScheduleLabel.removeFromParent()
                    }
                }
                
                if deletingTeam == false
                {
                    //Add Button
                    if (pointOfTouch.x > 9 * self.size.width/10 - AddTeamButton.size.width/2 && pointOfTouch.x < 9 * self.size.width/10 + AddTeamButton.size.width/2) && (pointOfTouch.y < self.size.height - AddTeamButton.position.y + AddTeamButton.size.height/2 && pointOfTouch.y > self.size.height - AddTeamButton.position.y - AddTeamButton.size.height/2)
                    {
                        //MySportsLabel
                        let labelFadeOut = SKAction.fadeOut(withDuration: 0.75)
                        let fadeOut = SKAction.fadeOut(withDuration: 0.375)
                        let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.375)
                        
                        AddTeamButton.run(fadeOut)
                        ExitButton.run(fadeIn)
                        
                        self.run(SKAction.run(fadeOutAddTeams))
                        
                        let wait = SKAction.wait(forDuration: 0.5)
                        let changeScene = SKAction.run(AddTeamScene)
                        MySportsLabel.run(labelFadeOut)
                        let sequence = SKAction.sequence([wait, changeScene])
                        self.run(sequence)
                    }
                    
                    
                    //Delete Button
                    if defaults.string(forKey: "Team1") == "None"
                    {
                    }else{
                        if (pointOfTouch.x > 1 * self.size.width/10 - AddTeamButton.size.width/2 && pointOfTouch.x < 1 * self.size.width/10 + AddTeamButton.size.width/2) && (pointOfTouch.y < 0.75 * self.size.height/10 + AddTeamButton.size.height/2 && pointOfTouch.y > 0.75 * self.size.height/10 - AddTeamButton.size.height/2)
                        {
                            let fadeOut = SKAction.fadeOut(withDuration: 0.375)
                            let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.375)
                            //let moveBy = SKAction.moveTo(y: 6 * self.size.width/10, duration: 0.5)
                            DeleteTeamButton.run(fadeOut)
                            ExitDelete.run(fadeIn)
                            
                            if defaults.string(forKey: "Team5") != "None"
                            {
                                Team5.run(SKAction.moveBy(x: 0.75 * self.size.width/10, y: 0, duration: 0.25))
                                Team5Label.run(SKAction.moveBy(x: 0.75 * self.size.width/10, y: 0, duration: 0.25))
                                //print("HERE")
                                RemoveTeam.position = CGPoint(x: 2 * self.size.width/20, y: Team5Rect.midY)
                                self.addChild(RemoveTeam)
                            }else{
                                if defaults.string(forKey: "Team4") != "None"
                                {
                                    Team4.run(SKAction.moveBy(x: 0.75 * self.size.width/10, y: 0, duration: 0.25))
                                    Team4Label.run(SKAction.moveBy(x: 0.75 * self.size.width/10, y: 0, duration: 0.25))
                                    RemoveTeam.position = CGPoint(x: 2 * self.size.width/20, y: Team4Rect.midY)
                                    self.addChild(RemoveTeam)
                                }else{
                                    if defaults.string(forKey: "Team3") != "None"
                                    {
                                        Team3.run(SKAction.moveBy(x: 0.75 * self.size.width/10, y: 0, duration: 0.25))
                                        Team3Label.run(SKAction.moveBy(x: 0.75 * self.size.width/10, y: 0, duration: 0.25))
                                        RemoveTeam.position = CGPoint(x: 2 * self.size.width/20, y: Team3Rect.midY)
                                        self.addChild(RemoveTeam)
                                    }else{
                                        if defaults.string(forKey: "Team2") != "None"
                                        {
                                            Team2.run(SKAction.moveBy(x: 0.75 * self.size.width/10, y: 0, duration: 0.25))
                                            Team2Label.run(SKAction.moveBy(x: 0.75 * self.size.width/10, y: 0, duration: 0.25))
                                            RemoveTeam.position = CGPoint(x: 2 * self.size.width/20, y: Team2Rect.midY)
                                            self.addChild(RemoveTeam)
                                        }else{
                                            if defaults.string(forKey: "Team1") != "None"
                                            {
                                                Team1.run(SKAction.moveBy(x: 0.75 * self.size.width/10, y: 0, duration: 0.25))
                                                Team1Label.run(SKAction.moveBy(x: 0.75 * self.size.width/10, y: 0, duration: 0.25))
                                                RemoveTeam.position = CGPoint(x: 2 * self.size.width/20, y: Team1Rect.midY)
                                                self.addChild(RemoveTeam)
                                            }
                                        }
                                    }
                                }
                            }
                            deletion = 1
                        }
                    }
                }
            }
            
            //Moves to team pages
            if defaults.string(forKey: "Team1") != "None"
            {
                if (pointOfTouch.x > 5 * self.size.width/10 - Team1Rect.width/2 && pointOfTouch.x < 5 * self.size.width/10 + Team1Rect.width/2) && (pointOfTouch.y < 2.625 * self.size.height/10 + Team1Rect.height/2 && pointOfTouch.y > 2.625 * self.size.height/10 - Team1Rect.height/2)
                {
                    self.run(SKAction.run(fadeOutAddTeams))
                    
                    let wait = SKAction.wait(forDuration: 0.5)
                    let changeScene = SKAction.run(team1Page)
                    let sequence = SKAction.sequence([wait, changeScene])
                    self.run(sequence)
                }
            }
            
            if defaults.string(forKey: "Team2") != "None"
            {
                if (pointOfTouch.x > 5 * self.size.width/10 - Team1Rect.width/2 && pointOfTouch.x < 5 * self.size.width/10 + Team1Rect.width/2) && (pointOfTouch.y < 4.125 * self.size.height/10 + Team1Rect.height/2 && pointOfTouch.y > 4.125 * self.size.height/10 - Team1Rect.height/2)
                {
                    self.run(SKAction.run(fadeOutAddTeams))
                    
                    let wait = SKAction.wait(forDuration: 0.5)
                    let changeScene = SKAction.run(team2Page)
                    let sequence = SKAction.sequence([wait, changeScene])
                    self.run(sequence)
                }
            }
            
            if defaults.string(forKey: "Team3") != "None"
            {
                if (pointOfTouch.x > 5 * self.size.width/10 - Team1Rect.width/2 && pointOfTouch.x < 5 * self.size.width/10 + Team1Rect.width/2) && (pointOfTouch.y < 5.625 * self.size.height/10 + Team1Rect.height/2 && pointOfTouch.y > 5.625 * self.size.height/10 - Team1Rect.height/2)
                {
                    self.run(SKAction.run(fadeOutAddTeams))
                    
                    let wait = SKAction.wait(forDuration: 0.5)
                    let changeScene = SKAction.run(team3Page)
                    let sequence = SKAction.sequence([wait, changeScene])
                    self.run(sequence)
                }
            }
            
            if defaults.string(forKey: "Team4") != "None"
            {
                if (pointOfTouch.x > 5 * self.size.width/10 - Team1Rect.width/2 && pointOfTouch.x < 5 * self.size.width/10 + Team1Rect.width/2) && (pointOfTouch.y < 7.125 * self.size.height/10 + Team1Rect.height/2 && pointOfTouch.y > 7.125 * self.size.height/10 - Team1Rect.height/2)
                {
                    self.run(SKAction.run(fadeOutAddTeams))
                    
                    let wait = SKAction.wait(forDuration: 0.5)
                    let changeScene = SKAction.run(team4Page)
                    let sequence = SKAction.sequence([wait, changeScene])
                    self.run(sequence)
                }
            }
            
            if defaults.string(forKey: "Team5") != "None"
            {
                if (pointOfTouch.x > 5 * self.size.width/10 - Team1Rect.width/2 && pointOfTouch.x < 5 * self.size.width/10 + Team1Rect.width/2) && (pointOfTouch.y < 8.625 * self.size.height/10 + Team1Rect.height/2 && pointOfTouch.y > 8.625 * self.size.height/10 - Team1Rect.height/2)
                {
                    self.run(SKAction.run(fadeOutAddTeams))
                    
                    let wait = SKAction.wait(forDuration: 0.5)
                    let changeScene = SKAction.run(team5Page)
                    let sequence = SKAction.sequence([wait, changeScene])
                    self.run(sequence)
                }
            }
            
            //Menu Bar
            if defaults.string(forKey: "Team1") == "None" && defaults.string(forKey: "Team2") == "None" && defaults.string(forKey: "Team3") == "None" && defaults.string(forKey: "Team4") == "None" && defaults.string(forKey: "Team5") == "None"
            {}else{
                if (pointOfTouch.x > 7.5 * self.size.width/10 - Team1Rect.width/4 && pointOfTouch.x < 7.5 * self.size.width/10 + Team1Rect.width/4) && (pointOfTouch.y < self.size.height && pointOfTouch.y > self.size.height - Team1Rect.height)
                {
                    self.run(SKAction.run(fadeOutPage))
                    
                    let wait = SKAction.wait(forDuration: 0.5)
                    let changeScene = SKAction.run(mySchedulePage)
                    let sequence = SKAction.sequence([wait, changeScene])
                    self.run(sequence)
                }
            }
            deleteVals()
        }
    }
    
    func deleteVals()
    {
        if deletion == 0
        {
            deletingTeam = false
        }else{
            deletingTeam = true
        }
    }
    
    func AddTeamScene()
    {
        let sceneToMoveTo = Leagues(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func team1Page()
    {
        let sceneToMoveTo = Team1HomePage(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func team2Page()
    {
        let sceneToMoveTo = Team2HomePage(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    func team3Page()
    {
        let sceneToMoveTo = Team3HomePage(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    func team4Page()
    {
        let sceneToMoveTo = Team4HomePage(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    func team5Page()
    {
        let sceneToMoveTo = Team5HomePage(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func fadeOutPage()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        
        MySportsLabel.run(fadeOut); AddTeamButton.run(fadeOut); DeleteTeamButton.run(fadeOut)
        
        //Teams
        Team1.run(fadeOut); Team1Label.run(fadeOut)
        Team2.run(fadeOut); Team2Label.run(fadeOut)
        Team3.run(fadeOut); Team3Label.run(fadeOut)
        Team4.run(fadeOut); Team4Label.run(fadeOut)
        Team5.run(fadeOut); Team5Label.run(fadeOut)
        
        let systemWait = SKAction.wait(forDuration: 0.5)
        self.run(systemWait)
    }
    
    func fadeOutAddTeams()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        
        MySportsLabel.run(fadeOut); AddTeamButton.run(fadeOut); DeleteTeamButton.run(fadeOut); TeamBannerMenu.run(fadeOut); myScheduleLabel.run(fadeOut); MyScheduleLogo.run(fadeOut); myTeamsLabel.run(fadeOut); MyTeamsLogo.run(fadeOut); TeamBanner.run(fadeOut)
        
        //Teams
        Team1.run(fadeOut); Team1Label.run(fadeOut)
        Team2.run(fadeOut); Team2Label.run(fadeOut)
        Team3.run(fadeOut); Team3Label.run(fadeOut)
        Team4.run(fadeOut); Team4Label.run(fadeOut)
        Team5.run(fadeOut); Team5Label.run(fadeOut)
        
        let systemWait = SKAction.wait(forDuration: 0.5)
        self.run(systemWait)
    }
    
    func mySchedulePage()
    {
        let sceneToMoveTo = MySchedule(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func colorScheme(primaryColor: String, secondaryColor: String) -> Array<SKColor>
    {
        var colorArray = [SKColor]()
        
        //print(primaryColor)
        var teamColor = SKColor.white
        if primaryColor == "AthleticGreen"
        {
            teamColor = Colors.AthleticGreen
        }
        if primaryColor == "AstrosNavy"
        {
            teamColor = Colors.AstrosNavy
        }
        if primaryColor == "AstrosOrange"
        {
            teamColor = Colors.AstrosOrange
        }
        if primaryColor == "BlueJaysBlue"
        {
            teamColor = Colors.BlueJaysBlue
        }
        if primaryColor == "CubsBlue"
        {
            teamColor = Colors.CubsBlue
        }
        if primaryColor == "AngelsMaroon"
        {
            teamColor = Colors.AngelsMaroon
        }
        if primaryColor == "MetsBlue"
        {
            teamColor = Colors.MetsBlue
        }
        if primaryColor == "NationalsRed"
        {
            teamColor = Colors.NationalsRed
        }
        if primaryColor == "RedSoxRed"
        {
            teamColor = Colors.RedSoxRed
        }
        if primaryColor == "YankeesNavy"
        {
            teamColor = Colors.YankeesNavy
        }
        if primaryColor == "CardinalsRed"
        {
            teamColor = Colors.CardinalsRed
        }
        if primaryColor == "GiantsOrange"
        {
            teamColor = Colors.GiantsOrange
        }
        if primaryColor == "BrewersGold"
        {
            teamColor = Colors.BrewersGold
        }
        if primaryColor == "PhilliesRed"
        {
            teamColor = Colors.PhilliesRed
        }
        if primaryColor == "RockyPurple"
        {
            teamColor = Colors.RockyPurple
        }
        if primaryColor == "RoyalsBlue"
        {
            teamColor = Colors.RoyalsBlue
        }
        if primaryColor == "MarinersNavy"
        {
            teamColor = Colors.MarinersNavy
        }
        if primaryColor == "MarlinsLightBlue"
        {
            teamColor = Colors.MarlinsLightBlue
        }
        if primaryColor == "PiratesGold"
        {
            teamColor = Colors.PiratesGold
        }
        if primaryColor == "TigersNavy"
        {
            teamColor = Colors.TigerNavy
        }
        if primaryColor == "TwinsNavy"
        {
            teamColor = Colors.TwinsNavy
        }
        if primaryColor == "YankeesNavy"
        {
            teamColor = Colors.YankeesNavy
        }
        
        if primaryColor == "RaysNavy"
        {
            teamColor = Colors.RaysNavy
        }
        if primaryColor == "DiamondbackRed"
        {
            teamColor = Colors.DiamondbackRed
        }
        if primaryColor == "ExposBlue"
        {
            teamColor = Colors.ExposLightBlue
        }
        if primaryColor == "IndiansBlue"
        {
            teamColor = Colors.IndiansBlue
        }
        if primaryColor == "OrioleOrange"
        {
            teamColor = Colors.OrioleOrange
        }
        if primaryColor == "PadresGray"
        {
            teamColor = Colors.PadresGray
        }
        if primaryColor == "RangersBlue"
        {
            teamColor = Colors.RangersBlue
        }
        if primaryColor == "Black"
        {
            teamColor = Colors.black
        }
        if primaryColor == "White"
        {
            teamColor = Colors.white
        }
        colorArray.append(teamColor)
        
        //Secondary
        var teamLabelColor = SKColor.black
        if secondaryColor == "AthleticYellow"
        {
            teamLabelColor = Colors.AthleticYellow
        }
        if secondaryColor == "AstrosOrange"
        {
            teamLabelColor = Colors.AstrosOrange
        }
        if secondaryColor == "CubsRed"
        {
            teamLabelColor = Colors.CubsRed
        }
        if secondaryColor == "MetsOrange"
        {
            teamLabelColor = Colors.MetsOrange
        }
        if secondaryColor == "AstrosNavy"
        {
            teamLabelColor = Colors.AstrosNavy
        }
        if secondaryColor == "AngelsSilver"
        {
            teamLabelColor = Colors.AngelsSilver
        }
        if secondaryColor == "CardinalsYellow"
        {
            teamLabelColor = Colors.CardinalsYellow
        }
        if secondaryColor == "GiantsBlack"
        {
            teamLabelColor = Colors.GiantsBlack
        }
        if secondaryColor == "BrewersNavy"
        {
            teamLabelColor = Colors.BrewersNavy
        }
        if secondaryColor == "PhilliesBlue"
        {
            teamLabelColor = Colors.PhilliesBlue
        }
        if secondaryColor == "RockySilver"
        {
            teamLabelColor = Colors.RockySilver
        }
        if secondaryColor == "RoyalsGold"
        {
            teamLabelColor = Colors.RoyalsGold
        }
        if secondaryColor == "MarinersGreen"
        {
            teamLabelColor = Colors.MarinersGreen
        }
        if secondaryColor == "MarlinsGray"
        {
            teamLabelColor = Colors.MarlinsGray
        }
        if secondaryColor == "PiratesBlack"
        {
            teamLabelColor = Colors.PiratesBlack
        }
        if secondaryColor == "TigersOrange"
        {
            teamLabelColor = Colors.TigerOrange
        }
        if secondaryColor == "TwinsRed"
        {
            teamLabelColor = Colors.TwinsRed
        }
        if secondaryColor == "RaysLightBlue"
        {
            teamLabelColor = Colors.RaysLightBlue
        }
        if secondaryColor == "DiamondbackSand"
        {
            teamLabelColor = Colors.DiamondbackSand
        }
        if secondaryColor == "ExposRed"
        {
            teamLabelColor = Colors.ExposRed
        }
        if secondaryColor == "IndiansRed"
        {
            teamLabelColor = Colors.IndiansRed
        }
        if secondaryColor == "PadresBlue"
        {
            teamLabelColor = Colors.PadresBlue
        }
        if secondaryColor == "RangersRed"
        {
            teamLabelColor = Colors.RangersRed
        }
        
        if secondaryColor == "Black"
        {
            teamLabelColor = SKColor.black
        }
        if secondaryColor == "White"
        {
            teamLabelColor = SKColor.white
        }
        colorArray.append(teamLabelColor)
        
        return colorArray
    }
}
