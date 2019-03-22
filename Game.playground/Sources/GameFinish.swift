import Foundation
import SpriteKit

public class GameFinish: SKScene {
    
    
    override public func didMove(to view: SKView) {
        
        // 1
        backgroundColor = SKColor.white
        
        run(SKAction.playSoundFileNamed("winSound.wav", waitForCompletion: false))
        
        let ground = SKSpriteNode(imageNamed: "winScene")
        ground.name = "Ground"
        ground.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
        ground.position = CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(ground)
        
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
            touchLocation.y > 524 && touchLocation.y < 610 {
            
            if let gameScene = GameScene(fileNamed: "GameScene") {
                
                // Set the scale mode to scale to fit the window
                gameScene.scaleMode = .aspectFill
                
                // Present the scene
                self.scene?.view?.presentScene(gameScene)
            }
            
        }
            // Choose Another character
        else if touchLocation.x > 44 && touchLocation.x < 545 &&
            touchLocation.y > 409 && touchLocation.y < 488 {
            
            if let characterSelection = CharacterSelection(fileNamed: "CharacterSelection") {
                
                // Set the scale mode to scale to fit the window
                characterSelection.scaleMode = .aspectFill
                
                // Present the scene
                self.scene?.view?.presentScene(characterSelection)
                
            }
        }
        
    }
    
}
