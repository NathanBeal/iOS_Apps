//
//  GameScene.swift
//  A Lonely Star
//
//  Created by ADAMLANE on 5/9/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import SpriteKit
import GameplayKit

var animator: UIDynamicAnimator?
let defaults = UserDefaults()

class GameScene: SKScene, SKPhysicsContactDelegate
{
    //Health
    
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
    
    var progressValue = 200
    
    //Sprites
    let player = SKSpriteNode(imageNamed: "LoneStar")
    let blackHole = SKSpriteNode(imageNamed: "Black Hole")
    var playerHealthBar = SKSpriteNode(color: SKColor.green, size: CGSize(width: 600 * (defaults.double(forKey: "SHMax") / Variables.starMaxHealth), height: 60))
    var bhHealthBar = SKSpriteNode(color: SKColor.red, size: CGSize(width: 1000 * (defaults.double(forKey: "BHMax") / Variables.bhMaxHealth), height: 60))
    
    
    
    
    
    
   //let gravity = UIGravityBehavior(items: )//self.player)
    
    
    
    
    
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
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/3)
        background.zPosition = 0
        self.addChild(background)
        
        //A Lonely Star
        player.setScale(0.15)//allows to change size of ship
        player.position = CGPoint(x: 0-self.size.width/4, y: self.size.height/2)
        player.zPosition = 5
        
        //Movement into spot
        let moveStar = SKAction.moveTo(x: self.size.width/6, duration: 1.0)
        let rotateStar = SKAction.rotate(byAngle: 6.3, duration: 1.0)//in radians
        player.run(rotateStar)
        player.run(moveStar)
        
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)//forces liek gravity
        player.physicsBody!.affectedByGravity = false // temporrily disable gravity
        player.physicsBody!.categoryBitMask = PhysicsCategories.Player//assigned physics body to plYWE
        
        player.physicsBody!.collisionBitMask = PhysicsCategories.None
        player.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Meteor
        self.addChild(player)
        
        //Black Hole
        blackHole.setScale(1.0)
        blackHole.position = CGPoint(x: self.size.width, y: self.size.height/2)
        blackHole.zPosition = 10
        blackHole.physicsBody = SKPhysicsBody(rectangleOf: blackHole.size)//forces liek gravity
        blackHole.physicsBody!.affectedByGravity = false
        blackHole.physicsBody!.categoryBitMask = PhysicsCategories.BlackHole
        //Collision and Contact
        blackHole.physicsBody!.collisionBitMask = PhysicsCategories.None
        blackHole.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Photon
        self.addChild(blackHole)
        
        //Star Health Bar
        playerHealthBar.position = CGPoint(x: self.size.width * 0.04, y: self.size.height * 0.37)
        playerHealthBar.zPosition = 11
        playerHealthBar.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        self.addChild(playerHealthBar)

        //Star Health Percentage
        playerHealthLabel.text = "LS.HP = \((defaults.double(forKey: "SHMax") / Variables.starMaxHealth) * 100)%"
        playerHealthLabel.fontSize = 40
        playerHealthLabel.fontColor = SKColor.white
        playerHealthLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        playerHealthLabel.position = CGPoint(x: self.size.width * 0.04, y: self.size.height * 0.39)
        playerHealthLabel.zPosition = 100
        self.addChild(playerHealthLabel)
        
        
        //BlackHole Health Bar
        bhHealthBar.position = CGPoint(x: self.size.width * 0.17, y: self.size.height * 0.63)
        bhHealthBar.zPosition = 11
        bhHealthBar.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        self.addChild(bhHealthBar)
        
        //BlackHole Health
        bhHealthLabel.text = "BH.HP = \((defaults.double(forKey: "BHMax")/Variables.bhMaxHealth) * 100)%"
        bhHealthLabel.fontSize = 40
        bhHealthLabel.fontColor = SKColor.white
        bhHealthLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        bhHealthLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.65)
        bhHealthLabel.zPosition = 100
        self.addChild(bhHealthLabel)
        
        
        let continualAttack = SKAction.run(continualAttacks)
        let waitToSpawn = SKAction.wait(forDuration: 2)
        let spawnSequence = SKAction.sequence([waitToSpawn,continualAttack])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        if (defaults.double(forKey: "BHMax")/Variables.bhMaxHealth) > 0.25
        {
            self.run(spawnForever)
        }
        
        for _ in 0...40//for loop 10->11
        {
            let randomX = CGFloat.random(in: 0 ... self.size.width)
            let randomY = CGFloat.random(in: self.size.height/3 ... 2*self.size.height/3)
            
            let backgroundStar = SKSpriteNode(imageNamed: "Star")
            backgroundStar.setScale(0.05)
            backgroundStar.position = CGPoint(x: randomX, y: randomY)
            backgroundStar.zPosition = 2
            self.addChild(backgroundStar)
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
            if (defaults.double(forKey: "BHMax")/Variables.bhMaxHealth) > 0.2
            {
                appendBHHP(health: 10)
            }else{
                appendBHHP(health: 0)
            }
            body1.node?.removeFromParent()
        }
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Meteor
        {
            appendPlayerHP(health: 50.0)//Current amount damage does to star
            body2.node?.removeFromParent()
        }
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Quasar
        {
            appendPlayerHP(health: 25.0)//Current amount damage does to star
        }
    }
    
    func appendPlayerHP(health: Double)
    {
        let temp = defaults.double(forKey: "SHMax") - health
        defaults.set(temp, forKey: "SHMax")
        
        //Health Bar
        playerHealthBar.removeFromParent()
        if defaults.double(forKey: "SHMax") <= 0
        {
            playerHealthBar = SKSpriteNode(color: SKColor.green, size: CGSize(width: 600 * 0, height: 60))
        }else{
            playerHealthBar = SKSpriteNode(color: SKColor.green, size: CGSize(width: 600 * (defaults.double(forKey: "SHMax") / Variables.starMaxHealth), height: 60))
        }
        playerHealthBar.position = CGPoint(x: self.size.width * 0.04, y: self.size.height * 0.37)
        playerHealthBar.zPosition = 11
        playerHealthBar.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        self.addChild(playerHealthBar)
        
        
        playerHealthLabel.text = "LS.HP = \((defaults.double(forKey: "SHMax") / Variables.starMaxHealth) * 100)%"
        
        if(defaults.double(forKey: "SHMax") <= 0)
        {
            runGameOver()
        }
    }
    
    func appendBHHP(health: Double)
    {
        let temp = defaults.double(forKey: "BHMax") - health
        defaults.set(temp, forKey: "BHMax")
        
        bhHealthBar.removeFromParent()
        if defaults.double(forKey: "BHMax") <= 0
        {
            bhHealthBar = SKSpriteNode(color: SKColor.red, size: CGSize(width: 1000 * 0, height: 60))
        }else{
            bhHealthBar = SKSpriteNode(color: SKColor.red, size: CGSize(width: 1000 * (defaults.double(forKey: "BHMax") / Variables.bhMaxHealth), height: 60))
        }
        bhHealthBar.position = CGPoint(x: self.size.width * 0.17, y: self.size.height * 0.63)
        bhHealthBar.zPosition = 11
        bhHealthBar.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        self.addChild(bhHealthBar)
        
        bhHealthLabel.text = "BH.HP = \((defaults.double(forKey: "BHMax")/Variables.bhMaxHealth) * 100)%"
        
        if (defaults.double(forKey: "BHMax")/Variables.bhMaxHealth) == 0.20
        {
            print("here")
            let wait = SKAction.wait(forDuration: 0.45)
            let ending = SKAction.run(setupPostGame)
            let ending2 = SKAction.run(postGame)
            let waitToRun = SKAction.wait(forDuration: 2.0)
            let endingSequence = SKAction.sequence([wait,ending,waitToRun,ending2])
            self.run(endingSequence)
        }
    }
    
    func continualAttacks()
    {
        if (defaults.double(forKey: "BHMax")/Variables.bhMaxHealth) > 0.20
        {
            let attacks = ["ma","qs","bo","ma"]
            let selection = Int.random(in: 0 ... 3)//size
            
            //var action = SKAction()
            let attack = attacks[(selection)]
            if attack == "ma"
            {
                run(SKAction.run(fireComet))
                print("ma")
            }
            if attack == "bo"//off
            {
                print("bo")
                let sceneToMoveTo = blackOutScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            if attack == "qs"
            {
                print("qs")
                run(SKAction.run(fireQuasar))
            }
        }
    }
    
    
    func firePhoton()
    {
        let photon = SKSpriteNode(imageNamed: "photon")
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
        
        let movePhoton = SKAction.moveTo(x: self.size.width+photon.size.width, duration: 1)//durTION 1 S
        let deletePhoton = SKAction.removeFromParent()
        let photonSequence = SKAction.sequence([movePhoton, deletePhoton])
        
        if currentGameState == gameState.inGame
        {
            photon.run(photonSequence)
        }
    }
    
    func fireComet()
    {
        let meteor = SKSpriteNode(imageNamed: "Meteor")
        meteor.name = "meteor"
        meteor.setScale(0.3)
        
        meteor.position.x = blackHole.position.x
        //meteor.position.y = CGFloat.random(in: 0 ... self.size.width)
        meteor.position.y = player.position.y//sometoems does that
        meteor.position.y = CGFloat.random(in: self.size.height/3 ... 2 * self.size.height/3)
            
        meteor.zPosition = 1
        meteor.physicsBody = SKPhysicsBody(rectangleOf: meteor.size)//forces liek gravity
        meteor.physicsBody!.affectedByGravity = false // temporrily disable gravity
        meteor.physicsBody!.categoryBitMask = PhysicsCategories.Meteor
        //lets us know what it collides with
        meteor.physicsBody!.collisionBitMask = PhysicsCategories.None
        meteor.physicsBody!.contactTestBitMask = PhysicsCategories.Player
        self.addChild(meteor)
        
        let moveMeteor = SKAction.moveTo(x: 0-meteor.size.width, duration: 1.25)//distance to travel
        let deleteMeteor = SKAction.removeFromParent()
        let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
        
        if currentGameState == gameState.inGame
        {
            meteor.run(meteorSequence)
        }
    }
    
    func fireQuasar()
    {
        print("here")
        let quasar = SKSpriteNode(imageNamed: "Quasar")
        quasar.setScale(0.75)
        quasar.position.x = self.size.width/2
        quasar.position.y = self.size.height/2
        quasar.zPosition = 101
        quasar.physicsBody = SKPhysicsBody(texture: quasar.texture!, size: quasar.texture!.size())
        quasar.physicsBody!.affectedByGravity = false // temporrily disable gravity
        quasar.physicsBody!.categoryBitMask = PhysicsCategories.Quasar
        //lets us know what it collides with
        quasar.physicsBody!.collisionBitMask = PhysicsCategories.None
        quasar.physicsBody!.contactTestBitMask = PhysicsCategories.Player
        self.addChild(quasar)
        
        let waitToEnd = SKAction.wait(forDuration:  2)
        let remove = SKAction.removeFromParent()
        let removeQuasar = SKAction.sequence([waitToEnd, remove])
        
        if currentGameState == gameState.inGame
        {
            quasar.run(removeQuasar)
        }
    }
    
    //A tap on screenfires a photon
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if currentGameState == gameState.inGame
        {
            firePhoton()
        }
    }
    //Boundaries and drag finger movement
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
    
    //Changes scene
    func changeScene()
    {
        let sceneToMoveTo = GameOverScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        
        let temp = defaults.integer(forKey: "Score") + 1
        defaults.set(temp, forKey: "Score")
    }
    
    func setupPostGame()
    {
        let moveBH = SKAction.moveTo(x: self.size.width+blackHole.size.width, duration: 1.25)
        let moveStar = SKAction.moveTo(x: self.size.width+player.size.width, duration: 1.5)
        
        let delete = SKAction.removeFromParent()
        let BHSequence = SKAction.sequence([moveBH, delete])
        let PlayerSequence = SKAction.sequence([moveStar, delete])
        
        blackHole.run(BHSequence)
        player.run(PlayerSequence)
        
    }
    
    func postGame()
    {
        let sceneToMoveTo = GSPGS(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 1.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
}
