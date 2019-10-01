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
/*
class seagull: SKSpriteNode{
    
    public var bird: SKSpriteNode //Seagull Sprite Node
    //public var dead: Bool //Denotes whether the bird is dead or not
    var rotateSpeed = 0.8
    var flySpeed = 7
    var fallSpeed = 9
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
        
        guard let gameScene = self.parent as? GameScene else{
        print("Error finding gamescene")
            return
        }
        
         let birdFlyUp: SKAction = SKAction.animate(with: [birdFlyAnimations[0],birdFlyAnimations[1],birdFlyAnimations[2]], timePerFrame: 0.1)
        
         let birdFlyForever: SKAction = SKAction.repeatForever(birdFlyUp)
        
         let flyRotation: SKAction = SKAction.rotate(toAngle: 0, duration: rotateSpeed, shortestUnitArc: true)
        
         let flyingRoutine = SKAction.group([birdFlyForever, flyRotation])
        
        if gameScene.energyBarLength > 0 {
         gameScene.physicsWorld.gravity = CGVector(dx: 0, dy: flySpeed)
             
        
         
         bird.run(flyingRoutine)
         //print("FlyUp")
        }
    }
    
    
    func flyDown() {
        guard let gameScene = self.parent as? GameScene else{
        print("Error finding gamescene")
            return
        }
        bird.removeAllActions()
        gameScene.physicsWorld.gravity = CGVector(dx: 0, dy: -fallSpeed)
        let fallRotation: SKAction = SKAction.rotate(toAngle: 320, duration: rotateSpeed, shortestUnitArc: true)
        //let birdFallForever: SKAction = SKAction.repeatForever(birdFlyDown)
        
        //let flyDownRoutine = SKAction.group([fallRotation, birdFallForever])
        bird.texture = birdFlyAnimations[0]
        bird.run(fallRotation)
        //print("FlyDown")
    }
        
}

*/
