//
//  GameScene.swift
//  Fuegull
//
//  Created by Adam Cabral on 8/10/18.
//  Copyright © 2018 Adam Cabral. All rights reserved.
//

import SpriteKit
import GameplayKit

enum BodyType:UInt32{
    
    case boundaries = 1
    case bird = 8
    case sandwich = 4
    case obstables = 2
    
}




class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var dead: Bool = false
    var rotateSpeed = 0.8
    var flySpeed = 7
    var fallSpeed = 9
    var obstacleSpeedNum: Float = 10
    var spawnXLocation = 750
    var destroyXLocation = -900
    var energyBarLength: Float = 300
    
    
    let birdFlyAnimations: [SKTexture] = [SKTexture(image: #imageLiteral(resourceName: "birdFly01")), SKTexture(image: #imageLiteral(resourceName: "birdFly02")), SKTexture(image: #imageLiteral(resourceName: "birdFly03"))]

    var distance = 0
    var score = 0
    
    
    
    
    let Seagull: SKSpriteNode = SKSpriteNode()
    let back: SKSpriteNode = SKSpriteNode()
    var front: SKSpriteNode = SKSpriteNode()
    var distanceBar: SKLabelNode = SKLabelNode()
    
    //Initializing stuff
    override func didMove(to view: SKView) {
        
        //Set World Physics
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -fallSpeed)
        
        self.addChild(back)
        self.addChild(front)
        self.addChild(distanceBar)
        self.addChild(Seagull)
        
        
        //The Bird
        Seagull.size.width = 70
        Seagull.size.height = 70
        Seagull.position = CGPoint(x: -566, y: 1)
        Seagull.physicsBody?.affectedByGravity = true
        Seagull.physicsBody?.pinned = false
        //Seagull.texture = birdFlyAnimations[0]
        Seagull.physicsBody = SKPhysicsBody(texture: SKTexture(image: #imageLiteral(resourceName: "triangle")), size: CGSize(width: 70, height: 70))
        Seagull.physicsBody?.isDynamic = true
        Seagull.physicsBody?.categoryBitMask = BodyType.bird.rawValue
        Seagull.physicsBody?.collisionBitMask = 3
        Seagull.physicsBody?.allowsRotation = false
        Seagull.physicsBody?.contactTestBitMask = BodyType.sandwich.rawValue + BodyType.boundaries.rawValue + BodyType.obstables.rawValue
        
        
        //Back Energy Bar
        back.color = UIColor.white
        back.position = CGPoint(x: 0, y: 343)
        back.size.height = 35
        back.size.width = 300
        back.zPosition = 1000
        
        //Front Energy Bar
        front.color = UIColor.green
        front.position = CGPoint(x: 0, y: 343)
        front.size.height = 35
        front.size.width = CGFloat(energyBarLength)
        front.zPosition = 1001
        
        
        //Distance Score Board
        distanceBar.color = UIColor.black
        distanceBar.position = CGPoint(x: 0, y: 280)
        distanceBar.fontSize = 50
        distanceBar.fontColor = UIColor.white
        distanceBar.zPosition = 10000
        
        
        
        
       
        
        
        
    }
    

/*****************************************************************************************************************
     Game Object Functions
******************************************************************************************************************/
    
    //Custom wait function
    func waitFor(seconds: Float){
        var num: Float = 0
        repeat{
            num += 1
        }while(num < 60*seconds)
        print("Done Waiting")
    }
    
    //Controls energy bar by changing the width of the energy bar sprite
    func updateEnergyBar(amount: Float){
        front.size.width = CGFloat(energyBarLength + amount)
        energyBarLength = Float(front.size.width)
    }
    
    //Controls distance display
    func updateDistanceBar(amount: Int){
        distanceBar.removeFromParent()
        self.addChild(distanceBar)
        distance += amount
        distanceBar.text = String("\(distance) m")
    }
    
    /*
     Spawns a beach chair, umbrella, cooler, and a sanwich in varying positions based on parameter 'selection'
    */
    func spawnBeachSetupOne(selection: Int){
        let sandwichPos: CGPoint
        let sandwichDestroyPos: CGPoint
        //init
        let umbrella = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "umbrella-red")), size: CGSize(width: 150, height: 150))
        let chair = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "beach_chair")), size: CGSize(width: 95 , height: 95))
        let cooler = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "cooler")), size: CGSize(width: 52, height: 52))
        let sandwich = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "sandwich01")),size: CGSize(width: 40, height: 40))
        
        //Check what beachSetUp configuration was specified
        if selection == 3{
            umbrella.texture = SKTexture(image: #imageLiteral(resourceName: "umbrella-green"))
            sandwichPos = CGPoint(x: spawnXLocation, y: -200)
            sandwichDestroyPos = CGPoint(x: destroyXLocation, y: -200)
        }else if selection == 4 {
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
    
    //Spawns a Lifeguard Tower. This will kill the seagull
    func spawnLifeGuardTower(){
        //init
        let tower = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "lifeguardtower")), size: CGSize(width: 120, height: 250))
        self.addChild(tower)
        
        //Position
        tower.position = CGPoint(x: spawnXLocation, y: -213)
        
        //Physics
        tower.physicsBody = SKPhysicsBody(texture: SKTexture(image: #imageLiteral(resourceName: "lifeguardtower")), size: CGSize(width: 120, height: 250))
        tower.physicsBody?.affectedByGravity = false
        tower.physicsBody?.isDynamic = false
        tower.physicsBody?.allowsRotation = false
        
        tower.physicsBody?.categoryBitMask = BodyType.obstables.rawValue
        tower.physicsBody?.collisionBitMask = 0
        tower.physicsBody?.contactTestBitMask = BodyType.bird.rawValue
        
        //Actions
        let towerMove:SKAction = SKAction.move(to: CGPoint(x: destroyXLocation, y: -213), duration: TimeInterval(obstacleSpeedNum))
        let towerDestroy: SKAction = SKAction.removeFromParent()
        let towerSeq: SKAction = SKAction.sequence([towerMove, towerDestroy])
        
        
        tower.run(towerSeq)
        
    }
    
    //TODO: Retry and Quit Screen. Currently stops the app when you die
    func diedScreen() {
        
        //init
        let back = SKSpriteNode(color: UIColor.cyan, size: CGSize(width: 700, height: 300))
        //let diedText = SKLabelNode(text: "You Died!")
        //let retryBox = SKSpriteNode(color: UIColor.black, size: CGSize(width: 160, height: 100))
        //let retryText = SKLabelNode(text: "Retry")
        //let quitBox = SKSpriteNode(color: UIColor.black, size: CGSize(width: 160, height: 100))
        //let quitText = SKLabelNode(text: "Quit")
        //diedText.color = UIColor.black
        //diedText.fontSize = 70
        //retryText.color = UIColor.white
        //retryText.fontSize = 50
        //quitText.color = UIColor.white
        //quitText.fontSize = 50
        
        //retryBox.name = String("retryBox")
        
        
        self.addChild(back)
        //self.addChild(diedText)
        //self.addChild(retryBox)
        //self.addChild(retryText)
        //self.addChild(quitBox)
        //self.addChild(quitText)
        
        //Positions
        back.position = CGPoint(x: 0, y: 20)
        //diedText.position = CGPoint(x: 0, y: 100)
        //retryBox.position = CGPoint(x: -130, y: 20)
        //retryText.position = CGPoint(x: -130, y: 10)
        //quitBox.position = CGPoint(x: 130, y: 10)
        //quitText.position = CGPoint(x: 130, y: 10)
        
        //More Stuff
        back.alpha = 0.8
        
        let fadeIn = SKAction.fadeIn(withDuration: 3)
        
        back.run(fadeIn)
        //diedText.run(fadeIn)
        //retryBox.run(fadeIn)
        //retryText.run(fadeIn)
        //quitBox.run(fadeIn)
        //quitText.run(fadeIn)
        
        //let scene = PlayScene
        waitFor(seconds: 3)
        
        
        dead = false
        rotateSpeed = 0.8
        flySpeed = 7
        fallSpeed = 9
        obstacleSpeedNum = 10
        spawnXLocation = 750
        destroyXLocation = -900
        energyBarLength = 300
        
        
        
        distance = 0
        score = 0
        
        
        
        
    }
    
    func scoreBoard(){
        let score = SKLabelNode(text: "Score \(self.score)")
        self.addChild(score)
        
        score.position = CGPoint(x: -2, y: -353)
        score.fontSize = 96
        score.fontColor = UIColor.black
        
        let scoreDestroy: SKAction = SKAction.removeFromParent()
        score.run(scoreDestroy)
    }
   
/*****************************************************************************************************************
     Movement Functions
******************************************************************************************************************/
    func flyUp() {
        //Seagull.removeAllActions()
        let birdFlyUp: SKAction = SKAction.animate(with: [birdFlyAnimations[0],birdFlyAnimations[1],birdFlyAnimations[2]], timePerFrame: 0.1)
        let birdFlyForever: SKAction = SKAction.repeatForever(birdFlyUp)
        let flyRotation: SKAction = SKAction.rotate(toAngle: 0, duration: rotateSpeed, shortestUnitArc: true)
        let flyingRoutine = SKAction.group([birdFlyForever, flyRotation])
        if energyBarLength > 0 {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: flySpeed)
            
       
        
        Seagull.run(flyingRoutine)
        //print("FlyUp")
        
        
        }
        
    }
    func flyDown() {
        Seagull.removeAllActions()
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -fallSpeed)
        let fallRotation: SKAction = SKAction.rotate(toAngle: 320, duration: rotateSpeed, shortestUnitArc: true)
        //let birdFallForever: SKAction = SKAction.repeatForever(birdFlyDown)
        
        //let flyDownRoutine = SKAction.group([fallRotation, birdFallForever])
        Seagull.texture = birdFlyAnimations[0]
        Seagull.run(fallRotation)
        //print("FlyDown")
    }
    
    func touchesEnded(toPoint pos : CGPoint) {
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
            flyUp()
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        //flyUp()
    }
    
    func touchUp(atPoint pos : CGPoint) {
    
    flyDown()
        
        
    }
    
    
    

    
