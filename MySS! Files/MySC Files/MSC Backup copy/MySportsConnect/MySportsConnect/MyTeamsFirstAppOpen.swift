//
//  MyTeams-FirstAppOpen.swift
//  MySportsConnect
//
//  Created by ADAMLANE on 7/22/19.
//  Copyright © 2019 Nathan Beal Studios. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class MyTeamsFirstAppOpen: SKScene
{
    let Background = SKSpriteNode(imageNamed: "MSCBackground.")
    let AddTeamButton = SKSpriteNode(imageNamed: "AddTeam")
    let MySportsLabel = SKLabelNode()
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
        defaults.set(true, forKey: "firstOpen")
        defaults.set("None", forKey: "Team1")
        defaults.set("None", forKey: "Team2")
        defaults.set("None", forKey: "Team3")
        defaults.set("None", forKey: "Team4")
        defaults.set("None", forKey: "Team5")
        defaults.set("None", forKey: "Team6")
        
        defaults.set("None", forKey: "Team1Txt")
        defaults.set("None", forKey: "Team2Txt")
        defaults.set("None", forKey: "Team3Txt")
        defaults.set("None", forKey: "Team4Txt")
        defaults.set("None", forKey: "Team5Txt")
        
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
        TeamBanner = SKShapeNode.init(rect: TeamBannerRect)
        
        TeamBanner.fillColor = Colors.LafMaroon
        TeamBanner.zPosition = 1
        TeamBanner.strokeColor = SKColor.black
        TeamBanner.lineWidth = 4
        self.addChild(TeamBanner)
        
        MySportsLabel.position = CGPoint(x: self.size.width/2, y: TeamBannerRect.midY - (TeamBannerRect.midY/50))
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
        self.addChild(AddTeamButton)
        
        MySportsLabel.run(SKAction.fadeAlpha(by: 1, duration: 0.75))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            
            if (pointOfTouch.x > 9 * self.size.width/10 - AddTeamButton.size.width/2 && pointOfTouch.x < 9 * self.size.width/10 + AddTeamButton.size.width/2) && (pointOfTouch.y < 0.75 * self.size.height/10 + AddTeamButton.size.height/2 && pointOfTouch.y > 0.75 * self.size.height/10 - AddTeamButton.size.height/2)
            {
                //MySportsLabel
                let labelFadeOut = SKAction.fadeOut(withDuration: 0.75)
                let fadeOut = SKAction.fadeOut(withDuration: 0.375)
                
                AddTeamButton.run(fadeOut)
                
                let wait = SKAction.wait(forDuration: 0.75)
                let changeScene = SKAction.run(AddTeamScene)
                MySportsLabel.run(labelFadeOut)
                let sequence = SKAction.sequence([wait, changeScene])
                self.run(sequence)
            }
        }
    }
    
    func AddTeamScene()
    {
        let sceneToMoveTo = Leagues(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
}
