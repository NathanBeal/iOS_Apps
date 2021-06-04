//
//  IntroCard.swift
//  MySportsConnect
//
//  Created by ADAMLANE on 7/19/19.
//  Copyright © 2019 Nathan Beal Studios. All rights reserved.
//
import Foundation
import SpriteKit
import GameplayKit

let scaleModifier = defaults.double(forKey: "scaleMod")
let selfWidth = defaults.double(forKey: "FrameWidth")
var selfHeight = defaults.double(forKey: "FrameHeight")
class IntroCard: SKScene
{
    let AppLogoBackground = SKSpriteNode(imageNamed: "AppIconBackground")
    let AppLogo = SKSpriteNode(imageNamed: "180")
    let AppLogoRect = CGRect(x: 2.75 * selfWidth/10, y: 3 * selfHeight/10, width: 4.5 * selfWidth/10, height: 3 * selfHeight/10)
    
    let AppName = SKLabelNode()
    let CompanyName = SKLabelNode()
    let CompanyAnd = SKLabelNode()
    let MyCompany = SKLabelNode()
    
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
        //Background
        AppLogoBackground.size = self.size
        AppLogoBackground.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        AppLogoBackground.zPosition = 0
        self.addChild(AppLogoBackground)
        
        AppLogo.size = AppLogo.size
        AppLogo.position = CGPoint(x: self.size.width/2, y: 5.25 * self.size.height/10)
        AppLogo.zPosition = 1
        self.addChild(AppLogo)
        
        AppName.position = CGPoint(x: self.size.width/2, y: 8 * self.size.height/10)
        AppName.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        AppName.text = "My Sports Connect"
        AppName.fontName = "HelveticaNeue-Light"
        AppName.fontSize = CGFloat(40)
        AppName.fontColor = SKColor.white
        AppName.zPosition = 1
        self.addChild(AppName)
        
        CompanyName.position = CGPoint(x: self.size.width/2, y: 2 * self.size.height/10)
        CompanyName.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        CompanyName.text = "N & M Connections"
        CompanyName.fontSize = CGFloat(30)
        CompanyName.fontColor = SKColor.white
        CompanyName.zPosition = 1
        self.addChild(CompanyName)
        
        CompanyAnd.position = CGPoint(x: self.size.width/2, y: 1.5 * self.size.height/10)
        CompanyAnd.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        CompanyAnd.text = "&"
        CompanyAnd.fontSize = CGFloat(30)
        CompanyAnd.fontColor = SKColor.white
        CompanyAnd.zPosition = 1
        self.addChild(CompanyAnd)
        
        MyCompany.position = CGPoint(x: self.size.width/2, y: 1.0 * self.size.height/10)
        MyCompany.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        MyCompany.text = "Nathan Beal Studios"
        MyCompany.fontSize = CGFloat(30)
        MyCompany.fontColor = SKColor.white
        MyCompany.zPosition = 1
        self.addChild(MyCompany)
        
        let step1 = SKAction.wait(forDuration:  2.5)
        let step2 = SKAction.run(changeScenes)
        let endSequence = SKAction.sequence([step1,step2])
        self.run(endSequence)
    }
    
    func changeScenes()
    {
        if defaults.bool(forKey: "firstOpen") == false
        {
            self.removeAllChildren()
            let sceneToMoveTo = MyTeamsFirstAppOpen(size: self.size)
            sceneToMoveTo.scaleMode = self.scaleMode
            let myTransition = SKTransition.fade(withDuration:  1.0)
            self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        }else{
            self.removeAllChildren()
            let sceneToMoveTo = MyTeams(size: self.size)
            sceneToMoveTo.scaleMode = self.scaleMode
            let myTransition = SKTransition.fade(withDuration:  1.0)
            self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for _: AnyObject in touches
        {
            if defaults.bool(forKey: "firstOpen") == false
            {
                self.removeAllChildren()
                let sceneToMoveTo = MyTeamsFirstAppOpen(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration:  1.0)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }else{
                self.removeAllChildren()
                let sceneToMoveTo = MyTeams(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration:  1.0)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
        }
    }
}
