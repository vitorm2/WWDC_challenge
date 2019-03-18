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
        title.position = CGPoint(x: frame.maxX/2 - title.frame.size.width / 2 , y: frame.maxY - 150)
        addChild(title)
        
        
        let label = SKLabelNode(fontNamed: "San Francisco")
        label.text =  "Choose your Character:"
        label.fontSize = 15
        label.fontColor = SKColor.black
        label.position = CGPoint(x: label.frame.size.width / 2 + 50, y: frame.maxY/2 - 100)
        addChild(label)
        
        let tortoise = SKSpriteNode(imageNamed: "tortoiseSelect")
        tortoise.position = CGPoint(x: tortoise.frame.size.width / 2 + 100 , y: frame.maxY/2 - 200)
        addChild(tortoise)
        
        let penguin = SKSpriteNode(imageNamed: "penguinSelect")
        penguin.position = CGPoint(x: tortoise.frame.size.width + penguin.frame.size.width + 70, y: frame.maxY/2 - 200)
        addChild(penguin)
        
        let dolphin = SKSpriteNode(imageNamed: "dolphinSelect")
        dolphin.position = CGPoint(x: tortoise.frame.size.width + penguin.frame.size.width + dolphin.frame.size.width + 70, y: frame.maxY/2 - 200)
        addChild(dolphin)
        
        let seal = SKSpriteNode(imageNamed: "sealSelect")
        seal.position = CGPoint(x: tortoise.frame.size.width + penguin.frame.size.width + dolphin.frame.size.width + seal.frame.size.width + 100, y: frame.maxY/2 - 200)
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
        
        print(touchLocation)
        
        
        if touchLocation.y >= 250 && touchLocation.y <= 375 {
    
            if touchLocation.x >= 107 && touchLocation.x <= 201 {
            
                
                if let gameScene = GameScene(fileNamed: "GameScene") {
                    
                    GameScene.choice = "Tortoise"
                    
                    // Set the scale mode to scale to fit the window
                    gameScene.scaleMode = .aspectFill
                    
                    // Present the scene
                    self.scene?.view?.presentScene(gameScene)
                }
                
                
            } else if  touchLocation.x >= 225 && touchLocation.x <= 319 {
            
                if let gameScene = GameScene(fileNamed: "GameScene") {
                    
                    GameScene.choice = "Penguin"
                    
                    // Set the scale mode to scale to fit the window
                    gameScene.scaleMode = .aspectFill
                    
                    // Present the scene
                    self.scene?.view?.presentScene(gameScene)
                    
                }
            } else if  touchLocation.x >= 350 && touchLocation.x <= 513 {
               
                if let gameScene = GameScene(fileNamed: "GameScene") {
                    
                    GameScene.choice = "Dolphin"
                    
                    // Set the scale mode to scale to fit the window
                    gameScene.scaleMode = .aspectFill
                    
                    // Present the scene
                    self.scene?.view?.presentScene(gameScene)
                }
                
            } else if  touchLocation.x >= 540 && touchLocation.x <= 679 {
                
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
