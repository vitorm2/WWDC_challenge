import Foundation
import SpriteKit

public class GameOverScene: SKScene {
    
    var loseTittle = SKSpriteNode()
    
    override public func didMove(to view: SKView) {
        

        backgroundColor = SKColor.white
        
        run(SKAction.playSoundFileNamed("loseGame.wav", waitForCompletion: false))
        
        
        let ground = SKSpriteNode(imageNamed: "loseScene")
        ground.name = "Ground"
        ground.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
        ground.position = CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(ground)
        
        
        switch GameScene.choice {
        case "Tortoise": self.loseTittle = SKSpriteNode(imageNamed: "loseAndy")
        case "Penguin": self.loseTittle = SKSpriteNode(imageNamed: "loseMick")
        case "Dolphin": self.loseTittle = SKSpriteNode(imageNamed: "loseKelly")
        default: print("error")
        }
        loseTittle.position = CGPoint(x: frame.midX, y: frame.maxY - 250)
        addChild(loseTittle)
        
        
}
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        
        // Try Again
        if touchLocation.x > 52 && touchLocation.x < 278 &&
            touchLocation.y > 448 && touchLocation.y < 516 {
            
            run(SKAction.playSoundFileNamed("continueSong.wav", waitForCompletion: true)) {
                if let gameScene = GameScene(fileNamed: "GameScene") {
                    
                    gameScene.scaleMode = .aspectFit
                    self.scene?.view?.presentScene(gameScene)
                }
            }
            
           
        
        }
        // Choose Another character
        else if touchLocation.x > 55 && touchLocation.x < 614 &&
            touchLocation.y > 330 && touchLocation.y < 396 {
    
            
            run(SKAction.playSoundFileNamed("continueSong.wav", waitForCompletion: true)) {
                if let characterSelection = CharacterSelection(fileNamed: "CharacterSelection") {
                    
                    characterSelection.scaleMode = .aspectFit
                    self.scene?.view?.presentScene(characterSelection)
                }
            }
        }
        
    }

}
