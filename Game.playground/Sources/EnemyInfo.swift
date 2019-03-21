import Foundation
import SpriteKit

public class EnemyInfo: SKScene {
    
    
    override public func didMove(to view: SKView) {
        
        // 1
        backgroundColor = SKColor.white
        
        // 2
        
        // 3
        let title = SKLabelNode(fontNamed: "Chalkduster")
        title.text = "You Lose!"
        title.fontSize = 40
        title.fontColor = SKColor.black
        title.position = CGPoint(x: frame.midX, y: frame.maxY - 200 )
        addChild(title)
        
        
        let tryAgain = SKLabelNode(fontNamed: "Chalkduster")
        tryAgain.text = "Try Again"
        tryAgain.fontSize = 20
        tryAgain.fontColor = SKColor.black
        tryAgain.position = CGPoint(x: tryAgain.frame.size.width / 2 + 50 , y: frame.maxY/2 + 50 )
        addChild(tryAgain)
        
        let chooseCharacter = SKLabelNode(fontNamed: "Chalkduster")
        chooseCharacter.text = "Choose another character"
        chooseCharacter.fontSize = 20
        chooseCharacter.fontColor = SKColor.black
        chooseCharacter.position = CGPoint(x: chooseCharacter.frame.size.width / 2 + 50, y: (frame.maxY/2) - 50)
        addChild(chooseCharacter)
        
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 1 - Choose one of the touches to work with
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        
        print(touchLocation)
        
        // Try Again
        if touchLocation.x > 44 && touchLocation.x < 180 &&
            touchLocation.y > 545 && touchLocation.y < 591 {
            
            if let gameScene = GameScene(fileNamed: "GameScene") {
                
                GameScene.choice = "Tortoise"
                
                // Set the scale mode to scale to fit the window
                gameScene.scaleMode = .aspectFill
                
                // Present the scene
                self.scene?.view?.presentScene(gameScene)
            }
            
        }
            // Choose Another character
        else if touchLocation.x > 44 && touchLocation.x < 367 &&
            touchLocation.y > 442 && touchLocation.y < 496 {
            
            if let characterSelection = CharacterSelection(fileNamed: "CharacterSelection") {
                
                // Set the scale mode to scale to fit the window
                characterSelection.scaleMode = .aspectFill
                
                // Present the scene
                self.scene?.view?.presentScene(characterSelection)
                
            }
        }
        
    }
    
}