/*****************************************************************************************************************
                                            Overrides
******************************************************************************************************************/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {self.touchDown(atPoint: t.location(in: self))}
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    var moveIncrement: Float = 0.95
    var spawnOccurence: Float = 120
    var timer = Float(0)
    
    /*****************************************************************************************************************
                                                        Update
     ******************************************************************************************************************/
    
    override func update(_ currentTime: TimeInterval) {
        if dead != true {
        // Called before each frame is rendered
            
        timer += 1
        if Seagull.position.x != -526{
            Seagull.position.x = -526
        }
        if energyBarLength > 300{
            energyBarLength = 300
        }else if energyBarLength < 0 {
            energyBarLength = 0
            dead = true
            //diedScreen()
            self.removeAllActions()
            self.removeAllChildren()
            waitFor(seconds: 3)
            Seagull.removeFromParent()
            //distanceBar.position = CGPoint(x:-1000, y: 280)
            let diedText = SKLabelNode(text: "You Died!")
            self.addChild(diedText)
            diedText.position = CGPoint(x: 0, y: 100)
            //back.removeFromParent()
            //front.removeFromParent()
            waitFor(seconds: 5)
            exit(0)
        }
        updateEnergyBar(amount: -0.1)
        
            
        if timer .truncatingRemainder(dividingBy: 20) == 0 {
            updateDistanceBar(amount: 1)
        }
            if timer .truncatingRemainder(dividingBy: 600) == 0 {
            
            obstacleSpeedNum = obstacleSpeedNum * moveIncrement
            spawnOccurence = round(spawnOccurence * moveIncrement)
            
            
            print("SpawnOccurence: \(spawnOccurence)")
            print("ObstacleSpeed: \(obstacleSpeedNum)")
            print(" ")
            
        }
        var selection = arc4random_uniform(3)
        if timer .truncatingRemainder(dividingBy: spawnOccurence) == 0 {
                print(selection)
                switch (selection) {
                case 4:
                    spawnBeachSetupOne(selection: Int(selection))
                case 3:
                    spawnBeachSetupOne(selection: Int(selection))
                case 2:
                    spawnBeachSetupOne(selection: Int(selection))
                case 1:
                    spawnLifeGuardTower()
                case 0:
                    spawnBeachSetupOne(selection: 4)
                default:
                    spawnBeachSetupOne(selection: Int(selection))
                }
        selection = 0
        }
        
        
        }else{
            Seagull.removeAllActions()
            
            
            
        }
    }//End func Update
    
    
