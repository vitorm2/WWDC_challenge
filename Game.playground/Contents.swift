//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    struct PhysicsCategory {
        static let none      : UInt32 = 0
        static let all       : UInt32 = UInt32.max
        static let player   : UInt32 = 0b10       // 1
        static let monster: UInt32 = 0b1      // 2
    }
    
    
    
    // 1
    let player = SKSpriteNode(imageNamed: "player")
    
    
    override func didMove(to view: SKView) {
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        // 2
        backgroundColor = SKColor.white
        
        
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
                SKAction.run(addMonster),
                SKAction.wait(forDuration: 1.0)
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
    
    
    // Movimentacao do player
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 1 - Choose one of the touches to work with
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        // ESQUERDA
        if touchLocation.x < 250 {
            
            var moveTo = player.position.x - 50
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
            
            var moveTo = player.position.x + 50
            if moveTo > 500 || moveTo > 450 {
                moveTo = 450
            }
            
            
            let actualDuration = random(min: CGFloat(0.3), max: CGFloat(0.3))
            let actionMove = SKAction.move(to: CGPoint(x: moveTo, y: player.position.y),
                                           duration: TimeInterval(actualDuration))
            player.run(SKAction.sequence([actionMove]))
        }
    }
    
    // ACAO QUANDO ENCOSTA O PLAYER
    func projectileDidCollideWithMonster(player: SKSpriteNode, monster: SKSpriteNode) {
        player.removeFromParent()
        monster.removeFromParent()
    }
    

    
}

// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 500, height: 500))
if let scene = GameScene(fileNamed: "GameScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    
    // Present the scene
    sceneView.presentScene(scene)
}

// IDENTIFICA O CONTATO
extension GameScene {
    func didBegin(_ contact: SKPhysicsContact) {
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
            print("Pegou")
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
            print("Nao sei")
        }
        
        // 2
        if ((firstBody.categoryBitMask & PhysicsCategory.monster != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.player != 0)) {
            if let monster = firstBody.node as? SKSpriteNode,
                let projectile = secondBody.node as? SKSpriteNode {
                projectileDidCollideWithMonster(player: player, monster: monster)
            }
        }
    }
}


PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
