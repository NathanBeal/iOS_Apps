//
//  PostGameScene.swift
//  A Lonely Star
//
//  Created by ADAMLANE on 5/13/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class PostGameScene: SKScene, SKPhysicsContactDelegate
{
    let bhHealth = 2.0
    var hitCount = -10
    var numHearts = 10
    var win = true
    
    
    let playerHealthLabel = SKLabelNode()
    let bhHealthLabel = SKLabelNode()
    
    //State Machines -> Determine Game
    enum gameState
    {
        case preGame
        case inGame
        case afterGame
    }
    var currentGameState = gameState.inGame //what it starts with
    
    //Sprites
    let player = SKSpriteNode(imageNamed: "LoneStar")
    let blackHole = SKSpriteNode(imageNamed: "Black Hole")
    
    let gameArea: CGRect
    
    struct PhysicsCategories
    {
        static let None: UInt32 = 0         //0
        static let Player: UInt32 = 0b1     //1
        static let Photon: UInt32 = 0b10    //2
        static let BlackHole: UInt32 = 0b11 //3
        static let Meteor: UInt32 = 0b100   //4
        static let Quasar: UInt32 = 0b101   //5
    }
    
    //Used for boundaries
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
    
    //Main Method for running
    override func didMove(to view: SKView)
    {
        self.physicsWorld.contactDelegate = self
        
        //Background
        let background = SKSpriteNode(imageNamed: "backgroundOld")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/4)
        background.zPosition = 0
        self.addChild(background)
        
        //A Lonely Star
        player.setScale(0.15)//allows to change size of ship
        player.position = CGPoint(x: self.size.width/2, y: self.size.height/3)
        player.zPosition = 5
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)//forces liek gravity
        player.physicsBody!.affectedByGravity = false // temporrily disable gravity
        player.physicsBody!.categoryBitMask = PhysicsCategories.Player//assigned physics body to plYWE
        
        player.physicsBody!.collisionBitMask = PhysicsCategories.None
        player.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Meteor
        self.addChild(player)
        
        //Black Hole
        blackHole.setScale(4.0)
        blackHole.position = CGPoint(x: self.size.width/2, y: self.size.height)
        blackHole.zPosition = 10
        blackHole.physicsBody = SKPhysicsBody(rectangleOf: blackHole.size)//forces liek gravity
        blackHole.physicsBody!.affectedByGravity = false
        blackHole.physicsBody!.categoryBitMask = PhysicsCategories.BlackHole
        //Collision and Contact
        blackHole.physicsBody!.collisionBitMask = PhysicsCategories.None
        blackHole.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Photon
        self.addChild(blackHole)
        
        //Star Health
        /*
        playerHealthLabel.text = "LS.HP = \(playerHealth)%"
        playerHealthLabel.fontSize = 70
        playerHealthLabel.fontColor = SKColor.white
        playerHealthLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        playerHealthLabel.position = CGPoint(x: self.size.width * 0.04, y: self.size.height * 0.35)
        playerHealthLabel.zPosition = 100
        self.addChild(playerHealthLabel)
 */
        
        
        //BlackHole Health
        bhHealthLabel.text = "BH.HP = \((defaults.double(forKey: "BHMax")/Variables.bhMaxHealth) * 100)%"
        bhHealthLabel.fontSize = 70
        bhHealthLabel.fontColor = SKColor.white
        bhHealthLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        bhHealthLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.63)
        bhHealthLabel.zPosition = 100
        self.addChild(bhHealthLabel)
        
        
        //let continualAttack = SKAction.run(continualAttacks)
        //let waitToSpawn = SKAction.wait(forDuration: 3)
        //let spawnSequence = SKAction.sequence([waitToSpawn,continualAttack])
        //let spawnForever = SKAction.repeatForever(spawnSequence)
        //if bhHealth/100 > 0.25
        //{
            //self.run(spawnForever)
        //}
        
        
        for _ in 0...40//for loop 10->11
        {
            let randomX = CGFloat.random(in: 0 ... self.size.width)
            let randomY = CGFloat.random(in: self.size.height/3 ... 2*self.size.height/3)
            
            let backgroundStar = SKSpriteNode(imageNamed: "Star")
            backgroundStar.setScale(0.05)
            backgroundStar.position = CGPoint(x: randomX, y: randomY)
            backgroundStar.zPosition = 2
            self.addChild(backgroundStar)
            //print("\(randomX) + \(randomY)")
        }
        

       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if currentGameState == gameState.inGame
        {
            firePhoton()
        }
        if(hitCount >= 1)
        {
            self.run(SKAction.run(drawHearts))
        }
        
        if(hitCount >= 20)
        {
            gameWin()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: player)
            let previousPointsOfTouch = touch.previousLocation(in: player)
            
            let amountDraggedY = pointOfTouch.y - previousPointsOfTouch.y
            let amountDraggedX = pointOfTouch.x - previousPointsOfTouch.x
            
            
            //Can adjust sensitivity of the star movement with divisors
            if currentGameState == gameState.inGame
            {
                player.position.x += amountDraggedX/3
                player.position.y += amountDraggedY/3
            }
            if player.position.x > gameArea.maxX
            {
                player.position.x = gameArea.maxX
            }
            if player.position.x < gameArea.minX //Left Side
            {
                player.position.x = gameArea.minX
            }
            
            //Specific tuning for values
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
    
    
    
    func firePhoton()
    {
        let photon = SKSpriteNode(imageNamed: "photon2")
        photon.name = "photon"
        photon.setScale(0.05)
        photon.position.x = player.position.x + 30;//Shifts photon towards the right to shoot
        photon.position.y = player.position.y
        photon.zPosition = 1
        photon.physicsBody = SKPhysicsBody(rectangleOf: photon.size)//forces like gravity
        photon.physicsBody!.affectedByGravity = false
        photon.physicsBody!.categoryBitMask = PhysicsCategories.Photon
        
        photon.physicsBody!.collisionBitMask = PhysicsCategories.None
        photon.physicsBody!.contactTestBitMask = PhysicsCategories.BlackHole
        self.addChild(photon)
        
        let movePhoton = SKAction.moveTo(y: self.size.height, duration: 1)//durTION 1 S
        let deletePhoton = SKAction.removeFromParent()
        let photonSequence = SKAction.sequence([movePhoton, deletePhoton])
        
        if currentGameState == gameState.inGame
        {
            photon.run(photonSequence)
        }
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
        
        //Collision choices
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.BlackHole
        {
            runGameOver()
        }
        if body1.categoryBitMask == PhysicsCategories.Photon && body2.categoryBitMask == PhysicsCategories.BlackHole
        {
            win = false
            hitCount += 1
            body1.node?.removeFromParent()
            print("\(hitCount)")
        }
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Meteor
        {
            //appendPlayerHP(health: 50.0)//Current amount damage does to star
            body2.node?.removeFromParent()
        }
        
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Quasar
        {
            //appendPlayerHP(health: 25.0)//Current amount damage does to star
        }
    }
    
    func drawHearts()
    {
        for i in 0...(9)//for loop 10->11
        {
            let heart = SKSpriteNode(imageNamed: "Heart")
            let X = (self.size.width/10 - 70.0) + (CGFloat)(55 * i)
            let Y = self.size.height * 0.35
            
            heart.setScale(0.09)
            heart.position = CGPoint(x: X, y: Y)
            heart.zPosition = 1000
            self.addChild(heart)
            print("draw")
        }
    }
    
    func runGameOver()
    {
        currentGameState = gameState.afterGame
        
        self.removeAllActions()
        self.enumerateChildNodes(withName: "photon")//List of photons
        {
            photon, stop in//calls all actions photon
            photon.removeAllActions()
        }
        self.enumerateChildNodes(withName: "meteor")//List of meteora
        {
            meteor, stop in//calls all actions photon
            meteor.removeAllActions()
        }
        
        //Could have star exploding, cinematic oppurtunities
        let changeSceneAction = SKAction.run(changeScene)
        let waitToChangeScene = SKAction.wait(forDuration:  1)
        let changeSceneSequence = SKAction.sequence([waitToChangeScene, changeSceneAction])
        self.run(changeSceneSequence)
    }
    
    func changeScene()
    {
        let sceneToMoveTo = GameOverScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 1.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func gameWin()
    {
        let sceneToMoveTo = GameWin(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 1.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
}
