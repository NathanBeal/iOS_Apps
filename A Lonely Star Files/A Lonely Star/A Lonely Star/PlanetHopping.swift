//
//  PlanetHopping.swift
//  A Lonely Star
//
//  Created by ADAMLANE on 3/16/20.
//  Copyright © 2020 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class PlanetHopping: SKScene, SKPhysicsContactDelegate
{
    var background = SKSpriteNode()
    let ALS = SKSpriteNode(imageNamed: "LoneStar")
    
    override func didMove(to view: SKView)
    {
        let height = self.size.height/2
        background = SKSpriteNode(imageNamed: "gameOverBackground")
        Utilities.setBackground(background, size: self.size, xPos: self.size.width/2, yPos: self.size.height/2)
        self.addChild(background)
        
        ALS.setScale(0.1)//allows to change size of ship
        ALS.position = CGPoint(x: self.size.width/10, y: self.size.height/2)
        ALS.zPosition = 11
        self.addChild(ALS)
 
        for _ in 0...40//for loop 10->11
        {
            let randomX = CGFloat.random(in: 0 ... self.size.width)
            let randomY = CGFloat.random(in: self.size.height/3 ... 2*self.size.height/3)
            let randomSize = CGFloat.random(in: 1 ... 4)
            
            let backgroundStar = SKSpriteNode(imageNamed: "Star")
            backgroundStar.setScale(0.02 * randomSize)
            backgroundStar.position = CGPoint(x: randomX, y: randomY)
            backgroundStar.zPosition = 2
            self.addChild(backgroundStar)
            //print("\(randomX) + \(randomY)")
        }
        let seq = SKAction.sequence([SKAction.wait(forDuration: 0), SKAction.run{self.generatePlanets(height: height)}])
        self.run(seq)
        orbit()
   }
    
    func generatePlanets(height: CGFloat)
    {
        let blackHole = BlackHoleView(frame: CGRect(x: self.size.width/10, y: 150, width: 100, height: 100))
        view!.addSubview(blackHole)
        let randomSize = CGFloat.random(in: 50 ... 150)
        let circleView = CircleView(frame: CGRect(x: 3 * self.size.width/10, y: self.size.height/10, width: randomSize, height: randomSize))
        let orbitalView = CircleView(frame: CGRect(x: 3 * self.size.width/10 - 40, y: self.size.height/10 - 40, width: randomSize + 80, height: randomSize + 80))
        view!.addSubview(orbitalView)
        view!.addSubview(circleView)

    }
    
    func orbit()
    {
        let circle = UIBezierPath(roundedRect: CGRect(x: (self.size.width/10 + 50), y: (self.size.height/2 - 130), width: 300, height: 300), cornerRadius: 100)
        let followCircle = SKAction.follow(circle.cgPath, asOffset: false, orientToPath: false, duration: 4)
        let orbit = SKAction.repeatForever(followCircle)
        ALS.run(SKAction.sequence([orbit]))
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        //let moveStar = SKAction.moveTo(x: self.size.width + ALS.size.width, duration: 1.2)
        //let rotateStar = SKAction.rotate(byAngle: 8, duration: 1.2)

    }
    
    //
    
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            // Set the Center of the Circle
            // 1
            let circleCenter = touch.location(in: view)

            // Create a new CircleView 3
            let circleView = CircleView(frame: CGRect(x: circleCenter.x, y: circleCenter.y, width: 100, height: 100))
            view!.addSubview(circleView)
        }
     
    }
 */
    
}