/*****************************************************************************************************************
     Collisions
******************************************************************************************************************/
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var bird: SKSpriteNode?
        var sandwich: SKSpriteNode?
        
        //Bird Hit Sandwich
        if contact.bodyA.categoryBitMask == BodyType.bird.rawValue && contact.bodyB.categoryBitMask == BodyType.sandwich.rawValue {
            sandwich = contact.bodyB.node as? SKSpriteNode
            
            
        } else if contact.bodyB.categoryBitMask == BodyType.bird.rawValue && contact.bodyA.categoryBitMask == BodyType.sandwich.rawValue {
            sandwich = contact.bodyA.node as? SKSpriteNode
            
        }
        
        
        //Bird Hit Obstacle
        if contact.bodyA.categoryBitMask == BodyType.bird.rawValue && contact.bodyB.categoryBitMask == BodyType.obstables.rawValue {
            bird = contact.bodyA.node as? SKSpriteNode
            
            
            
        } else if contact.bodyB.categoryBitMask == BodyType.bird.rawValue && contact.bodyA.categoryBitMask == BodyType.obstables.rawValue {
            bird = contact.bodyB.node as? SKSpriteNode
            
        }
        if sandwich != nil{
            sandwich?.physicsBody = nil
            score += 1
            updateEnergyBar(amount: 20)
            sandwich?.removeFromParent()
            print("Got a sandwich \(score)")
        }
        if bird != nil{
            bird?.physicsBody?.contactTestBitMask = 0
            bird?.physicsBody?.categoryBitMask = 0
            energyBarLength = 0
            bird?.removeAllActions()
            bird?.texture = SKTexture(image: #imageLiteral(resourceName: "birdDead"))
            //bird?.removeFromParent()
            print("Bird Died!")
            dead = true
            
            waitFor(seconds: 3)
            //self.removeAllActions()
            //self.removeAllChildren()
            //self.removeFromParent()
            //distanceBar.position = CGPoint(x: -1000, y: 280)
            //back.removeFromParent()
            //front.removeFromParent()
            let diedText = SKLabelNode(text: "You Died!")
            self.addChild(diedText)
            diedText.position = CGPoint(x: 0, y: 100)
        
            
            waitFor(seconds: 5)
            exit(0)
            
            
            
        }
        
        
    }//End didBegin()
    
    
    
    
    
    
}//End Class

