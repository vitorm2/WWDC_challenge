import SpriteKit



public class GameScene: SKScene {
    
    struct PhysicsCategory {
        static let none      : UInt32 = 0
        static let all       : UInt32 = UInt32.max
        static let player   : UInt32 = 0b100       // 1
        static let plasticBag: UInt32 = 0b10      // 2
        static let plasticBottle: UInt32 = 0b11
        static let plasticStraw: UInt32 = 0b01
        static let family: UInt32 = 0b00
    }
    
    
    public static var choice: String = ""
    private var walkFrames: [SKTexture] = []
    
    var ground = SKSpriteNode()

    // 1
    
    var isFinish = false
    var amountMonstersAppers = 0
    var count = 0
    
    let winner = SKLabelNode(fontNamed: "San Francisco")
    
    var player = SKSpriteNode()
    var family = SKSpriteNode()
    var enemyInfo = SKSpriteNode()
    
    
    var lastPosition: CGFloat = 0.0
    
    
    override public func didMove(to view: SKView) {
        
        run(SKAction.playSoundFileNamed("selectCharacter.wav", waitForCompletion: false))
        
        createGrounds()
        
        switch GameScene.choice {
        case "Tortoise":
            
            walkFrames = [
                SKTexture(imageNamed: "tortoise1.png"),
                SKTexture(imageNamed: "tortoise2.png"),
                SKTexture(imageNamed: "tortoise3.png"),
            ]
            let firstFrameTexture = walkFrames[0]
            player = SKSpriteNode(texture: firstFrameTexture)
            
            
            
        case "Penguin":
            
            walkFrames = [
                SKTexture(imageNamed: "penguin1.png"),
                SKTexture(imageNamed: "penguin2.png"),
                SKTexture(imageNamed: "penguin3.png"),
            ]
            let firstFrameTexture = walkFrames[0]
            player = SKSpriteNode(texture: firstFrameTexture)
            
            
        case "Dolphin":
            
            walkFrames = [
                SKTexture(imageNamed: "dolphin1.png"),
                SKTexture(imageNamed: "dolphin2.png"),
            ]
            let firstFrameTexture = walkFrames[0]
            player = SKSpriteNode(texture: firstFrameTexture)
            
        default:
            print("Error")
        }
        
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        
        player.position = CGPoint(x: size.width * 0.5, y: player.frame.size.height + 20)
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width/2)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.plasticBag
        player.physicsBody?.collisionBitMask = PhysicsCategory.none
        player.physicsBody?.usesPreciseCollisionDetection = true
        
        
        // 4
        addChild(player)
        
        
        winner.text = String(count)
        winner.fontSize =  30
        winner.fontColor = SKColor.red
        winner.position = CGPoint(x: frame.maxX - 50, y: frame.maxY - 50)
        
        addChild(winner)
        
        animatePlayer()
        
