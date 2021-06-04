//
//  Team2ContactPage.swift
//  MySportsConnect
//
//  Created by ADAMLANE on 7/19/19.
//  Copyright © 2019 Nathan Beal Studios. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Team2ContactPage: SKScene
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
    let Team1Label = SKLabelNode()
    let Team1Label2 = SKLabelNode()
    
    let Standings = SKSpriteNode(imageNamed: "Standings")
    let Home = SKSpriteNode(imageNamed: "Home")
    let Contact = SKSpriteNode(imageNamed: "Contacts")
    
    let ShadeOut = SKSpriteNode(imageNamed: "ShadeOut")
    
    let contactDetails = SKLabelNode()
    
    //Banner
    var TeamBannerRect = CGRect(); var TeamBanner = SKShapeNode()
    var TeamBannerMenuRect = CGRect(); var TeamBannerMenu = SKShapeNode()
    
    var personalAdjust = CGFloat()
    
    var gameView = false
    var lazyCoding = 0
    
    
    //Used for boundaries
    override func didMove(to view: SKView)
    {
        let temp = String(defaults.string(forKey: "Team2Txt")!)
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
        }
        
        TeamBanner = SKShapeNode.init(rect: TeamBannerRect)
        TeamBanner.fillColor = colorScheme(primaryColor: colors[0], secondaryColor: colors[1])
        TeamBanner.zPosition = 10
        TeamBanner.strokeColor = SKColor.black
        TeamBanner.lineWidth = 4
        self.addChild(TeamBanner)
        
        TeamBannerMenu = SKShapeNode.init(rect: TeamBannerMenuRect)
        TeamBannerMenu.fillColor = colorScheme(primaryColor: colors[0], secondaryColor: colors[1])
        TeamBannerMenu.zPosition = 10
        TeamBannerMenu.strokeColor = SKColor.black
        TeamBannerMenu.lineWidth = 4
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
        
        //Home Button
        Personal.setScale(CGFloat(0.35 * scaleModifier))
        Personal.position = CGPoint(x: TeamBannerRect.width/10, y: personalAdjust)
        Personal.zPosition = 15
        self.addChild(Personal)
        
        
        //Team Labeling
        let Team = defaults.string(forKey: "Team2")
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
        Team1Label.alpha = 1
        self.addChild(Team1Label)
        
        Team1Label2.position = CGPoint(x: self.size.width/2, y: TeamBannerRect.midY - (TeamBannerRect.midY/25))
        Team1Label2.text = "(" + TeamParts[1]
        Team1Label2.fontSize = CGFloat(25 * scaleModifier)
        Team1Label2.fontName = "Avenir-BookOblique"//"Baskerville-SemiBold"
        Team1Label2.zPosition = 10
        Team1Label2.alpha = 1
        self.addChild(Team1Label2)
        
        contactDetails.position = CGPoint(x: 5 * self.size.width/10, y: 8.3 * gameArea.height/10)
        contactDetails.text = "There are no contacts available"
        contactDetails.fontName = "HelveticaNeue"
        contactDetails.fontSize = CGFloat(30 * scaleModifier)
        contactDetails.fontColor = SKColor.white
        contactDetails.zPosition = 2
        contactDetails.alpha = 0
        self.addChild(contactDetails)
        
        
        //Menu Labels
        Standings.setScale(CGFloat(1 * scaleModifier))
        Standings.position = CGPoint(x: 3 * TeamBannerMenuRect.maxX/16, y: TeamBannerMenuRect.midY)
        Standings.zPosition = 10
        self.addChild(Standings)
        
        Home.setScale(CGFloat(1 * scaleModifier))
        Home.position = CGPoint(x: TeamBannerMenuRect.maxX/2, y: TeamBannerMenuRect.midY)
        Home.zPosition = 10
        self.addChild(Home)
        
        Contact.setScale(CGFloat(1 * scaleModifier))
        Contact.position = CGPoint(x: 13 * self.size.width/16, y: TeamBannerMenuRect.midY)
        Contact.zPosition = 10
        self.addChild(Contact)
        
        fadeIn()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            
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
            
            //Standings
            if (pointOfTouch.x > 0/3 * self.size.width && pointOfTouch.x < 1/3 * self.size.width) && (pointOfTouch.y < self.size.height && pointOfTouch.y > self.size.height - 1.25 * self.size.height/10)
            {
                self.run(SKAction.run(fadeOut))
                
                let wait = SKAction.wait(forDuration: 0.6)
                let changeScene = SKAction.run(teamStandings)
                let sequence = SKAction.sequence([wait, changeScene])
                self.run(sequence)
            }
            
            //Team Home Page
            if (pointOfTouch.x > 1/3 * self.size.width && pointOfTouch.x < 2/3 * self.size.width) && (pointOfTouch.y < self.size.height && pointOfTouch.y > self.size.height - 1.25 * self.size.height/10)
            {
                self.run(SKAction.run(fadeOut))
                
                let wait = SKAction.wait(forDuration: 0.6)
                let changeScene = SKAction.run(teamHomePage)
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
    
    func mainPage()
    {
        let sceneToMoveTo = MyTeams(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func teamHomePage()
    {
        let sceneToMoveTo = Team2HomePage(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func teamStandings()
    {
        let sceneToMoveTo = Team2Standings(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    //Transitional Fade Outs
    func fadeOutMain()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        
        contactDetails.run(fadeOut); Personal.run(fadeOut)
        
        Team1Label.run(fadeOut); Team1Label2.run(fadeOut)
        Standings.run(fadeOut); Home.run(fadeOut); Contact.run(fadeOut)
        
        TeamBanner.run(fadeOut); TeamBannerMenu.run(fadeOut)
        
        let systemWait = SKAction.wait(forDuration: 0.5)
        self.run(systemWait)
    }
    
    func fadeIn()
    {
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        contactDetails.run(fadeIn)
        
        let systemWait = SKAction.wait(forDuration: 0.5)
        self.run(systemWait)
    }
    
    func fadeOut()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        contactDetails.run(fadeOut)
        
        let systemWait = SKAction.wait(forDuration: 0.5)
        self.run(systemWait)
    }
    
    func colorScheme(primaryColor: String, secondaryColor: String) -> SKColor
    {
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
}
