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

class seagull{
    
    var bird: SKSpriteNode
    
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
        
    }
}

