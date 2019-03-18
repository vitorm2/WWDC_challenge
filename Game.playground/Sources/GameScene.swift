import SpriteKit



public class GameScene: SKScene {
    
    struct PhysicsCategory {
        static let none      : UInt32 = 0
        static let all       : UInt32 = UInt32.max
        static let player   : UInt32 = 0b100       // 1
        static let monster: UInt32 = 0b10      // 2
        static let water: UInt32 = 0b11
    }
    
    
    public static var choice: String = ""
    
    
    // 1
    
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
        player.physicsBody?.contactTestBitMask = PhysicsCategory.monster
        player.physicsBody?.collisionBitMask = PhysicsCategory.none
        player.physicsBody?.usesPreciseCollisionDetection = true
        
        // 3
        player.position = CGPoint(x: size.width * 0.5, y: size.height * 0.1)
        
        
        // 4
        addChild(player)
        
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addBottle), SKAction.wait(forDuration: 0.5),
                SKAction.run(addMonster) , SKAction.wait(forDuration: 0.5),
                SKAction.run(addPlayer), SKAction.wait(forDuration: 0.5)
                ])
        ))
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addMonster() {
        
        // Create sprite
        let monster = SKSpriteNode(imageNamed: "monster")
        
        monster.physicsBody = SKPhysicsBody(rectangleOf: monster.size) // 1
        monster.physicsBody?.isDynamic = true // 2
        monster.physicsBody?.categoryBitMask = PhysicsCategory.water // 3
        monster.physicsBody?.contactTestBitMask = PhysicsCategory.player // 4
        monster.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
        
        // Determine where to spawn the monster along the Y axis
        let actualY = random(min: monster.size.height/2, max: size.height - monster.size.height/2)
        
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        monster.position = CGPoint(x: actualY, y: size.height + monster.size.height/2)
        
        // Add the monster to the scene
        addChild(monster)
        
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(1.0), max: CGFloat(3.0))
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: actualY, y: monster.size.height/2),
                                       duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        monster.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    
    func addBottle() {
        
        // Create sprite
        let monster = SKSpriteNode(imageNamed: "water")
        
        monster.physicsBody = SKPhysicsBody(rectangleOf: monster.size) // 1
        monster.physicsBody?.isDynamic = true // 2
        monster.physicsBody?.categoryBitMask = PhysicsCategory.monster // 3
        monster.physicsBody?.contactTestBitMask = PhysicsCategory.player // 4
        monster.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
        
        // Determine where to spawn the monster along the Y axis
        let actualY = random(min: monster.size.height/2, max: size.height - monster.size.height/2)
        
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        monster.position = CGPoint(x: actualY, y: size.height + monster.size.height/2)
        
        // Add the monster to the scene
        addChild(monster)
        
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(1.0), max: CGFloat(3.0))
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: actualY, y: monster.size.height/2),
                                       duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        monster.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    func addPlayer() {
        
        // Create sprite
        let monster = SKSpriteNode(imageNamed: "player")
        
        monster.physicsBody = SKPhysicsBody(rectangleOf: monster.size) // 1
        monster.physicsBody?.isDynamic = true // 2
        monster.physicsBody?.categoryBitMask = PhysicsCategory.monster // 3
        monster.physicsBody?.contactTestBitMask = PhysicsCategory.all // 4
        monster.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
        
        // Determine where to spawn the monster along the Y axis
        let actualY = random(min: monster.size.height/2, max: size.height - monster.size.height/2)
        
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        monster.position = CGPoint(x: actualY, y: size.height + monster.size.height/2)
        
        // Add the monster to the scene
        addChild(monster)
        
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(1.0), max: CGFloat(3.0))
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: actualY, y: monster.size.height/2),
                                       duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        monster.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    // Movimentacao do player
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 1 - Choose one of the touches to work with
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        // ESQUERDA
        if touchLocation.x < frame.midX {
            
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
        else {
            
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
    func projectileDidCollideWithMonster(player: SKSpriteNode, monster: SKSpriteNode) {
        //player.removeFromParent()
        //monster.removeFromParent()
        
        count = count + 1
        
        if count >= 1 {
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
            
//            if contact.bodyA.categoryBitMask == PhysicsCategory.player {
//                print("Player")
//            }
//
//            if contact.bodyA.categoryBitMask == PhysicsCategory.monster {
//                print("Monster")
//            }
//
//            if contact.bodyA.categoryBitMask == PhysicsCategory.water {
//                print("Water")
//            }
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
            //print("Nao sei")
        }
        
        // 2
        if ((firstBody.categoryBitMask & PhysicsCategory.monster != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.player != 0)) {
            if let monster = firstBody.node as? SKSpriteNode,
                let _ = secondBody.node as? SKSpriteNode {
                projectileDidCollideWithMonster(player: player, monster: monster)
            }
        }
    }
}
