import Foundation
import SpriteKit

public class GameFinish: SKScene {
    
    var youSavedTittle = SKSpriteNode()
    
    override public func didMove(to view: SKView) {
        
        backgroundColor = SKColor.white
        
        run(SKAction.playSoundFileNamed("winSound.wav", waitForCompletion: false))
        
        let ground = SKSpriteNode(imageNamed: "winScene")
        ground.name = "Ground"
        ground.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
        ground.position = CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(ground)
        
        
        switch GameScene.choice {
            case "Tortoise": self.youSavedTittle = SKSpriteNode(imageNamed: "savedAndy")
            case "Penguin": self.youSavedTittle = SKSpriteNode(imageNamed: "savedMick")
            case "Dolphin": self.youSavedTittle = SKSpriteNode(imageNamed: "savedKelly")
            default: print("error")
        }
        youSavedTittle.position = CGPoint(x: frame.midX, y: frame.maxY - 250)
        addChild(youSavedTittle)
        
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        
        print(touchLocation)
        // Play Again
        if touchLocation.x > 50 && touchLocation.x < 289 &&
            touchLocation.y > 230 && touchLocation.y < 297 {
            
            if let gameScene = GameScene(fileNamed: "GameScene") {
                
                gameScene.scaleMode = .aspectFit
                self.scene?.view?.presentScene(gameScene)
            }
            
        }
            // Choose Another character
        else if touchLocation.x > 58 && touchLocation.x < 611 &&
            touchLocation.y > 111 && touchLocation.y < 171 {
            
            if let characterSelection = CharacterSelection(fileNamed: "CharacterSelection") {
                
                characterSelection.scaleMode = .aspectFit
                self.scene?.view?.presentScene(characterSelection)
                
            }
        }
        
    }
    
}
