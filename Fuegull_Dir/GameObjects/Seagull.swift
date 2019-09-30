//
//  Seagull.swift
//  Fuegull
//
//  Created by Adam Cabral on 8/12/18.
//  Copyright © 2018 Adam Cabral. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class seagull: SKSpriteNode{
    
    public var bird: SKSpriteNode //Seagull Sprite Node
    public var dead: bool //Denotes whether the bird is dead or not
    
    //3 images used to animate bird flying
    private let birdFlyAnimations: [SKTexture] = [SKTexture(image: #imageLiteral(resourceName: "birdFly01")), SKTexture(image: #imageLiteral(resourceName: "birdFly02")), SKTexture(image: #imageLiteral(resourceName: "birdFly03"))]
    
    init(){
        bird = SKSpriteNode()
        bird.size.width = 70
        bird.size.height = 70
        bird.position = CGPoint(x: -566, y: 1)
        bird.physicsBody?.affectedByGravity = true
        bird.physicsBody?.pinned = false
        bird.physicsBody = SKPhysicsBody(texture: SKTexture(image: #imageLiteral(resourceName: "triangle")), size: CGSize(width: 70, height: 70))
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.categoryBitMask = 8 //From Enum in GameScene.sks
        bird.physicsBody?.collisionBitMask = 3
        
        dead = false
        
    }
    
    public func flyUp(){
        
         let birdFlyUp: SKAction = SKAction.animate(with: [birdFlyAnimations[0],birdFlyAnimations[1],birdFlyAnimations[2]], timePerFrame: 0.1)
        
         let birdFlyForever: SKAction = SKAction.repeatForever(birdFlyUp)
        
         let flyRotation: SKAction = SKAction.rotate(toAngle: 0, duration: rotateSpeed, shortestUnitArc: true)
        
         let flyingRoutine = SKAction.group([birdFlyForever, flyRotation])
        
         if energyBarLength > 0 {
         self.physicsWorld.gravity = CGVector(dx: 0, dy: flySpeed)
             
        
         
         bird.run(flyingRoutine)
         //print("FlyUp")
    }
    
    public func flyDown() {
        Seagull.removeAllActions()
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -fallSpeed)
        let fallRotation: SKAction = SKAction.rotate(toAngle: 320, duration: rotateSpeed, shortestUnitArc: true)
        //let birdFallForever: SKAction = SKAction.repeatForever(birdFlyDown)
        
        //let flyDownRoutine = SKAction.group([fallRotation, birdFallForever])
        Seagull.texture = birdFlyAnimations[0]
        Seagull.run(fallRotation)
        //print("FlyDown")
    }
        
}

