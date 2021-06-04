//
//  MySchedule.swift
//  MySportsConnect
//
//  Created by ADAMLANE on 7/16/19.
//  Copyright © 2019 Nathan Beal Studios. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import UserNotifications

class MySchedule: SKScene
{
    //All Sprite Nodes
    let Background = SKSpriteNode(imageNamed: "MSCBackground.")
    let MTBackground = SKSpriteNode(imageNamed: "MyTeamsBackground")
    let AddTeamButton = SKSpriteNode(imageNamed: "AddTeam")
    let ExitButton = SKSpriteNode(imageNamed: "PageExit")
    let menuBar = SKSpriteNode(imageNamed: "MyTeamsBackground")
    let ShadeOut = SKSpriteNode(imageNamed: "ShadeOut")
    let MyScheduleLogo = SKSpriteNode(imageNamed: "MySchedule")
    let MyTeamsLogo = SKSpriteNode(imageNamed: "MyTeamLogo")
    
    //All Label Nodes
    let Directions = SKLabelNode()
    let MySportsLabel = SKLabelNode()
    let AddTeamLabel = SKLabelNode()
    let myTeamsLabel = SKLabelNode()
    let myScheduleLabel = SKLabelNode()
    
    //Game Labels and Information
    let game1 = SKSpriteNode(imageNamed: "Label"); var game1Rect = CGRect();  let game1TeamLabel = SKLabelNode(); let game1Label = SKLabelNode();  let game1Label2 = SKLabelNode()
    let game2 = SKSpriteNode(imageNamed: "Label"); var game2Rect = CGRect(); let game2TeamLabel = SKLabelNode(); let game2Label = SKLabelNode(); let game2Label2 = SKLabelNode()
    let game3 = SKSpriteNode(imageNamed: "Label"); var game3Rect = CGRect(); let game3TeamLabel = SKLabelNode(); let game3Label = SKLabelNode(); let game3Label2 = SKLabelNode()
    let game4 = SKSpriteNode(imageNamed: "Label"); var game4Rect = CGRect(); let game4TeamLabel = SKLabelNode(); let game4Label = SKLabelNode(); let game4Label2 = SKLabelNode()
    
    //For the fields
    var Fields = [String]()
    
    //Other Variables
    var gameView = false
    var lazyCoding = 0
    var Team1Rect = CGRect()
    
    //Banner
    var TeamBannerRect = CGRect(); var TeamBanner = SKShapeNode()
    var TeamBannerMenuRect = CGRect(); var TeamBannerMenu = SKShapeNode()
    
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
        Background.size = self.size
        Background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        Background.zPosition = 0
        self.addChild(Background)
        
        
        
        //Adjustors
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
        self.addChild(TeamBannerMenu)
        
        ShadeOut.size = self.size
        ShadeOut.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        ShadeOut.zPosition = 14
        ShadeOut.alpha = 0
        self.addChild(ShadeOut)
        
        MySportsLabel.position = CGPoint(x: self.size.width/2, y: TeamBannerRect.midY - (TeamBannerRect.midY/50))
        MySportsLabel.text = "MySchedule"
        MySportsLabel.fontName = "HelveticaNeue"
        MySportsLabel.fontSize = CGFloat(40 * scaleModifier)
        MySportsLabel.fontColor = SKColor.white
        MySportsLabel.zPosition = 10
        MySportsLabel.alpha = 0
        self.addChild(MySportsLabel)
        
        Directions.position = CGPoint(x: 5 * self.size.width/10, y: 8.3 * self.size.height/10)
        Directions.text = "Your upcoming schedule"
        Directions.fontName = "HelveticaNeue"
        Directions.fontSize = CGFloat(30 * scaleModifier)
        Directions.fontColor = SKColor.white
        Directions.zPosition = 5
        Directions.alpha = 0
        self.addChild(Directions)
        
        //MyTeams Logo
        MyTeamsLogo.setScale(CGFloat(1 * scaleModifier))
        MyTeamsLogo.position = CGPoint(x: TeamBannerMenuRect.midX/2, y: TeamBannerMenuRect.midY + (TeamBannerRect.midY/60))
        MyTeamsLogo.zPosition = 12
        self.addChild(MyTeamsLogo)
        
        //MyTeams Label
        myTeamsLabel.position = CGPoint(x: TeamBannerMenuRect.midX/2, y: TeamBannerMenuRect.midY - (TeamBannerRect.midY/20))
        myTeamsLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        myTeamsLabel.text = "MyTeams"
        myTeamsLabel.fontName = "HelveticaNeue"
        myTeamsLabel.fontSize = CGFloat(15 * scaleModifier)
        myTeamsLabel.fontColor = SKColor.white
        myTeamsLabel.zPosition = 12
        self.addChild(myTeamsLabel)
        
        //MySchedule Logo
        MyScheduleLogo.setScale(CGFloat(1 * scaleModifier))
        MyScheduleLogo.position = CGPoint(x: 3 * TeamBannerMenuRect.midX/2, y: TeamBannerMenuRect.midY + (TeamBannerRect.midY/60))
        MyScheduleLogo.zPosition = 12
        self.addChild(MyScheduleLogo)
        
        //mySchedule Label
        myScheduleLabel.position = CGPoint(x: 3 * TeamBannerMenuRect.midX/2, y: TeamBannerMenuRect.midY - (TeamBannerRect.midY/20))
        myScheduleLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        myScheduleLabel.text = "MySchedule"
        myScheduleLabel.fontName = "HelveticaNeue"
        myScheduleLabel.fontSize = CGFloat(15 * scaleModifier)
        myScheduleLabel.fontColor = SKColor.white
        myScheduleLabel.zPosition = 12
        self.addChild(myScheduleLabel)
        
        Team1Rect = CGRect(x: 1 * self.size.width/10, y: 7 * self.size.height/10, width: 8 * self.size.width/10, height: 1.25 * self.size.height/10)
        