        run(SKAction.repeat(
            SKAction.sequence([
                SKAction.run(addPlasticBag), SKAction.wait(forDuration: 0.5),
                SKAction.run(addPlasticBottle) , SKAction.wait(forDuration: 0.5),
                SKAction.run(addPlasticStraw), SKAction.wait(forDuration: 0.5)
                ]), count: 10)
        )
    }
    
    
    func animatePlayer() {
        player.run(SKAction.repeatForever(
            SKAction.animate(with: walkFrames,
                             timePerFrame: 0.2,
                             resize: false,
                             restore: true)))
    }
    
    public override func update(_ currentTime: TimeInterval) {
        moveGrounds()
    }
    
    
    
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addPlasticBag() {
        
        // Create sprite
        let plasticBag = SKSpriteNode(imageNamed: "plasticBag")
        
        plasticBag.physicsBody = SKPhysicsBody(rectangleOf: plasticBag.size) // 1
        plasticBag.physicsBody?.isDynamic = true // 2
        plasticBag.physicsBody?.categoryBitMask = PhysicsCategory.plasticBag // 3
        plasticBag.physicsBody?.contactTestBitMask = PhysicsCategory.player // 4
        plasticBag.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
        
        // Determine where to spawn the monster along the X axis
        let actualX = random(min: plasticBag.size.height/2, max: frame.maxY - plasticBag.size.height - 20)
        
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        plasticBag.position = CGPoint(x: actualX, y: size.height + plasticBag.size.height/2)
        
        // Add the monster to the scene
        addChild(plasticBag)
        
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(3.0), max: CGFloat(5.0))
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: plasticBag.size.height),
                                       duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        plasticBag.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    
    func addPlasticBottle() {
        
        // Create sprite
        let bottle = SKSpriteNode(imageNamed: "plasticBottle")
        
        bottle.physicsBody = SKPhysicsBody(rectangleOf: bottle.size) // 1
        bottle.physicsBody?.isDynamic = true // 2
        bottle.physicsBody?.categoryBitMask = PhysicsCategory.plasticBottle // 3
        bottle.physicsBody?.contactTestBitMask = PhysicsCategory.player // 4
        bottle.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
        
        // Determine where to spawn the monster along the Y axis
        let actualX = random(min: bottle.size.width/2, max: frame.maxY - bottle.size.width - 20)
        
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        bottle.position = CGPoint(x: actualX, y: size.height + bottle.size.height/2)
        
        // Add the monster to the scene
        addChild(bottle)
        
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(3.0), max: CGFloat(5.0))
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: bottle.size.height),
                                       duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        bottle.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    func addPlasticStraw() {
        
        amountMonstersAppers = amountMonstersAppers + 1
        
        // Create sprite
        let plasticStraw = SKSpriteNode(imageNamed: "plasticStraw")
        
        plasticStraw.physicsBody = SKPhysicsBody(rectangleOf: plasticStraw.size) // 1
        plasticStraw.physicsBody?.isDynamic = true // 2
        plasticStraw.physicsBody?.categoryBitMask = PhysicsCategory.plasticStraw // 3
        plasticStraw.physicsBody?.contactTestBitMask = PhysicsCategory.player // 4
        plasticStraw.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
        
        // Determine where to spawn the monster along the Y axis
        let actualX = random(min: plasticStraw.size.height/2, max: frame.maxY - plasticStraw.size.height - 20)
        
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        plasticStraw.position = CGPoint(x: actualX, y: size.height + plasticStraw.size.height/2)
        
        // Add the monster to the scene
        addChild(plasticStraw)
        
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(3.0), max: CGFloat(5.0))
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: plasticStraw.size.height),
                                       duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        plasticStraw.run(SKAction.sequence([actionMove, actionMoveDone]))
        
        
        if amountMonstersAppers == 10 {
            
            addAnimalFamily()
            
            
            let actualDuration = random(min: CGFloat(3.0), max: CGFloat(3.0))
            let actionMove = SKAction.move(to: CGPoint(x: frame.midX, y: frame.midY - family.size.height/2),
                                           duration: TimeInterval(actualDuration))
            player.run(SKAction.sequence([SKAction.wait(forDuration: 4.0), actionMove]))
            
            
        }
    }
    
    
    func addAnimalFamily() {
        
        // Create sprite
        
        switch GameScene.choice {
        case "Tortoise":
            family = SKSpriteNode(imageNamed: "tortoiseFamily")
        case "Penguin":
            family = SKSpriteNode(imageNamed: "penguinFamily")
        case "Dolphin":
            family = SKSpriteNode(imageNamed: "dolphinFamily")
        default:
            print("default")
        }
        
        
        family.physicsBody = SKPhysicsBody(rectangleOf: family.size) // 1
        family.physicsBody?.isDynamic = true // 2
        family.physicsBody?.categoryBitMask = PhysicsCategory.family // 3
        family.physicsBody?.contactTestBitMask = PhysicsCategory.player // 4
        family.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
        
        
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        family.position = CGPoint(x: frame.midX, y: size.height + family.size.height/2 + 20)
        
        // Add the monster to the scene
        addChild(family)
        
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(3.0), max: CGFloat(3.0))
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: frame.midX, y: frame.midY),
                                       duration: TimeInterval(actualDuration))
        family.run(SKAction.sequence([SKAction.wait(forDuration: 4.0), actionMove]))
    }
    
    // Movimentacao do player
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 1 - Choose one of the touches to work with
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        // ARREDONDA A POSICAO PARA COMPARACAO
        player.position.y.round()
        
        print(touchLocation)
        
        // ESQUERDA
        if touchLocation.x < frame.midX && player.position.y == player.frame.size.height + 20 && !isPaused {
            
            var moveTo = player.position.x - 100
            if moveTo < 0 || moveTo < 50 {
                moveTo = 50
            }
            let actualDuration = random(min: CGFloat(0.3), max: CGFloat(0.3))
            let actionMove = SKAction.move(to: CGPoint(x: moveTo, y: player.position.y),
                                           duration: TimeInterval(actualDuration))
            player.run(SKAction.sequence([actionMove]))
        }
            // DIREITA
        else if touchLocation.x > frame.midX && player.position.y == player.frame.size.height + 20 && !isPaused {
            
            var moveTo = player.position.x + 100
            if moveTo > 700 || moveTo > 750 {
                moveTo = 700
            }
            
            
            let actualDuration = random(min: CGFloat(0.3), max: CGFloat(0.3))
            let actionMove = SKAction.move(to: CGPoint(x: moveTo, y: player.position.y),
                                           duration: TimeInterval(actualDuration))
            player.run(SKAction.sequence([actionMove]))
        }
        
        
        if isPaused && touchLocation.x > 256 && touchLocation.x < 490 && touchLocation.y > 376 && touchLocation.y < 442 {
            self.scene?.view?.isPaused = false
            if !enemyInfo.isHidden {
                enemyInfo.removeFromParent()
            }
        }
        
    }
    
    // ACAO QUANDO ENCOSTA O PLAYER
    func playerCollideWithSomething(player: SKSpriteNode, objectContact: SKSpriteNode) {
        //player.removeFromParent()
        //monster.removeFromParent()
        
        count = count + 1
        
        if count >= 5 {
            //let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            
            if let gameOverScene = GameOverScene(fileNamed: "GameOverScene") {
                // Set the scale mode to scale to fit the window
                gameOverScene.scaleMode = .aspectFit
                // Present the scene
                self.scene?.view?.presentScene(gameOverScene)
            }
        }
        winner.text = String(count)
    }
    
    
    
    
    func createGrounds() {
        
        
        for i in 0...3 {
            let ground = SKSpriteNode(imageNamed: "background")
            ground.name = "Ground"
            ground.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
            ground.position = CGPoint(x: frame.midX, y: CGFloat(i) * ground.size.height)
            addChild(ground)
        }
        
    }
    
    func moveGrounds() {
        
        self.enumerateChildNodes(withName: "Ground", using: ({
            (node, error) in
            
            node.position.y -= 15
            
            if node.position.y < -((self.scene?.size.height)!) {
                node.position.y += (self.scene?.size.height)! * 3
            }
        }))
    }
    
    
}



