//
//  blackOutScene.swift
//  A Lonely Star
//
//  Created by ADAMLANE on 5/12/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import GameplayKit

//var playerHealth = 100.0//sharing variable

var dead = false
class blackOutScene: SKScene, SKPhysicsContactDelegate
{
    var playerHealth = 100.0
    
    //try Passing
    //var pHealthValue: Float!
    
    
    let player = SKSpriteNode(imageNamed: "Heart")
    let playerDeath = SKSpriteNode(imageNamed: "HeartBroken")
    let playerHealthLabel = SKLabelNode()
    let gameArea: CGRect
    
    //Physics Bodies
    struct PhysicsCategories
    {
        static let None: UInt32 = 0         //0
        static let Player: UInt32 = 0b1     //1
        static let Meteor: UInt32 = 0b10    //2
    }
    
    //Sets up Game Area
    override init(size: CGSize)
    {
        let maxAspectRatio : CGFloat = 16.0/9.0
        let playableWidth = size.height/maxAspectRatio
        let margin = (size.width - playableWidth)/4
        gameArea = CGRect(x: margin, y: 0, width: playableWidth + margin, height: size.height)
        
        super.init(size: size)
    }
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView)//runs as soon as started
    {
        //print("\(GameScene.str)")
        self.physicsWorld.contactDelegate = self
        
        //Background
        let background = SKSpriteNode(imageNamed: "gameOverBackground")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        //Player
        player.setScale(0.15)//allows to change size of ship
        player.position = CGPoint(x: self.size.width/2, y: self.size.height/2.68)
        player.zPosition = 2
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody!.affectedByGravity = false
        player.physicsBody!.categoryBitMask = PhysicsCategories.Player
        player.physicsBody!.collisionBitMask = PhysicsCategories.None
        player.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Meteor
        self.addChild(player)
        
        //Health Label
        playerHealthLabel.text = "Resolve = \(playerHealth)%"
        playerHealthLabel.fontSize = 70
        playerHealthLabel.fontColor = SKColor.white
        playerHealthLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        playerHealthLabel.position = CGPoint(x: self.size.width * 0.04, y: self.size.height * 0.35)
        playerHealthLabel.zPosition = 100
        self.addChild(playerHealthLabel)
        
        
        //Scene Interaction
        if playerHealth > 0
        {
            continualAttacks()
        }
        let waitToChangeScene = SKAction.wait(forDuration:  7)
        
        
        
        //let checkResolve = SKAction.run(check)
        //let repeatCheck = SKAction.repeatForever(checkResolve)
        
        
        if(playerHealth > 0 && dead != true)
        {
            let leaveSceneAction = SKAction.run(playerLived)
            let leaveSequence = SKAction.sequence([waitToChangeScene, leaveSceneAction])
            self.run(leaveSequence)
        } 
    }
    
    func continualAttacks()
    {
        let meteors = SKAction.run(fireComet)
        let waitToSpawn = SKAction.wait(forDuration: 0.1)
        let spawnSequence = SKAction.sequence([meteors, waitToSpawn])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        self.run(spawnForever)
    }
    
    func didBegin(_ contact: SKPhysicsContact)//contact holds information of collision
    {
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask
        {
            body1 = contact.bodyA
            body2 = contact.bodyB
        }else{
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Meteor
        {
            appendPlayerHP(health: 10)
            body2.node?.removeFromParent()
        }
    }
    
    //Move Player
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: player)
            let previousPointsOfTouch = touch.previousLocation(in: player)
            
            let amountDraggedY = pointOfTouch.y - previousPointsOfTouch.y
            let amountDraggedX = pointOfTouch.x - previousPointsOfTouch.x
            
            if playerHealth > 0
            {
                player.position.x += amountDraggedX/3
                player.position.y += amountDraggedY/3
            }
            if player.position.x > gameArea.maxX
            {
                player.position.x = gameArea.maxX
            }
            if player.position.x < gameArea.minX
            {
                player.position.x = gameArea.minX
            }
            if player.position.y > (2*gameArea.maxY)/3 - 47
            {
                player.position.y = (2*gameArea.maxY)/3 - 47
            }
            if player.position.y < gameArea.maxY/3 + 25
            {
                player.position.y = gameArea.maxY/3 + 25
            }
        }
    }
    
    func appendPlayerHP(health: Double)
    {
        playerHealth = playerHealth - health
        playerHealthLabel.text = "Resolve = \(playerHealth)%"
        
        if(playerHealth < 1)
        {
            print(("dead"))
            dead = true
            //death()
            let step1 = SKAction.run(death)
            let step2 = SKAction.wait(forDuration:  3)
            let step3 = SKAction.run(playerDied)
             
            let endSequence = SKAction.sequence([step1,step2,step3])
            self.run(endSequence)
        }
    }
    
    func fireComet()
    {
        //Meteor Initialization
        let meteor = SKSpriteNode(imageNamed: "Meteor")
        meteor.name = "meteor"
        meteor.setScale(0.3)
        meteor.position.x = CGFloat.random(in: 0 ... self.size.width)
        meteor.position.y = 3 * self.size.height/4
        meteor.zPosition = 1
        meteor.physicsBody = SKPhysicsBody(rectangleOf: meteor.size)
        meteor.physicsBody!.affectedByGravity = false
        meteor.physicsBody!.categoryBitMask = PhysicsCategories.Meteor
        meteor.physicsBody!.collisionBitMask = PhysicsCategories.None
        meteor.physicsBody!.contactTestBitMask = PhysicsCategories.Player
        self.addChild(meteor)
        
        //Meteor Sequence
        let moveMeteor = SKAction.moveTo(y: 0-meteor.size.width, duration: 1.25)
        let deleteMeteor = SKAction.removeFromParent()
        let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
        
        //Runs the Sequence
        meteor.run(meteorSequence)
    }
    
    

    
    func death()
    {
        let temp = defaults.integer(forKey: "Score") + 1
        defaults.set(temp, forKey: "Score")
        
        player.removeFromParent()
        
        playerDeath.setScale(0.15)//allows to change size of ship
        playerDeath.position = CGPoint(x: player.position.x, y: player.position.y)
        player.removeFromParent()
        playerDeath.zPosition = 2
        self.addChild(playerDeath)
        
        let wait = SKAction.wait(forDuration:  1)
        self.run(wait)
        
        let playerPiece1 = SKSpriteNode(imageNamed: "HP1")
        let playerPiece2 = SKSpriteNode(imageNamed: "HP2")
        let playerPiece3 = SKSpriteNode(imageNamed: "HP3")
        let playerPiece4 = SKSpriteNode(imageNamed: "HP4")
        let playerPiece5 = SKSpriteNode(imageNamed: "HP5")
        playerPiece1.setScale(0.15)//allows to change size of ship
        playerPiece1.position = CGPoint(x: playerDeath.position.x, y: playerDeath.position.y)
        playerPiece1.zPosition = 2
        playerPiece2.setScale(0.15)//allows to change size of ship
        playerPiece2.position = CGPoint(x: playerDeath.position.x, y: playerDeath.position.y)
        playerPiece2.zPosition = 2
        playerPiece3.setScale(0.15)//allows to change size of ship
        playerPiece3.position = CGPoint(x: playerDeath.position.x, y: playerDeath.position.y)
        playerPiece3.zPosition = 2
        playerPiece4.setScale(0.15)//allows to change size of ship
        playerPiece4.position = CGPoint(x: playerDeath.position.x, y: playerDeath.position.y)
        playerPiece4.zPosition = 2
        playerPiece5.setScale(0.15)//allows to change size of ship
        playerPiece5.position = CGPoint(x: playerDeath.position.x, y: playerDeath.position.y)
        playerPiece5.zPosition = 2
        self.addChild(playerPiece1)
        self.addChild(playerPiece2)
        self.addChild(playerPiece3)
        self.addChild(playerPiece4)
        self.addChild(playerPiece5)
        let movePiece1 = SKAction.moveTo(y: -100, duration: 1.25)
        let movePiece2 = SKAction.moveTo(x: 2000, duration: 1.25)
        let movePiece3 = SKAction.moveTo(y: self.size.height, duration: 1.25)
        let movePiece4 = SKAction.moveTo(x: 0, duration: 1.25)
        let movePiece5 = SKAction.moveTo(y: -100, duration: 1.25)
        
        let deletePiece = SKAction.removeFromParent()
        
        let waitTime = SKAction.wait(forDuration: 1.5)
        let endSequence1 = SKAction.sequence([waitTime, movePiece1, deletePiece])
        let endSequence2 = SKAction.sequence([waitTime, movePiece2, deletePiece])
        let endSequence3 = SKAction.sequence([waitTime, movePiece3, deletePiece])
        let endSequence4 = SKAction.sequence([waitTime, movePiece4, deletePiece])
        let endSequence5 = SKAction.sequence([waitTime, movePiece5, deletePiece])
        
        
        playerPiece1.run(endSequence1)
        playerPiece2.run(endSequence2)
        playerPiece3.run(endSequence3)
        playerPiece4.run(endSequence4)
        playerPiece5.run(endSequence5)
        playerDeath.run(deletePiece)
    }
    
    func playerDied()
    {
        let sceneToMoveTo = GameOverScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  2.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func playerLived()
    {
        let sceneToMoveTo = GameScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  2)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
}
