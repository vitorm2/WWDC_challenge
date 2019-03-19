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
    
    
    // 1
    
    var isFinish = false
    var amountMonstersAppers = 0
    var count = 0
    
    let winner = SKLabelNode(fontNamed: "San Francisco")
    
    var player = SKSpriteNode()
    
    
    override public func didMove(to view: SKView) {
        
        
        switch GameScene.choice {
        case "Tortoise":
             player = SKSpriteNode(imageNamed: "tortoise")
        case "Penguin":
            player = SKSpriteNode(imageNamed: "monster")
        case "Dolphin":
            player = SKSpriteNode(imageNamed: "water")
        case "Seal":
            player = SKSpriteNode(imageNamed: "player")
        default:
            player = SKSpriteNode(imageNamed: "tortoise")
        }
        
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
//        print(GameScene.choice)
        
        // 2
        backgroundColor = SKColor.white
        
        
        winner.text = String(count)
        winner.fontSize =  30
        winner.fontColor = SKColor.red
        winner.position = CGPoint(x: frame.maxX - 50, y: frame.maxY - 50)
        
        addChild(winner)
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width/2)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.plasticBag
        player.physicsBody?.collisionBitMask = PhysicsCategory.none
        player.physicsBody?.usesPreciseCollisionDetection = true
        
        // 3
        player.position = CGPoint(x: size.width * 0.5, y: player.frame.size.height + 20)
        
        
        // 4
        addChild(player)
        
        run(SKAction.repeat(
            SKAction.sequence([
                SKAction.run(addPlasticBag), SKAction.wait(forDuration: 0.5),
                SKAction.run(addPlasticBottle) , SKAction.wait(forDuration: 0.5),
                SKAction.run(addPlasticStraw), SKAction.wait(forDuration: 0.5)
                ]), count: 10)
        )
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addPlasticBag() {
        
        // Create sprite
        let plasticBag = SKSpriteNode(imageNamed: "monster")
        
        plasticBag.physicsBody = SKPhysicsBody(rectangleOf: plasticBag.size) // 1
        plasticBag.physicsBody?.isDynamic = true // 2
        plasticBag.physicsBody?.categoryBitMask = PhysicsCategory.plasticBag // 3
        plasticBag.physicsBody?.contactTestBitMask = PhysicsCategory.player // 4
        plasticBag.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
        
        // Determine where to spawn the monster along the Y axis
        let actualX = random(min: plasticBag.size.height/2, max: size.height - plasticBag.size.height - 20)
        
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
        let bottle = SKSpriteNode(imageNamed: "water")
        
        bottle.physicsBody = SKPhysicsBody(rectangleOf: bottle.size) // 1
        bottle.physicsBody?.isDynamic = true // 2
        bottle.physicsBody?.categoryBitMask = PhysicsCategory.plasticBottle // 3
        bottle.physicsBody?.contactTestBitMask = PhysicsCategory.player // 4
        bottle.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
        
        // Determine where to spawn the monster along the Y axis
        let actualX = random(min: bottle.size.width/2, max: size.width - bottle.size.width - 20)
        
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
        let plasticStraw = SKSpriteNode(imageNamed: "player")
        
        plasticStraw.physicsBody = SKPhysicsBody(rectangleOf: plasticStraw.size) // 1
        plasticStraw.physicsBody?.isDynamic = true // 2
        plasticStraw.physicsBody?.categoryBitMask = PhysicsCategory.plasticStraw // 3
        plasticStraw.physicsBody?.contactTestBitMask = PhysicsCategory.player // 4
        plasticStraw.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
        
        // Determine where to spawn the monster along the Y axis
        let actualX = random(min: plasticStraw.size.height/2, max: size.height - plasticStraw.size.height - 20)
        
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
            
            
            let actualDuration = random(min: CGFloat(2.0), max: CGFloat(2.0))
            let actionMove = SKAction.move(to: CGPoint(x: frame.midX, y: frame.midY),
                                           duration: TimeInterval(actualDuration))
            player.run(SKAction.sequence([SKAction.wait(forDuration: 5.0), actionMove]))
        }
    }
    
    
    func addAnimalFamily() {
        
        // Create sprite
        let family = SKSpriteNode(imageNamed: "tortoise")
        
        family.physicsBody = SKPhysicsBody(rectangleOf: family.size) // 1
        family.physicsBody?.isDynamic = true // 2
        family.physicsBody?.categoryBitMask = PhysicsCategory.family // 3
        family.physicsBody?.contactTestBitMask = PhysicsCategory.player // 4
        family.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
        
        
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        family.position = CGPoint(x: frame.midX, y: size.height + family.size.height/2)
        
        // Add the monster to the scene
        addChild(family)
        
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(2.0))
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: frame.midX, y: frame.midY + family.size.height),
                                       duration: TimeInterval(actualDuration))
        family.run(SKAction.sequence([SKAction.wait(forDuration: 5.0), actionMove]))
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
        
        
        // ESQUERDA
        if touchLocation.x < frame.midX && player.position.y == player.frame.size.height + 20 {
            
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
        else if touchLocation.x > frame.midX && player.position.y == player.frame.size.height + 20 {
            
            var moveTo = player.position.x + 100
            if moveTo > 700 || moveTo > 750 {
                moveTo = 700
            }
            
            
            let actualDuration = random(min: CGFloat(0.3), max: CGFloat(0.3))
            let actionMove = SKAction.move(to: CGPoint(x: moveTo, y: player.position.y),
                                           duration: TimeInterval(actualDuration))
            player.run(SKAction.sequence([actionMove]))
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
                gameOverScene.scaleMode = .aspectFill
                // Present the scene
                self.scene?.view?.presentScene(gameOverScene)
            }
        }
        winner.text = String(count)
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
            }

            if contact.bodyA.categoryBitMask == PhysicsCategory.plasticBottle {
                print("Plastic Bottle")
            }

            if contact.bodyA.categoryBitMask == PhysicsCategory.plasticStraw {
                print("Plastic Straw")
            }
            
            if contact.bodyA.categoryBitMask == PhysicsCategory.family {
                print("Family")
                
                if let gameFinish = GameFinish(fileNamed: "GameFinish") {
                    // Set the scale mode to scale to fit the window
                    gameFinish.scaleMode = .aspectFill
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