// IDENTIFICA O CONTATO
extension GameScene: SKPhysicsContactDelegate {
    public func didBegin(_ contact: SKPhysicsContact) {
        
        
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
            
        
            
            
            
            if contact.bodyA.categoryBitMask == PhysicsCategory.plasticBag {
                print("Plastic Bag")
                
                run(SKAction.playSoundFileNamed("contact.wav", waitForCompletion: true)) {
                    self.enemyInfo = SKSpriteNode(imageNamed: "infoPlasticBag")
                    self.enemyInfo.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
                    self.addChild(self.enemyInfo)
                    
                    
                    if !self.enemyInfo.isHidden {
                        self.scene?.view?.isPaused = true
                    }
                }
                
                
                
            }

            if contact.bodyA.categoryBitMask == PhysicsCategory.plasticBottle {
                print("Plastic Bottle")
                
                run(SKAction.playSoundFileNamed("contact.wav", waitForCompletion: true)) {
                    self.enemyInfo = SKSpriteNode(imageNamed: "infoPlasticBottle")
                    self.enemyInfo.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
                    self.addChild(self.enemyInfo)
                    
                    
                    if !self.enemyInfo.isHidden {
                        self.scene?.view?.isPaused = true
                    }
                }
            }

            if contact.bodyA.categoryBitMask == PhysicsCategory.plasticStraw {
                print("Plastic Straw")
                
                run(SKAction.playSoundFileNamed("contact.wav", waitForCompletion: true)) {
                    self.enemyInfo = SKSpriteNode(imageNamed: "infoPlasticBottle")
                    self.enemyInfo.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
                    self.addChild(self.enemyInfo)
                    
                    
                    if !self.enemyInfo.isHidden {
                        self.scene?.view?.isPaused = true
                    }
                }
            }
            
            if contact.bodyA.categoryBitMask == PhysicsCategory.family {
                print("Family")
                
                if let gameFinish = GameFinish(fileNamed: "GameFinish") {
                    // Set the scale mode to scale to fit the window
                    gameFinish.scaleMode = .aspectFit
                    // Present the scene
                    self.scene?.view?.presentScene(gameFinish)
                }
                
            }

            
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
            //print("Nao sei")
        }
        
        // 2
        if ((firstBody.categoryBitMask & PhysicsCategory.all != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.player != 0)) {
            if let objectContact = firstBody.node as? SKSpriteNode,
                let player = secondBody.node as? SKSpriteNode {
                playerCollideWithSomething(player: player, objectContact: objectContact)
            }
        }
    }
}
