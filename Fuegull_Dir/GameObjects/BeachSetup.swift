//
//  BeachSetup.swift
//  Fuegull
//
//  Created by Adam Cabral on 9/29/19.
//  Copyright © 2019 Adam Cabral. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class beachSetup{
    var setupNum: UInt32
    var spawnXLocation = 750
    var destroyXLocation = -900
    var obstacleSpeedNum: Float = 10
    
    init(){
        setupNum = arc4random_uniform(3)
    }
    
    
    /*
     Spawns a beach chair, umbrella, cooler, and a sanwich in varying positions based on parameter 'selection'
    */
    func spawnBeachSetup(){
        let sandwichPos: CGPoint
        let sandwichDestroyPos: CGPoint
        //init
        let umbrella = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "umbrella-red")), size: CGSize(width: 150, height: 150))
        let chair = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "beach_chair")), size: CGSize(width: 95 , height: 95))
        let cooler = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "cooler")), size: CGSize(width: 52, height: 52))
        let sandwich = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "sandwich01")),size: CGSize(width: 40, height: 40))
        
        //Check what beachSetUp configuration was specified
        if setupNum == 3{
            umbrella.texture = SKTexture(image: #imageLiteral(resourceName: "umbrella-green"))
            sandwichPos = CGPoint(x: spawnXLocation, y: -200)
            sandwichDestroyPos = CGPoint(x: destroyXLocation, y: -200)
        }else if setupNum == 4 {
            umbrella.texture = SKTexture(image: #imageLiteral(resourceName: "umbrella-red"))
            sandwichPos = CGPoint(x: spawnXLocation + 97, y: -300)
            sandwichDestroyPos = CGPoint(x: destroyXLocation + 97, y: -300)
        }else{
            umbrella.texture = SKTexture(image: #imageLiteral(resourceName: "umbrella-pink"))
            sandwichPos = CGPoint(x: spawnXLocation + 188, y: -275)
            sandwichDestroyPos = CGPoint(x: destroyXLocation + 188, y: -275)
        }
        
        self.addChild(umbrella)
        self.addChild(chair)
        self.addChild(cooler)
        self.addChild(sandwich)
        
        //Position
        umbrella.position = CGPoint(x: spawnXLocation, y: -252)
        chair.position = CGPoint(x: spawnXLocation + 97, y: -300)
        cooler.position = CGPoint(x: spawnXLocation + 188, y: -313)
        sandwich.position = sandwichPos
        
        
        //Physics
        umbrella.physicsBody = SKPhysicsBody(texture: SKTexture(image: #imageLiteral(resourceName: "umbrella-red-collision")), size: CGSize(width: 150 , height: 150))
        chair.physicsBody = SKPhysicsBody(texture: SKTexture(image: #imageLiteral(resourceName: "beach_chair")), size: CGSize(width: 95 , height: 95))
        cooler.physicsBody = SKPhysicsBody(texture: SKTexture(image: #imageLiteral(resourceName: "cooler")), size: CGSize(width: 52 , height: 52))
        umbrella.physicsBody?.affectedByGravity = false
        chair.physicsBody?.affectedByGravity = false
        cooler.physicsBody?.affectedByGravity = false
        umbrella.physicsBody?.isDynamic = false
        chair.physicsBody?.isDynamic = false
        cooler.physicsBody?.isDynamic = false
        umbrella.physicsBody?.allowsRotation = false
        chair.physicsBody?.allowsRotation = false
        cooler.physicsBody?.allowsRotation = false
        
        umbrella.physicsBody?.restitution = 1.2
        
        umbrella.physicsBody?.categoryBitMask = BodyType.boundaries.rawValue
        chair.physicsBody?.categoryBitMask = 0
        cooler.physicsBody?.categoryBitMask = 0
        umbrella.physicsBody?.collisionBitMask = BodyType.bird.rawValue
        chair.physicsBody?.collisionBitMask = 0
        cooler.physicsBody?.collisionBitMask = 0
        umbrella.physicsBody?.contactTestBitMask = BodyType.bird.rawValue
        chair.physicsBody?.contactTestBitMask = 0
        cooler.physicsBody?.contactTestBitMask = BodyType.bird.rawValue
        
        sandwich.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        sandwich.physicsBody?.affectedByGravity = false
        sandwich.physicsBody?.isDynamic = false
        sandwich.physicsBody?.allowsRotation = false
        
        sandwich.physicsBody?.categoryBitMask = BodyType.sandwich.rawValue
        sandwich.physicsBody?.collisionBitMask = 0
        sandwich.physicsBody?.contactTestBitMask = BodyType.bird.rawValue
        
        //Actions
        let umbrellaMove:SKAction = SKAction.move(to: CGPoint(x: destroyXLocation, y: -252), duration: TimeInterval(obstacleSpeedNum))
        let chairMove:SKAction = SKAction.move(to: CGPoint(x: destroyXLocation + 97, y: -300), duration: TimeInterval(obstacleSpeedNum))
        let coolerMove:SKAction = SKAction.move(to: CGPoint(x: destroyXLocation + 188, y: -313), duration: TimeInterval(obstacleSpeedNum))
        let Destroy: SKAction = SKAction.removeFromParent()
        let umbrellaMoveSeq: SKAction = SKAction.sequence([umbrellaMove, Destroy])
        let chairMoveSeq: SKAction = SKAction.sequence([chairMove, Destroy])
        let coolerMoveSeq: SKAction = SKAction.sequence([coolerMove, Destroy])
        let sandwichMove:SKAction = SKAction.move(to: sandwichDestroyPos, duration: TimeInterval(obstacleSpeedNum))
        let sandwichDestroy: SKAction = SKAction.removeFromParent()
        let sandwichSeq: SKAction = SKAction.sequence([sandwichMove, sandwichDestroy])
        
        //Run animations
        umbrella.run(umbrellaMoveSeq)
        chair.run(chairMoveSeq)
        cooler.run(coolerMoveSeq)
        sandwich.run(sandwichSeq)
        
        
    }
}


