import Foundation
import SpriteKit

public class CharacterSelection: SKScene {
    
    override public func didMove(to view: SKView) {
        
        // 1
        
        let ground = SKSpriteNode(imageNamed: "background")
        ground.name = "Ground"
        ground.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
        ground.position = CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(ground)
        
        // 3
        let title = SKLabelNode(fontNamed: "San Francisco")
        title.text =  "NOME DO JOGO"
        title.fontSize = 30
        title.fontColor = SKColor.black
        title.position = CGPoint(x: frame.midX, y: frame.maxY - 150)
        addChild(title)
        
        
        let label = SKLabelNode(fontNamed: "San Francisco")
        label.text =  "Choose your Character:"
        label.fontSize = 15
        label.fontColor = SKColor.black
        label.position = CGPoint(x: label.frame.size.width / 2 + 50, y: frame.maxY/2 - 50)
        addChild(label)
        
        let tortoise = SKSpriteNode(imageNamed: "tortoiseSelect")
        tortoise.position = CGPoint(x: tortoise.frame.size.width / 2 + 50 , y: frame.maxY/2 - 200)
        addChild(tortoise)
        
        let penguin = SKSpriteNode(imageNamed: "penguinSelect")
        penguin.position = CGPoint(x: tortoise.frame.size.width + penguin.frame.size.width + 40, y: frame.maxY/2 - 200)
        addChild(penguin)
        
        let dolphin = SKSpriteNode(imageNamed: "dolphinSelect")
        dolphin.position = CGPoint(x: tortoise.frame.size.width + penguin.frame.size.width + dolphin.frame.size.width + 100, y: frame.maxY/2 - 200)
        addChild(dolphin)
        
        
        // X = 16 -  81 / 118 - 178 / 196 - 346/ 363 - 487
        
        
        // 4
        //        run(SKAction.sequence([
        //            SKAction.wait(forDuration: 3.0),
        //            SKAction.run() { [weak self] in
        //                // 5
        //                guard let `self` = self else { return }
        //                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        //                let scene = GameScene(fileNamed: "GameScene")
        //                self.view?.presentScene(scene!, transition:reveal)
        //            }
        //            ]))
        
        
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 1 - Choose one of the touches to work with
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        print(touchLocation)
        
        
        if touchLocation.y >= 214 && touchLocation.y <= 431 {
    
            if touchLocation.x >= 38 && touchLocation.x <= 261 {
                
                
                if let gameScene = GameScene(fileNamed: "GameScene") {
                    
                    GameScene.choice = "Tortoise"
                    
                    // Set the scale mode to scale to fit the window
                    gameScene.scaleMode = .aspectFill
                    
                    // Present the scene
                    self.scene?.view?.presentScene(gameScene)
                }
                
                
            } else if  touchLocation.x >= 280 && touchLocation.x <= 472 {
            
                if let gameScene = GameScene(fileNamed: "GameScene") {
                    
                    GameScene.choice = "Penguin"
                    
                    // Set the scale mode to scale to fit the window
                    gameScene.scaleMode = .aspectFill
                    
                    // Present the scene
                    self.scene?.view?.presentScene(gameScene)
                    
                }
            } else if  touchLocation.x >= 500 && touchLocation.x <= 660 {
               
                if let gameScene = GameScene(fileNamed: "GameScene") {
                    
                    GameScene.choice = "Dolphin"
                    
                    // Set the scale mode to scale to fit the window
                    gameScene.scaleMode = .aspectFill
                    
                    // Present the scene
                    self.scene?.view?.presentScene(gameScene)
                }
                
            } 
            
        }
        
    
    }
    
}
