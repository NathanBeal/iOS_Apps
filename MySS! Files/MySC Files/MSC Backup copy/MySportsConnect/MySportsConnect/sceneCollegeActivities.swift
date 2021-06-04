//
//  sceneCollegeActivities.swift
//  MySportsConnect
//
//  Created by ADAMLANE on 7/9/19.
//  Copyright © 2019 Nathan Beal Studios. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class sceneCollegeActivities: SKScene
{
    let Background = SKSpriteNode(imageNamed: "MSCBackground.")
    let MTBackground = SKSpriteNode(imageNamed: "MyTeamsBackground")
    let LocalTeams = SKSpriteNode(imageNamed: "Label")
    let CollegeRecTeams = SKSpriteNode(imageNamed: "Label")
    let AddTeamButton = SKSpriteNode(imageNamed: "AddTeam")
    
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
        MTBackground.position = CGPoint(x: self.size.width/2, y: 11 * self.size.height/10)
        MTBackground.zPosition = 1
        self.addChild(MTBackground)
    }
}
