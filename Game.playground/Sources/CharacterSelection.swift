import Foundation
import SpriteKit

public class CharacterSelection: SKScene {
    
    override public func didMove(to view: SKView) {
        
        // 1
        backgroundColor = SKColor.white
        
        // 3
        let title = SKLabelNode(fontNamed: "San Francisco")
        title.text =  "NOME DO JOGO"
        title.fontSize = 25
        title.fontColor = SKColor.black
        title.position = CGPoint(x: frame.maxX / 2, y: frame.maxY - 150)
        addChild(title)
        
        
        let label = SKLabelNode(fontNamed: "San Francisco")
        label.text =  "Choose your Character:"
        label.fontSize = 15
        label.fontColor = SKColor.black
        label.position = CGPoint(x: 100, y: frame.maxY - 280)
        addChild(label)
        
        let tortoise = SKSpriteNode(imageNamed: "tortoiseSelect")
        tortoise.position = CGPoint(x: 50, y: frame.maxY - 380)
        addChild(tortoise)
        
        let penguin = SKSpriteNode(imageNamed: "penguinSelect")
        penguin.position = CGPoint(x: 150, y: frame.maxY - 380)
        addChild(penguin)
        
        let dolphin = SKSpriteNode(imageNamed: "dolphinSelect")
        dolphin.position = CGPoint(x: 270, y: frame.maxY - 380)
        addChild(dolphin)
        
        let seal = SKSpriteNode(imageNamed: "sealSelect")
        seal.position = CGPoint(x: 420, y: frame.maxY - 380)
        addChild(seal)
        
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
        
        
        if touchLocation.y >= 62 && touchLocation.y <= 180 {
    
            if touchLocation.x >= 16 && touchLocation.x <= 81 {
            
                
                if let gameScene = GameScene(fileNamed: "GameScene") {
                    
                    GameScene.choice = "Tortoise"
                    
                    // Set the scale mode to scale to fit the window
                    gameScene.scaleMode = .aspectFill
                    
                    // Present the scene
                    self.scene?.view?.presentScene(gameScene)
                }
                
                
            } else if  touchLocation.x >= 118 && touchLocation.x <= 178 {
            
                if let gameScene = GameScene(fileNamed: "GameScene") {
                    
                    GameScene.choice = "Penguin"
                    
                    // Set the scale mode to scale to fit the window
                    gameScene.scaleMode = .aspectFill
                    
                    // Present the scene
                    self.scene?.view?.presentScene(gameScene)
                    
                }
            } else if  touchLocation.x >= 196 && touchLocation.x <= 346 {
               
                if let gameScene = GameScene(fileNamed: "GameScene") {
                    
                    GameScene.choice = "Dolphin"
                    
                    // Set the scale mode to scale to fit the window
                    gameScene.scaleMode = .aspectFill
                    
                    // Present the scene
                    self.scene?.view?.presentScene(gameScene)
                }
                
            } else if  touchLocation.x >= 363 && touchLocation.x <= 487 {
                
                if let gameScene = GameScene(fileNamed: "GameScene") {
                    
                    GameScene.choice = "Seal"
                    
                    // Set the scale mode to scale to fit the window
                    gameScene.scaleMode = .aspectFill
                    
                    // Present the scene
                    self.scene?.view?.presentScene(gameScene)
                }
                
            }
            
        }
        
    
    }
    
}
