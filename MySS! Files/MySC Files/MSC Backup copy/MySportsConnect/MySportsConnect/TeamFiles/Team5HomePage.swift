//
//  Team5HomePage.swift
//  MySportsConnect
//
//  Created by ADAMLANE on 7/22/19.
//  Copyright © 2019 Nathan Beal Studios. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Team5HomePage: SKScene
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
    var Personal = SKSpriteNode(imageNamed: "Personal-1")
    
    //Team Identifier
    let Team1Label = SKLabelNode()
    let Team1Label2 = SKLabelNode()
    
    //Menu Buttons
    let Standings = SKSpriteNode(imageNamed: "Standings")
    let Home = SKSpriteNode(imageNamed: "Home")
    let Contact = SKSpriteNode(imageNamed: "Contacts")
    
    let ShadeOut = SKSpriteNode(imageNamed: "ShadeOut")
    
    //Game Labels and Information
    let upcomingGamesLabel = SKLabelNode()
    let game1 = SKSpriteNode(imageNamed: "Label")
    let game2 = SKSpriteNode(imageNamed: "Label")
    let game3 = SKSpriteNode(imageNamed: "Label")
    let game4 = SKSpriteNode(imageNamed: "Label")
    let game1Label = SKLabelNode()
    let game1Label2 = SKLabelNode()
    let game2Label = SKLabelNode()
    let game2Label2 = SKLabelNode()
    let game3Label = SKLabelNode()
    let game3Label2 = SKLabelNode()
    let game4Label = SKLabelNode()
    let game4Label2 = SKLabelNode()
    
    var game1Rect = CGRect()
    var game2Rect = CGRect()
    var game3Rect = CGRect()
    var game4Rect = CGRect()
    
    let AddTeamLabel = SKLabelNode()
    var Fields = [String]()
    
    //Banner
    var TeamBannerRect = CGRect(); var TeamBanner = SKShapeNode()
    var TeamBannerMenuRect = CGRect(); var TeamBannerMenu = SKShapeNode()
    
    var personalAdjust = CGFloat()
    
    //Viewing individual games
    var gameView = false
    var lazyCoding = 0
    
    //Used for boundaries
    override func didMove(to view: SKView)
    {
        //print(defaults.string(forKey: "DivTextIdentifier"))
        let temp = String(defaults.string(forKey: "Team5Txt")!)
        let path = Bundle.main.path(forResource: temp, ofType: "txt")
        //print(path)
        var dataString = ""
        do{
            dataString = try String (contentsOfFile: path!)
        }catch _ as NSError{
            print("issue reading")
        }
        
        let lines:[String] = dataString.components(separatedBy: "\n")
        
        let colors = lines[0].components(separatedBy: ".")
        
        if (defaults.double(forKey: "FrameWidth") == 414 && defaults.double(forKey: "FrameHeight") == 896) || (defaults.double(forKey: "FrameWidth") == 375 && defaults.double(forKey: "FrameHeight") == 812)
        {
            TeamBannerRect = CGRect(x: -0.1 * self.size.width/10, y: self.size.height - 1.25 * self.size.height/10, width: 1.02 * self.size.width, height: 1.27 * self.size.height/10)
            TeamBannerMenuRect = CGRect(x: -0.1 * self.size.width/10, y: -0.02 * self.size.height/10, width: 1.02 * self.size.width, height: 1.27 * self.size.height/10)
            personalAdjust = 0.985 * TeamBannerRect.midY
        }else{
            TeamBannerRect = CGRect(x: 0, y: self.size.height - 1.25 * self.size.height/10, width: self.size.width, height: 1.25 * self.size.height/10)
            TeamBannerMenuRect = CGRect(x: 0, y: 0, width: self.size.width, height: 1.25 * self.size.height/10)
            personalAdjust = TeamBannerRect.midY
            print("her")
        }
        
        TeamBanner = SKShapeNode.init(rect: TeamBannerRect)
        TeamBanner.fillColor = colorScheme(primaryColor: colors[0], secondaryColor: colors[1])
        TeamBanner.zPosition = 10
        TeamBanner.strokeColor = SKColor.black
        TeamBanner.lineWidth = 4
        TeamBanner.alpha = 0
        self.addChild(TeamBanner)
        
        TeamBannerMenu = SKShapeNode.init(rect: TeamBannerMenuRect)
        TeamBannerMenu.fillColor = colorScheme(primaryColor: colors[0], secondaryColor: colors[1])
        TeamBannerMenu.zPosition = 10
        TeamBannerMenu.strokeColor = SKColor.black
        TeamBannerMenu.lineWidth = 4
        TeamBannerMenu.alpha = 0
        self.addChild(TeamBannerMenu)
        
        Background.size = self.size
        Background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        Background.zPosition = 0
        self.addChild(Background)
        
        ShadeOut.size = self.size
        ShadeOut.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        ShadeOut.zPosition = 14
        ShadeOut.alpha = 0
        self.addChild(ShadeOut)
        
        Personal.setScale(CGFloat(0.35 * scaleModifier))
        Personal.position = CGPoint(x: TeamBannerRect.width/10, y: personalAdjust)
        Personal.zPosition = 11
        Personal.alpha = 0
        self.addChild(Personal)
        
        //Labels and Upcoming Games
        let Team = defaults.string(forKey: "Team5")
        let TeamParts:[String] = Team!.components(separatedBy: "(")
        
        if defaults.double(forKey: "FrameWidth") == 375
        {
            Team1Label.position = CGPoint(x: self.size.width/2, y: TeamBannerRect.midY)
        }else{
            Team1Label.position = CGPoint(x: self.size.width/2, y: TeamBannerRect.midY - TeamBannerRect.midY / 100)
        }
        Team1Label.text = TeamParts[0]
        Team1Label.fontSize = CGFloat(40 * scaleModifier)
        Team1Label.fontName = "Avenir-BlackOblique"//"Avenir-BlackOblique"
        Team1Label.zPosition = 10
        Team1Label.alpha = 0
        self.addChild(Team1Label)
        
        Team1Label2.position = CGPoint(x: self.size.width/2, y: TeamBannerRect.midY - (TeamBannerRect.midY/25))
        Team1Label2.text = "(" + TeamParts[1]
        Team1Label2.fontSize = CGFloat(25 * scaleModifier)
        Team1Label2.fontName = "Avenir-BookOblique"//"Baskerville-SemiBold"
        Team1Label2.zPosition = 10
        Team1Label2.alpha = 0
        self.addChild(Team1Label2)
        
        upcomingGamesLabel.position = CGPoint(x: 5 * self.size.width/10, y: 8.3 * gameArea.height/10)
        upcomingGamesLabel.text = "Upcoming Games"
        upcomingGamesLabel.fontName = "HelveticaNeue"
        upcomingGamesLabel.fontSize = CGFloat(30 * scaleModifier)
        upcomingGamesLabel.fontColor = SKColor.white
        upcomingGamesLabel.zPosition = 2
        upcomingGamesLabel.alpha = 0
        self.addChild(upcomingGamesLabel)
        
        //Menu Buttons
        Standings.setScale(CGFloat(1 * scaleModifier))
        Standings.position = CGPoint(x: 3 * TeamBannerMenuRect.maxX/16, y: TeamBannerMenuRect.midY)
        Standings.zPosition = 10
        Standings.alpha = 0
        self.addChild(Standings)
        
        Home.setScale(CGFloat(1 * scaleModifier))
        Home.position = CGPoint(x: TeamBannerMenuRect.maxX/2, y: TeamBannerMenuRect.midY)
        Home.zPosition = 10
        Home.alpha = 0
        self.addChild(Home)
        
        Contact.setScale(CGFloat(1 * scaleModifier))
        Contact.position = CGPoint(x: 13 * self.size.width/16, y: TeamBannerMenuRect.midY)
        Contact.zPosition = 10
        Contact.alpha = 0
        self.addChild(Contact)
        
        //Contains Next Four Games
        var playableGames: [String] = assembleDatesList()
        
        game1Rect = CGRect(x: 1.5 * self.size.width/10, y: 6.15 * self.size.height/10, width: 7 * self.size.width/10, height: 1.5 * self.size.height/10)
        
        //Game 1
        if playableGames.count >= 1
        {
            game1.position = CGPoint(x: 5 * self.size.width/10, y: 7.4 * self.size.height/10)
            game1.size = game1Rect.size
            game1.zPosition = 9
            game1.alpha = 0
            self.addChild(game1)
            
            let game1Info = playableGames[0].components(separatedBy: ".")
            game1Label.position = CGPoint(x: 5 * self.size.width/10, y: game1.position.y + 0.05 * self.size.height/10)
            game1Label2.position = CGPoint(x: 5 * self.size.width/10, y: game1.position.y - 0.25 * self.size.height/10)
            
            game1Label.text = "\(game1Info[2]) - \(game1Info[0]) @ \(game1Info[1])"
            game1Label2.text = "Game is at \(game1Info[3]) vs. \(game1Info[4])"
            game1Label.fontName = "HelveticaNeue-Light"
            game1Label2.fontName = "HelveticaNeue-Light"
            game1Label.fontSize = CGFloat(20 * scaleModifier)
            game1Label2.fontSize = CGFloat(15 * scaleModifier)
            game1Label.fontColor = SKColor.black
            game1Label2.fontColor = SKColor.black
            game1Label.zPosition = 10
            game1Label2.zPosition = 10
            game1Label.alpha = 0
            game1Label2.alpha = 0
            self.addChild(game1Label)
            self.addChild(game1Label2)
            Fields.append(game1Info[3])
        }
        
        //Game 2
        if playableGames.count >= 2
        {
            game2.position = CGPoint(x: 5 * self.size.width/10, y: 5.8 * self.size.height/10)
            game2.size = game1Rect.size
            game2.zPosition = 9
            game2.alpha = 0
            self.addChild(game2)
            
            let game2Info = playableGames[1].components(separatedBy: ".")
            game2Label.position = CGPoint(x: 5 * self.size.width/10, y: game2.position.y + 0.05 * self.size.height/10)
            game2Label2.position = CGPoint(x: 5 * self.size.width/10, y: game2.position.y - 0.25 * self.size.height/10)
            
            game2Label.text = "\(game2Info[2]) - \(game2Info[0]) @ \(game2Info[1])"
            game2Label2.text = "Game is at \(game2Info[3]) vs. \(game2Info[4])"
            game2Label.fontSize = CGFloat(20 * scaleModifier)
            game2Label2.fontSize = CGFloat(15 * scaleModifier)
            game2Label.fontName = "HelveticaNeue-Light"
            game2Label2.fontName = "HelveticaNeue-Light"
            game2Label.fontColor = SKColor.black
            game2Label2.fontColor = SKColor.black
            game2Label.zPosition = 10
            game2Label2.zPosition = 10
            game2Label.alpha = 0
            game2Label2.alpha = 0
            self.addChild(game2Label)
            self.addChild(game2Label2)
            Fields.append(game2Info[3])
        }
        
        //Game 3
        if playableGames.count >= 3
        {
            game3.position = CGPoint(x: 5 * self.size.width/10, y: 4.2 * self.size.height/10)
            game3.size = game1Rect.size
            game3.zPosition = 9
            game3.alpha = 0
            self.addChild(game3)
            
            let game3Info = playableGames[2].components(separatedBy: ".")
            game3Label.position = CGPoint(x: 5 * self.size.width/10, y: game3.position.y + 0.05 * self.size.height/10)
            game3Label2.position = CGPoint(x: 5 * self.size.width/10, y: game3.position.y - 0.25 * self.size.height/10)
            
            game3Label.text = "\(game3Info[2]) - \(game3Info[0]) @ \(game3Info[1])"
            game3Label2.text = "Game is at \(game3Info[3]) vs. \(game3Info[4])"
            game3Label.fontSize = CGFloat(20 * scaleModifier)
            game3Label2.fontSize = CGFloat(15 * scaleModifier)
            game3Label.fontName = "HelveticaNeue-Light"
            game3Label2.fontName = "HelveticaNeue-Light"
            game3Label.fontColor = SKColor.black
            game3Label2.fontColor = SKColor.black
            game3Label.zPosition = 10
            game3Label2.zPosition = 10
            game3Label.alpha = 0
            game3Label2.alpha = 0
            self.addChild(game3Label)
            self.addChild(game3Label2)
            Fields.append(game3Info[3])
        }
        
        //Game 4
        if playableGames.count >= 4
        {
            game4.position = CGPoint(x: 5 * self.size.width/10, y: 2.6 * self.size.height/10)
            game4.size = game1Rect.size
            game4.zPosition = 9
            game4.alpha = 0
            self.addChild(game4)
            
            let game4Info = playableGames[3].components(separatedBy: ".")
            game4Label.position = CGPoint(x: 5 * self.size.width/10, y: game4.position.y + 0.05 * self.size.height/10)
            game4Label2.position = CGPoint(x: 5 * self.size.width/10, y: game4.position.y - 0.25 * self.size.height/10)
            
            game4Label.text = "\(game4Info[2]) - \(game4Info[0]) @ \(game4Info[1])"
            game4Label2.text = "Game is at \(game4Info[3]) vs. \(game4Info[4])"
            game4Label.fontSize = CGFloat(20 * scaleModifier)
            game4Label2.fontSize = CGFloat(15 * scaleModifier)
            game4Label.fontName = "HelveticaNeue-Light"
            game4Label2.fontName = "HelveticaNeue-Light"
            game4Label.fontColor = SKColor.black
            game4Label2.fontColor = SKColor.black
            game4Label.zPosition = 10
            game4Label2.zPosition = 10
            game4Label.alpha = 0
            game4Label2.alpha = 0
            self.addChild(game4Label)
            self.addChild(game4Label2)
            Fields.append(game4Info[3])
        }
        
        if defaults.string(forKey: "WithinTeamPages") != "No"
        {
            fullFadeIn()
            defaults.set("Yes", forKey: "WithinTeamPages")
        }else{
            halfFadeIn()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            
            if gameView == false
            {
                //Game 1
                if (pointOfTouch.x > 5 * self.size.width/10 - game1.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + game1.size.width/2) && (pointOfTouch.y < 2.6 * self.size.height/10 + game1.size.height/2 && pointOfTouch.y > 2.6 * self.size.height/10 - game1.size.height/2)
                {
                    ShadeOut.alpha = 0.8
                    
                    game1.size = game1Rect.size
                    game1.zPosition = 15
                    game1Label.zPosition = 16
                    game1Label2.zPosition = 16
                    game1.position = CGPoint(x: 5 * self.size.width/10, y: 5 * self.size.height/10)
                    game1Label.position = CGPoint(x: 5 * self.size.width/10, y: game1.position.y + 0.05 * self.size.height/10)
                    game1Label2.position = CGPoint(x: 5 * self.size.width/10, y: game1.position.y - 0.25 * self.size.height/10)
                    lazyCoding = 1
                }
                
                //Game 2
                if (pointOfTouch.x > 5 * self.size.width/10 - game1.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + game1.size.width/2) && (pointOfTouch.y < 4.2 * self.size.height/10 + game1.size.height/2 && pointOfTouch.y > 4.2 * self.size.height/10 - game1.size.height/2)
                {
                    ShadeOut.alpha = 0.8
                    
                    game2.size = game1Rect.size
                    game2.zPosition = 15
                    game2Label.zPosition = 16
                    game2Label2.zPosition = 16
                    game2.position = CGPoint(x: 5 * self.size.width/10, y: 5 * self.size.height/10)
                    game2Label.position = CGPoint(x: 5 * self.size.width/10, y: game2.position.y + 0.05 * self.size.height/10)
                    game2Label2.position = CGPoint(x: 5 * self.size.width/10, y: game2.position.y - 0.25 * self.size.height/10)
                    lazyCoding = 1
                }
                
                //Game 3
                if (pointOfTouch.x > 5 * self.size.width/10 - game3.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + game3.size.width/2) && (pointOfTouch.y < 5.8 * self.size.height/10 + game3.size.height/2 && pointOfTouch.y > 5.8 * self.size.height/10 - game3.size.height/2)
                {
                    ShadeOut.alpha = 0.8
                    
                    game3.size = game1Rect.size
                    game3.zPosition = 15
                    game3Label.zPosition = 16
                    game3Label2.zPosition = 16
                    game3.position = CGPoint(x: 5 * self.size.width/10, y: 5 * self.size.height/10)
                    game3Label.position = CGPoint(x: 5 * self.size.width/10, y: game3.position.y + 0.05 * self.size.height/10)
                    game3Label2.position = CGPoint(x: 5 * self.size.width/10, y: game3.position.y - 0.25 * self.size.height/10)
                    lazyCoding = 1
                }
                
                //Game 4
                if (pointOfTouch.x > 5 * self.size.width/10 - game4.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + game4.size.width/2) && (pointOfTouch.y < 7.6 * self.size.height/10 + game4.size.height/2 && pointOfTouch.y > 7.6 * self.size.height/10 - game4.size.height/2)
                {
                    ShadeOut.alpha = 0.8
                    
                    game4.size = game1Rect.size
                    game4.zPosition = 15
                    game4Label.zPosition = 16
                    game4Label2.zPosition = 16
                    game4.position = CGPoint(x: 5 * self.size.width/10, y: 5 * self.size.height/10)
                    game4Label.position = CGPoint(x: 5 * self.size.width/10, y: game4.position.y + 0.05 * self.size.height/10)
                    game4Label2.position = CGPoint(x: 5 * self.size.width/10, y: game4.position.y - 0.25 * self.size.height/10)
                    lazyCoding = 1
                }
                
                //Home Button
                if (pointOfTouch.x > 1 * self.size.width/10 - Personal.size.width/2 && pointOfTouch.x < 1 * self.size.width/10 + Personal.size.width/2) && (pointOfTouch.y < self.size.height - Personal.position.y + Personal.size.height/2 && pointOfTouch.y > self.size.height - Personal.position.y - Personal.size.height/2)
                {
                    defaults.set("No", forKey: "WithinTeamPages")
                    self.run(SKAction.run(fadeOutMain))
                    
                    let wait = SKAction.wait(forDuration: 0.6)
                    let changeScene = SKAction.run(mainPage)
                    let sequence = SKAction.sequence([wait, changeScene])
                    self.run(sequence)
                }
                
                if (pointOfTouch.x > 0/3 * self.size.width && pointOfTouch.x < 1/3 * self.size.width) && (pointOfTouch.y < self.size.height && pointOfTouch.y > self.size.height - 1.25 * self.size.height/10)
                {
                    self.run(SKAction.run(fadeOutContactOrStandings))
                    
                    let wait = SKAction.wait(forDuration: 0.6)
                    let changeScene = SKAction.run(teamStandings)
                    let sequence = SKAction.sequence([wait, changeScene])
                    self.run(sequence)
                }
                
                //Team Home Page
                if (pointOfTouch.x > 2/3 * self.size.width && pointOfTouch.x < 3/3 * self.size.width) && (pointOfTouch.y < self.size.height && pointOfTouch.y > self.size.height - 1.25 * self.size.height/10)
                {
                    self.run(SKAction.run(fadeOutContactOrStandings))
                    
                    let wait = SKAction.wait(forDuration: 0.6)
                    let changeScene = SKAction.run(teamContactPage)
                    let sequence = SKAction.sequence([wait, changeScene])
                    self.run(sequence)
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
                    game1Label.zPosition = 10
                    game1Label2.zPosition = 10
                    game1.position = CGPoint(x: 5 * self.size.width/10, y: 7.4 * self.size.height/10)
                    game1Label.position = CGPoint(x: 5 * self.size.width/10, y: game1.position.y + 0.05 * self.size.height/10)
                    game1Label2.position = CGPoint(x: 5 * self.size.width/10, y: game1.position.y - 0.25 * self.size.height/10)
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
                    
                    game2.size = game1Rect.size
                    game2.zPosition = 9
                    game2Label.zPosition = 10
                    game2Label2.zPosition = 10
                    game2.position = CGPoint(x: 5 * self.size.width/10, y: 5.8 * self.size.height/10)
                    game2Label.position = CGPoint(x: 5 * self.size.width/10, y: game2.position.y + 0.05 * self.size.height/10)
                    game2Label2.position = CGPoint(x: 5 * self.size.width/10, y: game2.position.y - 0.25 * self.size.height/10)
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
                    
                    game3.size = game1Rect.size
                    game3.zPosition = 9
                    game3Label.zPosition = 10
                    game3Label2.zPosition = 10
                    game3.position = CGPoint(x: 5 * self.size.width/10, y: 4.2 * self.size.height/10)
                    game3Label.position = CGPoint(x: 5 * self.size.width/10, y: game3.position.y + 0.05 * self.size.height/10)
                    game3Label2.position = CGPoint(x: 5 * self.size.width/10, y: game3.position.y - 0.25 * self.size.height/10)
                    lazyCoding = 0
                }
                
                //Game 4
                if (pointOfTouch.x > 5 * self.size.width/10 - game3.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + game3.size.width/2) && (pointOfTouch.y < 5 * self.size.height/10 + game3.size.height/2 && pointOfTouch.y > 5 * self.size.height/10 - game3.size.height/2)
                {
                    if (pointOfTouch.x > 5 * self.size.width/10 - game3.size.width/2 && pointOfTouch.x < 5 * self.size.width/10 + game3.size.width/2) && (pointOfTouch.y < game4.position.y - 0.25 * self.size.height/10 + game4.size.height/4 && pointOfTouch.y > game4.position.y - 0.25 * self.size.height/10 - game4.size.height/4)
                    {
                        guard let url = URL(string: fieldURL(Field: Fields[3])) else{return}
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }else{
                    ShadeOut.alpha = 0
                    
                    game4.size = game1Rect.size
                    game4.zPosition = 9
                    game4Label.zPosition = 10
                    game4Label2.zPosition = 10
                    game4.position = CGPoint(x: 5 * self.size.width/10, y: 2.6 * self.size.height/10)
                    game4Label.position = CGPoint(x: 5 * self.size.width/10, y: game4.position.y + 0.05 * self.size.height/10)
                    game4Label2.position = CGPoint(x: 5 * self.size.width/10, y: game4.position.y - 0.25 * self.size.height/10)
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
    
    func mainPage()
    {
        let sceneToMoveTo = MyTeams(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func teamContactPage()
    {
        let sceneToMoveTo = Team5ContactPage(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func teamStandings()
    {
        let sceneToMoveTo = Team5Standings(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    //Transitions
    func fullFadeIn()
    {
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        
        Personal.run(fadeIn)
        
        upcomingGamesLabel.run(fadeIn);
        game1.run(fadeIn); game2.run(fadeIn); game3.run(fadeIn); game4.run(fadeIn);
        game1Label.run(fadeIn); game1Label2.run(fadeIn)
        game2Label.run(fadeIn); game2Label2.run(fadeIn)
        game3Label.run(fadeIn); game3Label2.run(fadeIn)
        game4Label.run(fadeIn); game4Label2.run(fadeIn)
        
        Team1Label.run(fadeIn); Team1Label2.run(fadeIn)
        Standings.run(fadeIn); Home.run(fadeIn); Contact.run(fadeIn)
        
        TeamBanner.run(fadeIn); TeamBannerMenu.run(fadeIn)
        
        
        let systemWait = SKAction.wait(forDuration: 0.5)
        self.run(systemWait)
    }
    
    func halfFadeIn()
    {
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        
        Personal.alpha = 1
        
        upcomingGamesLabel.run(fadeIn);
        game1.run(fadeIn); game2.run(fadeIn); game3.run(fadeIn); game4.run(fadeIn);
        game1Label.run(fadeIn); game1Label2.run(fadeIn)
        game2Label.run(fadeIn); game2Label2.run(fadeIn)
        game3Label.run(fadeIn); game3Label2.run(fadeIn)
        game4Label.run(fadeIn); game4Label2.run(fadeIn)
        
        Team1Label.alpha = 1; Team1Label2.alpha = 1
        Standings.alpha = 1; Home.alpha = 1; Contact.alpha = 1
        
        TeamBanner.alpha = 1; TeamBannerMenu.alpha = 1
    }
    
    func fadeOutMain()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        
        Personal.run(fadeOut)
        
        upcomingGamesLabel.run(fadeOut);
        game1.run(fadeOut); game2.run(fadeOut); game3.run(fadeOut); game4.run(fadeOut);
        game1Label.run(fadeOut); game1Label2.run(fadeOut)
        game2Label.run(fadeOut); game2Label2.run(fadeOut)
        game3Label.run(fadeOut); game3Label2.run(fadeOut)
        game4Label.run(fadeOut); game4Label2.run(fadeOut)
        
        Team1Label.run(fadeOut); Team1Label2.run(fadeOut)
        Standings.run(fadeOut); Home.run(fadeOut); Contact.run(fadeOut)
        
        TeamBanner.run(fadeOut); TeamBannerMenu.run(fadeOut)
        
        
        let systemWait = SKAction.wait(forDuration: 0.5)
        self.run(systemWait)
    }
    
    func fadeOutContactOrStandings()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        
        upcomingGamesLabel.run(fadeOut);
        game1.run(fadeOut); game2.run(fadeOut); game3.run(fadeOut); game4.run(fadeOut);
        game1Label.run(fadeOut); game1Label2.run(fadeOut)
        game2Label.run(fadeOut); game2Label2.run(fadeOut)
        game3Label.run(fadeOut); game3Label2.run(fadeOut)
        game4Label.run(fadeOut); game4Label2.run(fadeOut)
        
        
        let systemWait = SKAction.wait(forDuration: 0.5)
        self.run(systemWait)
    }
    
    
    //adjust for team
    func assembleDatesList() -> Array<String>
    {
        var teamTxts:[String] = []
        /*
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
         */
        
        //
        //print(teamTxts)
        let str = String(defaults.string(forKey: "Team5Txt")!)
        teamTxts.append(str)
        
        var gameInfo:[String] = []
        var playableGames:[String] = []
        
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: Date())
        let currentDay = calendar.component(.day, from: Date())
        
        
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
            
            
            if lines.count < 3
            {
                return []
            }else{
                for j in 1...lines.count-2
                {
                    gameInfo.append(lines[j])
                }
            }
            
            var dates:[String] = []
            for k in 0...gameInfo.count-1
            {
                let gameInfoPieces = gameInfo[k].components(separatedBy: ".")
                dates.append(gameInfoPieces[2])
            }
            
            //print(dates)
            
            
            for l in 0...dates.count-1
            {
                var dateComponents = dates[l].components(separatedBy: "/")
                if Int(dateComponents[0])! == currentMonth
                {
                    if Int(dateComponents[1])! >= currentDay
                    {
                        var str = gameInfo[l]
                        var correctTeam = ""
                        
                        correctTeam = teamTxts[i]
                        
                        str += "."; str += correctTeam
                        playableGames.append(str)
                    }
                }
                if Int(dateComponents[0])! > currentMonth
                {
                    var str = gameInfo[l]
                    var correctTeam = ""
                    
                    correctTeam = teamTxts[i]
                    
                    str += "."; str += correctTeam
                    playableGames.append(str)
                }
            }
            
        }
        return(playableGames)
    }
    
    func colorScheme(primaryColor: String, secondaryColor: String) -> SKColor
    {
        print(primaryColor)
        var bannerColor = SKColor.white
        if primaryColor == "AthleticGreen"
        {
            bannerColor = Colors.AthleticGreen
        }
        if primaryColor == "AstrosNavy"
        {
            bannerColor = Colors.AstrosNavy
        }
        if primaryColor == "AstrosOrange"
        {
            bannerColor = Colors.AstrosOrange
        }
        if primaryColor == "BlueJaysBlue"
        {
            bannerColor = Colors.BlueJaysBlue
        }
        if primaryColor == "CubsBlue"
        {
            bannerColor = Colors.CubsBlue
        }
        if primaryColor == "AngelsMaroon"
        {
            bannerColor = Colors.AngelsMaroon
        }
        if primaryColor == "MetsBlue"
        {
            bannerColor = Colors.MetsBlue
        }
        if primaryColor == "NationalsRed"
        {
            bannerColor = Colors.NationalsRed
        }
        if primaryColor == "RedSoxRed"
        {
            bannerColor = Colors.RedSoxRed
        }
        if primaryColor == "YankeesNavy"
        {
            bannerColor = Colors.YankeesNavy
        }
        if primaryColor == "CardinalsRed"
        {
            bannerColor = Colors.CardinalsRed
        }
        if primaryColor == "GiantsOrange"
        {
            bannerColor = Colors.GiantsOrange
        }
        if primaryColor == "BrewersGold"
        {
            bannerColor = Colors.BrewersGold
        }
        if primaryColor == "PhilliesRed"
        {
            bannerColor = Colors.PhilliesRed
        }
        if primaryColor == "RockyPurple"
        {
            bannerColor = Colors.RockyPurple
        }
        if primaryColor == "RoyalsBlue"
        {
            bannerColor = Colors.RoyalsBlue
        }
        if primaryColor == "MarinersNavy"
        {
            bannerColor = Colors.MarinersNavy
        }
        if primaryColor == "MarlinsLightBlue"
        {
            bannerColor = Colors.MarlinsLightBlue
        }
        if primaryColor == "PiratesGold"
        {
            bannerColor = Colors.PiratesGold
        }
        if primaryColor == "TigersNavy"
        {
            bannerColor = Colors.TigerNavy
        }
        if primaryColor == "TwinsNavy"
        {
            bannerColor = Colors.TwinsNavy
        }
        if primaryColor == "YankeesNavy"
        {
            bannerColor = Colors.YankeesNavy
        }
        if primaryColor == "RaysNavy"
        {
            bannerColor = Colors.RaysNavy
        }
        if primaryColor == "DiamondbackRed"
        {
            bannerColor = Colors.DiamondbackRed
        }
        if primaryColor == "ExposBlue"
        {
            bannerColor = Colors.ExposLightBlue
        }
        if primaryColor == "IndiansBlue"
        {
            bannerColor = Colors.IndiansBlue
        }
        if primaryColor == "OrioleOrange"
        {
            bannerColor = Colors.OrioleOrange
        }
        if primaryColor == "PadresGray"
        {
            bannerColor = Colors.PadresGray
        }
        if primaryColor == "RangersBlue"
        {
            bannerColor = Colors.RangersBlue
        }
        if primaryColor == "Black"
        {
            bannerColor = Colors.black
        }
        if primaryColor == "White"
        {
            bannerColor = Colors.white
        }
        
        
        
        //Secondary
        Team1Label.fontColor = SKColor.white
        if secondaryColor == "AthleticYellow"
        {
            Team1Label.fontColor = Colors.AthleticYellow
            Team1Label2.fontColor = Colors.AthleticYellow
        }
        if secondaryColor == "AstrosOrange"
        {
            Team1Label.fontColor = Colors.AstrosOrange
        }
        if secondaryColor == "CubsRed"
        {
            Team1Label.fontColor = Colors.CubsRed
        }
        if secondaryColor == "MetsOrange"
        {
            Team1Label.fontColor = Colors.MetsOrange
        }
        if secondaryColor == "AstrosNavy"
        {
            Team1Label.fontColor = Colors.AstrosNavy
            Team1Label2.fontColor = Colors.AstrosNavy
        }
        if secondaryColor == "AthleticYellow"
        {
            Team1Label.fontColor = Colors.AthleticYellow
        }
        if secondaryColor == "AstrosOrange"
        {
            Team1Label.fontColor = Colors.AstrosOrange
        }
        if secondaryColor == "CubsRed"
        {
            Team1Label.fontColor = Colors.CubsRed
        }
        if secondaryColor == "MetsOrange"
        {
            Team1Label.fontColor = Colors.MetsOrange
        }
        if secondaryColor == "AstrosNavy"
        {
            Team1Label.fontColor = Colors.AstrosNavy
        }
        if secondaryColor == "AngelsSilver"
        {
            Team1Label.fontColor = Colors.AngelsSilver
        }
        if secondaryColor == "CardinalsYellow"
        {
            Team1Label.fontColor = Colors.CardinalsYellow
        }
        if secondaryColor == "GiantsBlack"
        {
            Team1Label.fontColor = Colors.GiantsBlack
        }
        if secondaryColor == "BrewersNavy"
        {
            Team1Label.fontColor = Colors.BrewersNavy
        }
        if secondaryColor == "PhilliesBlue"
        {
            Team1Label.fontColor = Colors.PhilliesBlue
        }
        if secondaryColor == "RockySilver"
        {
            Team1Label.fontColor = Colors.RockySilver
        }
        if secondaryColor == "RoyalsGold"
        {
            Team1Label.fontColor = Colors.RoyalsGold
        }
        if secondaryColor == "MarinersGreen"
        {
            Team1Label.fontColor = Colors.MarinersGreen
        }
        if secondaryColor == "MarlinsGray"
        {
            Team1Label.fontColor = Colors.MarlinsGray
        }
        if secondaryColor == "PiratesBlack"
        {
            Team1Label.fontColor = Colors.PiratesBlack
        }
        if secondaryColor == "TigersOrange"
        {
            Team1Label.fontColor = Colors.TigerOrange
        }
        if secondaryColor == "TwinsRed"
        {
            Team1Label.fontColor = Colors.TwinsRed
        }
        if secondaryColor == "RaysLightBlue"
        {
            Team1Label.fontColor = Colors.RaysLightBlue
        }
        if secondaryColor == "DiamondbackSand"
        {
            Team1Label.fontColor = Colors.DiamondbackSand
        }
        if secondaryColor == "ExposRed"
        {
            Team1Label.fontColor = Colors.ExposRed
        }
        if secondaryColor == "IndiansRed"
        {
            Team1Label.fontColor = Colors.IndiansRed
        }
        if secondaryColor == "PadresBlue"
        {
            Team1Label.fontColor = Colors.PadresBlue
        }
        if secondaryColor == "RangersRed"
        {
            Team1Label.fontColor = Colors.RangersRed
        }
        if secondaryColor == "Black"
        {
            Team1Label.fontColor = SKColor.black
        }
        if secondaryColor == "White"
        {
            Team1Label.fontColor = SKColor.white
        }
        if bannerColor == Colors.white
        {
            Team1Label.fontColor = SKColor.black
        }
        
        Team1Label2.fontColor = Team1Label.fontColor
        
        //Personal Color
        if primaryColor == "White"
        {
            Personal = SKSpriteNode(imageNamed: "Personal")
        }
        
        return bannerColor
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
