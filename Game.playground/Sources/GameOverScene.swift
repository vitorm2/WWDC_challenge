import Foundation
import SpriteKit

public class GameOverScene: SKScene {
  
    override public func didMove(to view: SKView) {
        
        // 1
        backgroundColor = SKColor.white
        
        // 2
        let message = "You Won!"
        
        // 3
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.black
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
        
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

}
