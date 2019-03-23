

import PlaygroundSupport
import SpriteKit


let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 768, height: 1024))
if let scene = CharacterSelection(fileNamed: "CharacterSelection") {

    scene.scaleMode = .aspectFit
    
    sceneView.presentScene(scene)
}


PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
