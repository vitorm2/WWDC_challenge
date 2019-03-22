import Foundation
import SpriteKit

public class CharacterSelection: SKScene {
    
    var isChooseAcharacter: Bool = false
    
    enum Character {
        case tortoise, penguin, dolphin
    }
    
    var characterInfo = SKSpriteNode()
    
    override public func didMove(to view: SKView) {
        
        
        let ground = SKSpriteNode(imageNamed: "background2")
        ground.name = "Ground"
        ground.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
        ground.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(ground)
        
        let tortoise = SKSpriteNode(imageNamed: "tortoiseSelect")
        tortoise.position = CGPoint(x: tortoise.frame.size.width / 2 + 50 , y: frame.maxY/2 - 210)
        addChild(tortoise)
        
        let penguin = SKSpriteNode(imageNamed: "penguinSelect")
        penguin.position = CGPoint(x: tortoise.frame.size.width + penguin.frame.size.width + 40, y: frame.maxY/2 - 200)
        addChild(penguin)
        
        let dolphin = SKSpriteNode(imageNamed: "dolphinSelect")
        dolphin.position = CGPoint(x: tortoise.frame.size.width + penguin.frame.size.width + dolphin.frame.size.width + 100, y: frame.maxY/2 - 200)
        addChild(dolphin)
        
        
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 1 - Choose one of the touches to work with
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        print(touchLocation)
        
        
        if touchLocation.y >= 214 && touchLocation.y <= 431 {
    
            if touchLocation.x >= 38 && touchLocation.x <= 261 && !isChooseAcharacter {
                
                GameScene.choice = "Tortoise"
                showAnimalInfo(character: .tortoise)
                
                
            } else if  touchLocation.x >= 280 && touchLocation.x <= 472 && !isChooseAcharacter {
            
                GameScene.choice = "Penguin"
                showAnimalInfo(character: .penguin)
                
            } else if  touchLocation.x >= 500 && touchLocation.x <= 660 && !isChooseAcharacter {
               
                GameScene.choice = "Dolphin"
                showAnimalInfo(character: .dolphin)
              
                
            } else if touchLocation.x > 263 && touchLocation.x < 533 && touchLocation.y > 290 && touchLocation.y < 378 && isChooseAcharacter {
                
                characterInfo.removeFromParent()
                
                if let gameScene = GameScene(fileNamed: "GameScene") {
                    
                    // Set the scale mode to scale to fit the window
                    gameScene.scaleMode = .aspectFill
                    
                    // Present the scene
                    self.scene?.view?.presentScene(gameScene)
                }
                
            } else {
                isChooseAcharacter = false
                characterInfo.removeFromParent()
            }
            
        } else {
            isChooseAcharacter = false
            characterInfo.removeFromParent()
        }
        
    
    }
    
    func showAnimalInfo (character: Character) {
        
        switch character {
            case .tortoise:
                characterInfo = SKSpriteNode(imageNamed: "infoTortoise")
            case .penguin:
                characterInfo = SKSpriteNode(imageNamed: "infoPenguin")
            case .dolphin:
                characterInfo = SKSpriteNode(imageNamed: "infoDolphin")
        }
        
        characterInfo.position = CGPoint(x: frame.midX, y: frame.midY)
        self.addChild(characterInfo)
        
        isChooseAcharacter = true
    }
    
}
