//
//  QuoteScreen.swift
//  A Lonely Star
//
//  Created by ADAMLANE on 3/16/20.
//  Copyright © 2020 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class QuoteScreen: SKScene, SKPhysicsContactDelegate
{
    var background = SKSpriteNode()
    var topMessageLabel = SKLabelNode()
    var topMessageTranslatedLabel = SKLabelNode()
    var bottomMessageLabel = SKLabelNode()
    var bottomMessageTranslatedLabel = SKLabelNode()
    var attributedSource = SKLabelNode()
    
    override func didMove(to view: SKView)
    {
        background = SKSpriteNode(imageNamed: "gameOverBackground")
        Utilities.setBackground(background, size: self.size, xPos: self.size.width/2, yPos: self.size.height/2)
        self.addChild(background)
        
        var messageString = ". - -      . . . .     . -     -           . . . .     . -     -       . . . ."
        Utilities.initText(topMessageLabel, message: messageString, fontName: "Hoefler Text", fontSize: 40, color: SKColor.white, xPos: self.size.width/2, yPos: self.size.height/1.7)
        self.addChild(topMessageLabel)
        
        messageString = "- - .     . .     - . .           . - -       . . .       . .         . . -       - - .       . . .       -         . . - - . ."
        Utilities.initText(bottomMessageLabel, message: messageString, fontName: "Hoefler Text", fontSize: 40, color: SKColor.white, xPos: self.size.width/2, yPos: self.size.height/2)
        bottomMessageLabel.alpha = 1
        self.addChild(bottomMessageLabel)
        
        messageString = "W   H   A   T          H   A   T   H"
        Utilities.initText(topMessageTranslatedLabel, message: messageString, fontName: "Hoefler Text", fontSize: 60, color: SKColor.white, xPos: self.size.width/2, yPos: self.size.height/1.85)
        topMessageTranslatedLabel.alpha = 0
        self.addChild(topMessageTranslatedLabel)
        
        messageString = "G   O   D          W   R   O   U   G   H   T   ?"
        Utilities.initText(bottomMessageTranslatedLabel, message: messageString, fontName: "Hoefler Text", fontSize: 60, color: SKColor.white, xPos: self.size.width/2, yPos: self.size.height/2.2)
        bottomMessageTranslatedLabel.alpha = 0
        self.addChild(bottomMessageTranslatedLabel)
        
        self.run(SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.run(fadeInTranslation)]))
        
        let sourceSeq = SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.fadeIn(withDuration: 2)])
        attributedSource.run(sourceSeq)
        
        let transitionSeq = SKAction.sequence([SKAction.wait(forDuration: 3), SKAction.run(fadeOutElements), SKAction.wait(forDuration: 3), (SKAction.run(transitionNextScreen))])
        self.run(transitionSeq)
    }
    
    func fadeInTranslation()
    {
        topMessageTranslatedLabel.run(SKAction.fadeIn(withDuration: 1.5))
        bottomMessageTranslatedLabel.run(SKAction.fadeIn(withDuration: 1.5))
    }
    
    func fadeOutElements()
    {
        topMessageLabel.run(SKAction.fadeOut(withDuration: 1.0))
        bottomMessageLabel.run(SKAction.fadeOut(withDuration: 1.0))
        attributedSource.run(SKAction.fadeOut(withDuration: 1.0))
    }
    
    func transitionNextScreen()
    {
        let sceneToMoveTo = PlanetHopping(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 1.75)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
}