        game1Rect = CGRect(x: 1.5 * self.size.width/10, y: 6.15 * self.size.height/10, width: 7 * self.size.width/10, height: 1.5 * self.size.height/10)
        game2Rect = CGRect(x: 1.5 * self.size.width/10, y: 4.55 * self.size.height/10, width: 7 * self.size.width/10, height: 1.5 * self.size.height/10)
        game3Rect = CGRect(x: 1.5 * self.size.width/10, y: 2.95 * self.size.height/10, width: 7 * self.size.width/10, height: 1.5 * self.size.height/10)
        game4Rect = CGRect(x: 1.5 * self.size.width/10, y: 1.35 * self.size.height/10, width: 7 * self.size.width/10, height: 1.5 * self.size.height/10)
        
        ///////////////////////////////////////////////////////////////////////////////////
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        
        var playableGames: [String] = assembleDatesList()
        
        //Game 1
        if playableGames.count >= 1
        {
            if playableGames[0] != "None"
            {
                game1.position = CGPoint(x: 5 * self.size.width/10, y: 7.4 * self.size.height/10)
                game1.size = game1Rect.size
                game1.zPosition = 9
                self.addChild(game1)
                
                let game1Info = playableGames[0].components(separatedBy: ".")
                game1TeamLabel.position = CGPoint(x: 5 * self.size.width/10, y: game1.position.y + 0.25 * self.size.height/10)
                game1Label.position = CGPoint(x: 5 * self.size.width/10, y: game1.position.y - 0.1 * self.size.height/10)
                game1Label2.position = CGPoint(x: 5 * self.size.width/10, y: game1.position.y - 0.4 * self.size.height/10)
                
                game1TeamLabel.text = "\(game1Info[1])"
                game1Label.text = "\(game1Info[0]) - \(game1Info[2]) @ \(game1Info[3])"
                game1Label2.text = "Game is at \(game1Info[4]) vs. \(game1Info[5])"
                game1TeamLabel.fontName = "Avenir-BlackOblique"
                game1Label.fontName = "HelveticaNeue-Light"
                game1Label2.fontName = "HelveticaNeue-Light"
                game1TeamLabel.fontSize = CGFloat(20 * scaleModifier)
                game1Label.fontSize = CGFloat(20 * scaleModifier)
                game1Label2.fontSize = CGFloat(15 * scaleModifier)
                game1TeamLabel.fontColor = SKColor.black
                game1Label.fontColor = SKColor.black
                game1Label2.fontColor = SKColor.black
                game1TeamLabel.zPosition = 10
                game1Label.zPosition = 10
                game1Label2.zPosition = 10
                
                game1TeamLabel.alpha = 0
                game1Label.alpha = 0
                game1Label2.alpha = 0
                
                self.addChild(game1TeamLabel)
                self.addChild(game1Label)
                self.addChild(game1Label2)
                Fields.append(game1Info[4])
                
                //Notifications
                content.title = "MySportsConnect"
                content.subtitle = "Game Notification"
                content.body = "You have a \(game1Info[1]) in 3 hours"
                content.sound = UNNotificationSound.default
                content.threadIdentifier = "Game 1 Notification"
                
                var monthDay:[String] = game1Info[0].components(separatedBy: "/")
                
                //Splits "12:30" from "PM"
                var timeComponents:[String] = game1Info[3].components(separatedBy: " ")
                
                //Splits hours and minutes
                var hourMinute = timeComponents[0].components(separatedBy: ":")
                
                
                var timeOfDayHours = 0
                let timeOfDayMinutes = hourMinute[1]
                if (timeComponents[1] == "PM" && hourMinute[0] != "12")
                {
                    timeOfDayHours = 12 + Int(hourMinute[0])!
                }else{
                    timeOfDayHours = Int(hourMinute[0])!
                }
                
                var dateOfGame = DateComponents()
                dateOfGame.minute = Int(timeOfDayMinutes)
                dateOfGame.hour = Int(timeOfDayHours) - 3
                dateOfGame.day = Int(monthDay[1])
                dateOfGame.month = Int(monthDay[0])
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateOfGame, repeats: false)
                let request = UNNotificationRequest(identifier: "content", content: content, trigger: trigger)
                center.add(request) { (error) in
                    if error != nil
                    {
                        print(error as Any)
                    }
                }
            }
        }
        
        
        //Game 2
        if playableGames.count >= 2
        {
            if playableGames[1] != "None"
            {
                game2.position = CGPoint(x: 5 * self.size.width/10, y: 5.8 * self.size.height/10)
                game2.size = game2Rect.size
                game2.zPosition = 9
                self.addChild(game2)
                
                let game2Info = playableGames[1].components(separatedBy: ".")
                game2TeamLabel.position = CGPoint(x: 5 * self.size.width/10, y: game2.position.y + 0.25 * self.size.height/10)
                game2Label.position = CGPoint(x: 5 * self.size.width/10, y: game2.position.y - 0.1 * self.size.height/10)
                game2Label2.position = CGPoint(x: 5 * self.size.width/10, y: game2.position.y - 0.4 * self.size.height/10)
                
                game2TeamLabel.text = "\(game2Info[1])"
                game2Label.text = "\(game2Info[0]) - \(game2Info[2]) @ \(game2Info[3])"
                game2Label2.text = "Game is at \(game2Info[4]) vs. \(game2Info[5])"
                game2TeamLabel.fontName = "Avenir-BlackOblique"
                game2Label.fontName = "HelveticaNeue-Light"
                game2Label2.fontName = "HelveticaNeue-Light"
                game2TeamLabel.fontSize = CGFloat(20 * scaleModifier)
                game2Label.fontSize = CGFloat(20 * scaleModifier)
                game2Label2.fontSize = CGFloat(15 * scaleModifier)
                game2TeamLabel.fontColor = SKColor.black
                game2Label.fontColor = SKColor.black
                game2Label2.fontColor = SKColor.black
                game2TeamLabel.zPosition = 10
                game2Label.zPosition = 10
                game2Label2.zPosition = 10
                
                game2TeamLabel.alpha = 0
                game2Label.alpha = 0
                game2Label2.alpha = 0
                
                self.addChild(game2TeamLabel)
                self.addChild(game2Label)
                self.addChild(game2Label2)
                Fields.append(game2Info[4])
                
                //Notification
                content.title = "MySportsConnect"
                content.subtitle = "Game Notification"
                content.body = "You have a \(game2Info[1]) game in 3 hours"
                content.sound = UNNotificationSound.default
                content.threadIdentifier = "Game 2 Notification"
                
                //
                var monthDay2:[String] = game2Info[0].components(separatedBy: "/")
                //Splits "12:30" from "PM"
                var timeComponents2:[String] = game2Info[3].components(separatedBy: " ")
                //Splits hours and minutes
                var hourMinute2 = timeComponents2[0].components(separatedBy: ":")
                
                
                var timeOfDayHours2 = 0
                let timeOfDayMinutes2 = hourMinute2[1]
                if (timeComponents2[1] == "PM" && hourMinute2[0] != "12")
                {
                    timeOfDayHours2 = 12 + Int(hourMinute2[0])!
                }else{
                    timeOfDayHours2 = Int(hourMinute2[0])!
                }
                
                var dateOfGame2 = DateComponents()
                dateOfGame2.minute = Int(timeOfDayMinutes2)
                dateOfGame2.hour = Int(timeOfDayHours2) - 3
                dateOfGame2.day = Int(monthDay2[1])
                dateOfGame2.month = Int(monthDay2[0])
                
                let trigger2 = UNCalendarNotificationTrigger(dateMatching: dateOfGame2, repeats: false)
                let request2 = UNNotificationRequest(identifier: "content", content: content, trigger: trigger2)
                center.add(request2) { (error) in
                    if error != nil
                    {
                        print(error as Any)
                    }
                }
            }
        }
        
        
        //Game 3
        if playableGames.count >= 3
        {
            if playableGames[2] != "None"
            {
                game3.position = CGPoint(x: 5 * self.size.width/10, y: 4.2 * self.size.height/10)
                game3.size = game3Rect.size
                game3.zPosition = 9
                self.addChild(game3)
                
                let game3Info = playableGames[2].components(separatedBy: ".")
                game3TeamLabel.position = CGPoint(x: 5 * self.size.width/10, y: game3.position.y + 0.25 * self.size.height/10)
                game3Label.position = CGPoint(x: 5 * self.size.width/10, y: game3.position.y - 0.1 * self.size.height/10)
                game3Label2.position = CGPoint(x: 5 * self.size.width/10, y: game3.position.y - 0.4 * self.size.height/10)
                
                game3TeamLabel.text = "\(game3Info[1])"
                game3Label.text = "\(game3Info[0]) - \(game3Info[2]) @ \(game3Info[3])"
                game3Label2.text = "Game is at \(game3Info[4]) vs. \(game3Info[5])"
                game3TeamLabel.fontName = "Avenir-BlackOblique"
                game3Label.fontName = "HelveticaNeue-Light"
                game3Label2.fontName = "HelveticaNeue-Light"
                game3TeamLabel.fontSize = CGFloat(20 * scaleModifier)
                game3Label.fontSize = CGFloat(20 * scaleModifier)
                game3Label2.fontSize = CGFloat(15 * scaleModifier)
                game3TeamLabel.fontColor = SKColor.black
                game3Label.fontColor = SKColor.black
                game3Label2.fontColor = SKColor.black
                game3TeamLabel.zPosition = 10
                game3Label.zPosition = 10
                game3Label2.zPosition = 10
                
                game3TeamLabel.alpha = 0
                game3Label.alpha = 0
                game3Label2.alpha = 0
                
                self.addChild(game3TeamLabel)
                self.addChild(game3Label)
                self.addChild(game3Label2)
                Fields.append(game3Info[4])
                
                //Notification
                content.title = "MySportsConnect"
                content.subtitle = "Game Notification"
                content.body = "You have a \(game3Info[1]) game in 3 hours"
                content.sound = UNNotificationSound.default
                content.threadIdentifier = "Game 3 Notification"
                var monthDay3:[String] = game3Info[0].components(separatedBy: "/")
                //Splits "12:30" from "PM"
                var timeComponents3:[String] = game3Info[3].components(separatedBy: " ")
                //Splits hours and minutes
                var hourMinute3 = timeComponents3[0].components(separatedBy: ":")
                
                
                var timeOfDayHours3 = 0
                let timeOfDayMinutes3 = hourMinute3[1]
                if (timeComponents3[1] == "PM" && hourMinute3[0] != "12")
                {
                    timeOfDayHours3 = 12 + Int(hourMinute3[0])!
                }else{
                    timeOfDayHours3 = Int(hourMinute3[0])!
                }
                
                var dateOfGame3 = DateComponents()
                dateOfGame3.minute = Int(timeOfDayMinutes3)
                dateOfGame3.hour = Int(timeOfDayHours3) - 3
                dateOfGame3.day = Int(monthDay3[1])
                dateOfGame3.month = Int(monthDay3[0])
                
                let trigger3 = UNCalendarNotificationTrigger(dateMatching: dateOfGame3, repeats: false)
                let request3 = UNNotificationRequest(identifier: "content", content: content, trigger: trigger3)
                center.add(request3) { (error) in
                    if error != nil
                    {
                        print(error as Any)
                    }
                }
            }
        }
        
        
        //Game 4
        if playableGames.count >= 4
        {
            if playableGames[3] != "None"
            {
                game4.position = CGPoint(x: 5 * self.size.width/10, y: 2.6 * self.size.height/10)
                game4.size = game4Rect.size
                game4.zPosition = 9
                self.addChild(game4)
                
                let game4Info = playableGames[3].components(separatedBy: ".")
                game4TeamLabel.position = CGPoint(x: 5 * self.size.width/10, y: game4.position.y + 0.25 * self.size.height/10)
                game4Label.position = CGPoint(x: 5 * self.size.width/10, y: game4.position.y - 0.1 * self.size.height/10)
                game4Label2.position = CGPoint(x: 5 * self.size.width/10, y: game4.position.y - 0.4 * self.size.height/10)
                
                game4TeamLabel.text = "\(game4Info[1])"
                game4Label.text = "\(game4Info[0]) - \(game4Info[2]) @ \(game4Info[3])"
                game4Label2.text = "Game is at \(game4Info[4]) vs. \(game4Info[5])"
                game4TeamLabel.fontName = "Avenir-BlackOblique"
                game4Label.fontName = "HelveticaNeue-Light"
                game4Label2.fontName = "HelveticaNeue-Light"
                game4TeamLabel.fontSize = CGFloat(20 * scaleModifier)
                game4Label.fontSize = CGFloat(20 * scaleModifier)
                game4Label2.fontSize = CGFloat(15 * scaleModifier)
                game4TeamLabel.fontColor = SKColor.black
                game4Label.fontColor = SKColor.black
                game4Label2.fontColor = SKColor.black
                game4TeamLabel.zPosition = 10
                game4Label.zPosition = 10
                game4Label2.zPosition = 10
                
                game4TeamLabel.alpha = 0
                game4Label.alpha = 0
                game4Label2.alpha = 0
                
                self.addChild(game4TeamLabel)
                self.addChild(game4Label)
                self.addChild(game4Label2)
                Fields.append(game4Info[4])
                
                //Notification
                content.title = "MySportsConnect"
                content.subtitle = "Game Notification"
                content.body = "You have a \(game4Info[1]) game in 3 hours"
                content.sound = UNNotificationSound.default
                content.threadIdentifier = "Game 4 Notification"
                
                //
                var monthDay4:[String] = game4Info[0].components(separatedBy: "/")
                //Splits "12:30" from "PM"
                var timeComponents4:[String] = game4Info[3].components(separatedBy: " ")
                //Splits hours and minutes
                var hourMinute4 = timeComponents4[0].components(separatedBy: ":")
                
                
                var timeOfDayHours4 = 0
                let timeOfDayMinutes4 = hourMinute4[1]
                if (timeComponents4[1] == "PM" && hourMinute4[0] != "12")
                {
                    timeOfDayHours4 = 12 + Int(hourMinute4[0])!
                }else{
                    timeOfDayHours4 = Int(hourMinute4[0])!
                }
                
                var dateOfGame4 = DateComponents()
                dateOfGame4.minute = Int(timeOfDayMinutes4)
                dateOfGame4.hour = Int(timeOfDayHours4) - 3
                dateOfGame4.day = Int(monthDay4[1])
                dateOfGame4.month = Int(monthDay4[0])
                
                let trigger4 = UNCalendarNotificationTrigger(dateMatching: dateOfGame4, repeats: false)
                let request4 = UNNotificationRequest(identifier: "content", content: content, trigger: trigger4)
                center.add(request4) { (error) in
                    if error != nil
                    {
                        print(error as Any)
                    }
                }
            }
        }
        
        
        let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.5)
        
        MySportsLabel.run(fadeIn); Directions.run(fadeIn)
        game1TeamLabel.run(fadeIn); game1Label.run(fadeIn); game1Label2.run(fadeIn)
        game2TeamLabel.run(fadeIn); game2Label.run(fadeIn); game2Label2.run(fadeIn)
        game3TeamLabel.run(fadeIn); game3Label.run(fadeIn); game3Label2.run(fadeIn)
        game4TeamLabel.run(fadeIn); game4Label.run(fadeIn); game4Label2.run(fadeIn)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            
            if (pointOfTouch.x > 2.5 * self.size.width/10 - Team1Rect.width/4 && pointOfTouch.x < 2.5 * self.size.width/10 + Team1Rect.width/4) && (pointOfTouch.y < self.size.height && pointOfTouch.y > self.size.height - Team1Rect.height)
            {
                self.run(SKAction.run(fadeOutPage))
                
                let wait = SKAction.wait(forDuration: 0.5)
                let changeScene = SKAction.run(myTeamsPage)
                let sequence = SKAction.sequence([wait, changeScene])
                self.run(sequence)
            }
            
            //Directions
            if gameView == false
            {
                //Game 1
                if (pointOfTouch.x > 5 * self.size.width/10 - game1.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + game1.size.width/2) && (pointOfTouch.y < 2.6 * self.size.height/10 + game1.size.height/2 && pointOfTouch.y > 2.6 * self.size.height/10 - game1.size.height/2)
                {
                    ShadeOut.alpha = 0.8
                    
                    game1.size = game1Rect.size
                    game1.zPosition = 15
                    game1TeamLabel.zPosition = 16
                    game1Label.zPosition = 16
                    game1Label2.zPosition = 16
                    game1.position = CGPoint(x: 5 * self.size.width/10, y: 5 * self.size.height/10)
                    game1TeamLabel.position = CGPoint(x: 5 * self.size.width/10, y: game1.position.y + 0.25 * self.size.height/10)
                    game1Label.position = CGPoint(x: 5 * self.size.width/10, y: game1.position.y - 0.1 * self.size.height/10)
                    game1Label2.position = CGPoint(x: 5 * self.size.width/10, y: game1.position.y - 0.4 * self.size.height/10)
                    lazyCoding = 1
                }
                
                //Game 2
                if (pointOfTouch.x > 5 * self.size.width/10 - game1.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + game1.size.width/2) && (pointOfTouch.y < 4.2 * self.size.height/10 + game1.size.height/2 && pointOfTouch.y > 4.2 * self.size.height/10 - game1.size.height/2)
                {
                    ShadeOut.alpha = 0.8
                    
                    game2.size = game2Rect.size
                    game2.zPosition = 15
                    game2TeamLabel.zPosition = 16
                    game2Label.zPosition = 16
                    game2Label2.zPosition = 16
                    game2.position = CGPoint(x: 5 * self.size.width/10, y: 5 * self.size.height/10)
                    game2TeamLabel.position = CGPoint(x: 5 * self.size.width/10, y: game2.position.y + 0.25 * self.size.height/10)
                    game2Label.position = CGPoint(x: 5 * self.size.width/10, y: game2.position.y - 0.1 * self.size.height/10)
                    game2Label2.position = CGPoint(x: 5 * self.size.width/10, y: game2.position.y - 0.4 * self.size.height/10)
                    lazyCoding = 1
                }
                
                //Game 3
                if (pointOfTouch.x > 5 * self.size.width/10 - game3.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + game3.size.width/2) && (pointOfTouch.y < 5.8 * self.size.height/10 + game3.size.height/2 && pointOfTouch.y > 5.8 * self.size.height/10 - game3.size.height/2)
                {
                    ShadeOut.alpha = 0.8
                    
                    game3.size = game3Rect.size
                    game3.zPosition = 15
                    game3TeamLabel.zPosition = 16
                    game3Label.zPosition = 16
                    game3Label2.zPosition = 16
                    game3.position = CGPoint(x: 5 * self.size.width/10, y: 5 * self.size.height/10)
                    game3TeamLabel.position = CGPoint(x: 5 * self.size.width/10, y: game3.position.y + 0.25 * self.size.height/10)
                    game3Label.position = CGPoint(x: 5 * self.size.width/10, y: game3.position.y - 0.1 * self.size.height/10)
                    game3Label2.position = CGPoint(x: 5 * self.size.width/10, y: game3.position.y - 0.4 * self.size.height/10)
                    lazyCoding = 1
                }
                
                //Game 4
                if (pointOfTouch.x > 5 * self.size.width/10 - game4.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + game4.size.width/2) && (pointOfTouch.y < 7.4 * self.size.height/10 + game4.size.height/2 && pointOfTouch.y > 7.4 * self.size.height/10 - game4.size.height/2)
                {
                    ShadeOut.alpha = 0.8
                    
                    game4.size = game4Rect.size
                    game4.zPosition = 15
                    game4TeamLabel.zPosition = 16
                    game4Label.zPosition = 16
                    game4Label2.zPosition = 16
                    game4.position = CGPoint(x: 5 * self.size.width/10, y: 5 * self.size.height/10)
                    game4TeamLabel.position = CGPoint(x: 5 * self.size.width/10, y: game4.position.y + 0.25 * self.size.height/10)
                    game4Label.position = CGPoint(x: 5 * self.size.width/10, y: game4.position.y - 0.1 * self.size.height/10)
                    game4Label2.position = CGPoint(x: 5 * self.size.width/10, y: game4.position.y - 0.4 * self.size.height/10)
                    lazyCoding = 1
                }
            }
            
            
            if gameView == true
            {
                if (pointOfTouch.x > 5 * self.size.width/10 - game1.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + game1.size.width/2) && (pointOfTouch.y < 5 * self.size.height/10 + game1.size.height/2 && pointOfTouch.y > 5 * self.size.height/10 - game1.size.height/2)
                {
                    if (pointOfTouch.x > 5 * self.size.width/10 - game1.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + game1.size.width/2) && (pointOfTouch.y < game1.position.y - 0.25 * self.size.height/10 + game1.size.height/4 && pointOfTouch.y > game1.position.y - 0.25 * self.size.height/10 - game1.size.height/4)
                    {
                        guard let url = URL(string: fieldURL(Field: Fields[0])) else{return}
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                    
                }else{
                    ShadeOut.alpha = 0
                    
                    game1.size = game1Rect.size
                    game1.zPosition = 9
                    game1TeamLabel.zPosition = 10
                    game1Label.zPosition = 10
                    game1Label2.zPosition = 10
                    game1.position = CGPoint(x: 5 * self.size.width/10, y: 7.4 * self.size.height/10)
                    game1TeamLabel.position = CGPoint(x: 5 * self.size.width/10, y: game1.position.y + 0.25 * self.size.height/10)
                    game1Label.position = CGPoint(x: 5 * self.size.width/10, y: game1.position.y - 0.1 * self.size.height/10)
                    game1Label2.position = CGPoint(x: 5 * self.size.width/10, y: game1.position.y - 0.4 * self.size.height/10)
                    lazyCoding = 0
                }
                
                //Game 2
                if (pointOfTouch.x > 5 * self.size.width/10 - game2.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + game2.size.width/2) && (pointOfTouch.y < 5 * self.size.height/10 + game2.size.height/2 && pointOfTouch.y > 5 * self.size.height/10 - game2.size.height/2)
                {
                    if (pointOfTouch.x > 5 * self.size.width/10 - game2.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + game2.size.width/2) && (pointOfTouch.y < game2.position.y - 0.25 * self.size.height/10 + game2.size.height/4 && pointOfTouch.y > game2.position.y - 0.25 * self.size.height/10 - game2.size.height/4)
                    {
                        guard let url = URL(string: fieldURL(Field: Fields[1])) else{return}
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }else{
                    ShadeOut.alpha = 0
                    
                    game2.size = game2Rect.size
                    game2.zPosition = 9
                    game2TeamLabel.zPosition = 10
                    game2Label.zPosition = 10
                    game2Label2.zPosition = 10
                    game2.position = CGPoint(x: 5 * self.size.width/10, y: 5.8 * self.size.height/10)
                    game2TeamLabel.position = CGPoint(x: 5 * self.size.width/10, y: game2.position.y + 0.25 * self.size.height/10)
                    game2Label.position = CGPoint(x: 5 * self.size.width/10, y: game2.position.y - 0.1 * self.size.height/10)
                    game2Label2.position = CGPoint(x: 5 * self.size.width/10, y: game2.position.y - 0.4 * self.size.height/10)
                    lazyCoding = 0
                }
                
                //Game 3
                if (pointOfTouch.x > 5 * self.size.width/10 - game3.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + game3.size.width/2) && (pointOfTouch.y < 5 * self.size.height/10 + game3.size.height/2 && pointOfTouch.y > 5 * self.size.height/10 - game3.size.height/2)
                {
                    if (pointOfTouch.x > 5 * self.size.width/10 - game3.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + game3.size.width/2) && (pointOfTouch.y < game3.position.y - 0.25 * self.size.height/10 + game3.size.height/4 && pointOfTouch.y > game3.position.y - 0.25 * self.size.height/10 - game3.size.height/4)
                    {
                        guard let url = URL(string: fieldURL(Field: Fields[2])) else{return}
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }else{
                    ShadeOut.alpha = 0
                    
                    game3.size = game3Rect.size
                    game3.zPosition = 9
                    game3TeamLabel.zPosition = 10
                    game3Label.zPosition = 10
                    game3Label2.zPosition = 10
                    game3.position = CGPoint(x: 5 * self.size.width/10, y: 4.2 * self.size.height/10)
                    game3TeamLabel.position = CGPoint(x: 5 * self.size.width/10, y: game3.position.y + 0.25 * self.size.height/10)
                    game3Label.position = CGPoint(x: 5 * self.size.width/10, y: game3.position.y - 0.1 * self.size.height/10)
                    game3Label2.position = CGPoint(x: 5 * self.size.width/10, y: game3.position.y - 0.4 * self.size.height/10)
                    lazyCoding = 0
                }
                
                //Game 4
                if (pointOfTouch.x > 5 * self.size.width/10 - game4.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + game4.size.width/2) && (pointOfTouch.y < 5 * self.size.height/10 + game4.size.height/2 && pointOfTouch.y > 5 * self.size.height/10 - game4.size.height/2)
                {
                    if (pointOfTouch.x > 5 * self.size.width/10 - game4.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + game4.size.width/2) && (pointOfTouch.y < game4.position.y - 0.25 * self.size.height/10 + game4.size.height/4 && pointOfTouch.y > game4.position.y - 0.25 * self.size.height/10 - game4.size.height/4)
                    {
                        guard let url = URL(string: fieldURL(Field: Fields[3])) else{return}
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                    
                }else{
                    ShadeOut.alpha = 0
                    
                    game4.size = game4Rect.size
                    game4.zPosition = 9
                    game4TeamLabel.zPosition = 10
                    game4Label.zPosition = 10
                    game4Label2.zPosition = 10
                    game4.position = CGPoint(x: 5 * self.size.width/10, y: 2.6 * self.size.height/10)
                    game4TeamLabel.position = CGPoint(x: 5 * self.size.width/10, y: game4.position.y + 0.25 * self.size.height/10)
                    game4Label.position = CGPoint(x: 5 * self.size.width/10, y: game4.position.y - 0.1 * self.size.height/10)
                    game4Label2.position = CGPoint(x: 5 * self.size.width/10, y: game4.position.y - 0.4 * self.size.height/10)
                    lazyCoding = 0
                }
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
    
    func assembleDatesList() -> Array<String>
    {
        var escapeArrayList: [String] = Array()
        
        var teamTxts:[String] = []
        if defaults.string(forKey: "Team1") != "None"
        {
            let str = String(defaults.string(forKey: "Team1Txt")!)
            teamTxts.append(str)
        }
        if defaults.string(forKey: "Team2") != "None"
        {
            let str = String(defaults.string(forKey: "Team2Txt")!)
            teamTxts.append(str)
        }
        if defaults.string(forKey: "Team3") != "None"
        {
            let str = String(defaults.string(forKey: "Team3Txt")!)
            teamTxts.append(str)
        }
        if defaults.string(forKey: "Team4") != "None"
        {
            let str = String(defaults.string(forKey: "Team4Txt")!)
            teamTxts.append(str)
        }
        if defaults.string(forKey: "Team5") != "None"
        {
            let str = String(defaults.string(forKey: "Team5Txt")!)
            teamTxts.append(str)
        }
        
        
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: Date())
        let currentDay = calendar.component(.day, from: Date())
        
        //Collects All Games
        var gameInfo:[String] = []
        for i in 0...teamTxts.count-1
        {
            let path = Bundle.main.path(forResource: teamTxts[i], ofType: "txt")
            var dataString = ""
            do{
                dataString = try String (contentsOfFile: path!)
            }catch _ as NSError{
                print("issue reading")
            }
            
            let lines:[String] = dataString.components(separatedBy: "\n")
            
            //Adds all
            if lines.count < 3
            {
            }else{
                for j in 1...lines.count-2
                {
                    var tempString = lines[j]; tempString += "."; tempString += teamTxts[i]
                    gameInfo.append(tempString)
                }
            }
        }
        
        //Separates games
        var playableGames:[String] = []
        for j in 0...gameInfo.count-1
        {
            //Isolate Dates
            var dates:[String] = []
            let gameInfoPieces = gameInfo[j].components(separatedBy: ".")
            dates.append(gameInfoPieces[2])
            
            var dateComponents = dates[0].components(separatedBy: "/")
            
            if Int(dateComponents[0])! == currentMonth
            {
                if Int(dateComponents[1])! >= currentDay
                {
                    let str = gameInfo[j]
                    playableGames.append(str)
                }
            }
            if Int(dateComponents[0])! > currentMonth
            {
                let str = gameInfo[j]
                playableGames.append(str)
            }
        }
        
        //Quick catch for less than 4 Games
        if playableGames.count == 0
        {
            playableGames.append("None"); playableGames.append("None"); playableGames.append("None"); playableGames.append("None")
            return playableGames
        }
        
        
        
        var orderedPlayableGames:[String] = []
        for m in 0...playableGames.count-1
        {
            var tempGameInfo = playableGames[m].components(separatedBy: ".")
            
            let date:[String] = tempGameInfo[2].components(separatedBy: "/")
            
            
            let timeIdentifier = Int((Double(date[0])! * 2628002.88) + (Double(date[1])! * Double(86400)))
            
            
            var newString = String(timeIdentifier); newString += "."; newString += tempGameInfo[2]; newString += "."; newString += tempGameInfo[5]; newString += "."; newString += tempGameInfo[0]; newString += "."; newString += tempGameInfo[1]; newString += "."; newString += tempGameInfo[3]; newString += "."; newString += tempGameInfo[4];
            
            
            orderedPlayableGames.append(newString)
        }
        
        //Sorts Games by unique time code
        orderedPlayableGames.sort()
        
        
        //var clean
        var finalOrder:[String] = []
        for q in 0...orderedPlayableGames.count-1
        {
            var tempGameInfo = orderedPlayableGames[q].components(separatedBy: ".")
            var newString = tempGameInfo[1]; newString += "."; newString += tempGameInfo[2]; newString += "."; newString += tempGameInfo[3]; newString += "."; newString += tempGameInfo[4]; newString += "."; newString += tempGameInfo[5]; newString += "."; newString += tempGameInfo[6];
            finalOrder.append(newString)
        }
        let finishedProduct = removeDuplicates(array: finalOrder)
        return(finishedProduct)
    }
    
    func removeDuplicates(array: [String]) -> [String]
    {
        var encountered = Set<String>()
        var result: [String] = []
        for value in array {
            if encountered.contains(value) {
                // Do not add a duplicate element.
            }
            else {
                // Add value to the set.
                encountered.insert(value)
                // ... Append the value.
                result.append(value)
            }
        }
        return result
    }
    
    func fadeOutPage()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        
        MySportsLabel.run(fadeOut); Directions.run(fadeOut)
        game1TeamLabel.run(fadeOut); game1Label.run(fadeOut); game1Label2.run(fadeOut)
        game2TeamLabel.run(fadeOut); game2Label.run(fadeOut); game2Label2.run(fadeOut)
        game3TeamLabel.run(fadeOut); game3Label.run(fadeOut); game3Label2.run(fadeOut)
        game4TeamLabel.run(fadeOut); game4Label.run(fadeOut); game4Label2.run(fadeOut)
        
        game1.run(fadeOut); game2.run(fadeOut); game3.run(fadeOut); game4.run(fadeOut)
    }
    
    //Move to MyTeams
    func myTeamsPage()
    {
        let sceneToMoveTo = MyTeams(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func colorScheme(primaryColor: String, secondaryColor: String) -> Array<SKColor>
    {
        var colorArray = [SKColor]()
        
        var teamColor = SKColor.white
        if primaryColor == "AthleticGreen"
        {teamColor = Colors.AthleticGreen}
        if primaryColor == "AstrosNavy"
        {teamColor = Colors.AstrosNavy}
        if primaryColor == "AstrosOrange"
        {teamColor = Colors.AstrosOrange}
        if primaryColor == "BlueJaysBlue"
        {teamColor = Colors.BlueJaysBlue}
        if primaryColor == "CubsBlue"
        {teamColor = Colors.CubsBlue}
        if primaryColor == "AngelsMaroon"
        {teamColor = Colors.AngelsMaroon}
        if primaryColor == "MetsBlue"
        {teamColor = Colors.MetsBlue}
        if primaryColor == "NationalsRed"
        {teamColor = Colors.NationalsRed}
        if primaryColor == "RedSoxRed"
        {teamColor = Colors.RedSoxRed}
        if primaryColor == "YankeesNavy"
        {teamColor = Colors.YankeesNavy}
        if primaryColor == "CardinalsRed"
        {teamColor = Colors.CardinalsRed}
        if primaryColor == "GiantsOrange"
        {teamColor = Colors.GiantsOrange}
        if primaryColor == "BrewersGold"
        {teamColor = Colors.BrewersGold}
        if primaryColor == "PhilliesRed"
        {teamColor = Colors.PhilliesRed}
        if primaryColor == "RockyPurple"
        {teamColor = Colors.RockyPurple}
        if primaryColor == "RoyalsBlue"
        {teamColor = Colors.RoyalsBlue}
        if primaryColor == "MarinersNavy"
        {teamColor = Colors.MarinersNavy}
        if primaryColor == "MarlinsLightBlue"
        {teamColor = Colors.MarlinsLightBlue}
        if primaryColor == "PiratesGold"
        {teamColor = Colors.PiratesGold}
        if primaryColor == "TigersNavy"
        {teamColor = Colors.TigerNavy}
        if primaryColor == "TwinsNavy"
        {teamColor = Colors.TwinsNavy}
        if primaryColor == "YankeesNavy"
        {teamColor = Colors.YankeesNavy}
        if primaryColor == "RaysNavy"
        {teamColor = Colors.RaysNavy}
        if primaryColor == "DiamondbackRed"
        {teamColor = Colors.DiamondbackRed}
        if primaryColor == "ExposBlue"
        {teamColor = Colors.ExposLightBlue}
        if primaryColor == "IndiansBlue"
        {teamColor = Colors.IndiansBlue}
        if primaryColor == "OrioleOrange"
        {teamColor = Colors.OrioleOrange}
        if primaryColor == "PadresGray"
        {teamColor = Colors.PadresGray}
        if primaryColor == "RangersBlue"
        {teamColor = Colors.RangersBlue}
        if primaryColor == "Black"
        {teamColor = Colors.black}
        if primaryColor == "White"
        {teamColor = Colors.white}
        
        colorArray.append(teamColor)
        
        //Secondary
        var teamLabelColor = SKColor.black
        if secondaryColor == "AthleticYellow"
        {teamLabelColor = Colors.AthleticYellow}
        if secondaryColor == "AstrosOrange"
        {teamLabelColor = Colors.AstrosOrange}
        if secondaryColor == "CubsRed"
        {teamLabelColor = Colors.CubsRed}
        if secondaryColor == "MetsOrange"
        {teamLabelColor = Colors.MetsOrange}
        if secondaryColor == "AstrosNavy"
        {teamLabelColor = Colors.AstrosNavy}
        if secondaryColor == "AngelsSilver"
        {teamLabelColor = Colors.AngelsSilver}
        if secondaryColor == "CardinalsYellow"
        {teamLabelColor = Colors.CardinalsYellow}
        if secondaryColor == "GiantsBlack"
        {teamLabelColor = Colors.GiantsBlack}
        if secondaryColor == "BrewersNavy"
        {teamLabelColor = Colors.BrewersNavy}
        if secondaryColor == "PhilliesBlue"
        {teamLabelColor = Colors.PhilliesBlue}
        if secondaryColor == "RockySilver"
        {teamLabelColor = Colors.RockySilver}
        if secondaryColor == "RoyalsGold"
        {teamLabelColor = Colors.RoyalsGold}
        if secondaryColor == "MarinersGreen"
        {teamLabelColor = Colors.MarinersGreen}
        if secondaryColor == "MarlinsGray"
        {teamLabelColor = Colors.MarlinsGray}
        if secondaryColor == "PiratesBlack"
        {teamLabelColor = Colors.PiratesBlack}
        if secondaryColor == "TigersOrange"
        {teamLabelColor = Colors.TigerOrange}
        if secondaryColor == "TwinsRed"
        {teamLabelColor = Colors.TwinsRed}
        if secondaryColor == "RaysLightBlue"
        {teamLabelColor = Colors.RaysLightBlue}
        if secondaryColor == "DiamondbackSand"
        {teamLabelColor = Colors.DiamondbackSand}
        if secondaryColor == "ExposRed"
        {teamLabelColor = Colors.ExposRed}
        if secondaryColor == "IndiansRed"
        {teamLabelColor = Colors.IndiansRed}
        if secondaryColor == "PadresBlue"
        {teamLabelColor = Colors.PadresBlue}
        if secondaryColor == "RangersRed"
        {teamLabelColor = Colors.RangersRed}
        if secondaryColor == "Black"
        {teamLabelColor = SKColor.black}
        if secondaryColor == "White"
        {teamLabelColor = SKColor.white}
        
        colorArray.append(teamLabelColor)
        return colorArray
    }
    
    func fieldURL(Field: String) -> String
    {
        if Field == "Robinson Lane"
        {
            return "https://www.google.com/maps/place/Robinson+Lane+Park/@41.6272989,-73.8168982,17z/data=!3m1!4b1!4m5!3m4!1s0x89dd4736f2136705:0xb9ba3c682f1a6336!8m2!3d41.6272949!4d-73.8147042"
        }
        if Field == "Ryan's Memorial Park"
        {
            return "https://www.google.com/maps/place/Town+of+Kent+Recreation+Maint/@41.4505271,-73.6605123,17.01z/data=!4m12!1m6!3m5!1s0x89dd4dfebe12c0b3:0xa18fb2736ea3f76e!2sEdward+Ryan+Memorial+Park!8m2!3d41.4506201!4d-73.6583518!3m4!1s0x89dd4df8c7435f0f:0xdec800c3a5e9561b!8m2!3d41.4497416!4d-73.6560727"
        }
        if Field == "Tony Williams Park"
        {
            return "https://www.google.com/maps/place/Tony+Williams+Town+Park/@41.7357791,-74.0039286,17z/data=!3m1!4b1!4m5!3m4!1s0x89dd3d619729e0f3:0x1e6caf2c99a92a2b!8m2!3d41.7357751!4d-74.0017346"
        }
        if Field == "Newburgh"
        {
            return "https://www.google.com/maps/place/537+Lakeside+Rd,+Newburgh,+NY+12550/@41.5623132,-74.0959321,17z/data=!3m1!4b1!4m5!3m4!1s0x89dd2f1a32afbcc1:0xf749e94b2fe04215!8m2!3d41.5623092!4d-74.0937381"
        }
        if Field == "Creek Road"
        {
            return "https://www.google.com/maps/place/343+Creek+Rd,+Poughkeepsie,+NY+12601/@41.7434867,-73.9077748,15.47z/data=!4m5!3m4!1s0x89dd15bcb21f62c9:0xf312735e70c21ac7!8m2!3d41.7460377!4d-73.9014433"
        }
        if Field == "Beekman"
        {
            return "https://www.google.com/maps/place/71+Town+Center+Blvd,+Hopewell+Junction,+NY+12533/@41.6272044,-73.6898496,18.26z/data=!4m5!3m4!1s0x89dd437188c54465:0xb8879aea5ba4dbb9!8m2!3d41.6270678!4d-73.6884034"
        }
        if Field == "Cantine Field"
        {
            return "https://www.google.com/maps/place/Cantine+Field/@42.0839433,-73.9540303,17.06z/data=!4m13!1m7!3m6!1s0x89dda6dbe7713b6b:0xc18b7dde55bb5a90!2s239+Washington+Ave,+Saugerties,+NY+12477!3b1!8m2!3d42.0838778!4d-73.9518397!3m4!1s0x89dda6dc7983e473:0x3056bf42522dbe71!8m2!3d42.085683!4d-73.9539588"
        }
        if Field == "Marlboro High School"
        {
            return "https://www.google.com/maps/place/197-7+Cross+Rd,+Marlboro,+NY+12542/@41.6001966,-73.990404,647m/data=!3m2!1e3!4b1!4m12!1m6!3m5!1s0x89dd3af4367015cf:0x188eaf8ca9b6bd63!2sMarlboro+High+School!8m2!3d41.6038337!4d-73.9878185!3m4!1s0x89dd3af4be802ec5:0x51db238e44279b94!8m2!3d41.600252!4d-73.9877762"
        }
        if Field == "Hopewell Rec"
        {
            return "https://www.google.com/maps/place/330+NY-376,+Hopewell+Junction,+NY+12533/@41.5776197,-73.809593,533m/data=!3m2!1e3!4b1!4m13!1m7!3m6!1s0x89dd47b9ed83d76d:0x445ec2af3d1eca65!2s390+NY-376,+Hopewell+Junction,+NY+12533!3b1!8m2!3d41.5771541!4d-73.80762!3m4!1s0x89dd37dd8e141de5:0x28b1aa7ba830f8d!8m2!3d41.5776164!4d-73.8077857"
        }
        if Field == "Delano Hitch Stadium"
        {
            return "https://www.google.com/maps/dir//417-307+Washington+St,+Newburgh,+NY+12550/@41.4979591,-74.0266566,636m/data=!3m1!1e3!4m9!4m8!1m0!1m5!1m1!1s0x89dd320678961947:0x97e31b27ef8df9c7!2m2!1d-74.0241918!2d41.4992539!3e0"
        }
        if Field == "Peekskill Stadium"
        {
            return "https://www.google.com/maps/place/310+Louisa+St,+Peekskill,+NY+10566/@41.2782752,-73.9372353,649m/data=!3m1!1e3!4m5!3m4!1s0x89c2c8b545071cf7:0x2d63cf7cb5c387f1!8m2!3d41.2785675!4d-73.9350945"
        }
        if Field == " "
        {
            return ""
        }
        
        return ""
    }
}
