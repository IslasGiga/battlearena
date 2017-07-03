//
//  MenuScene.swift
//  Battle Arena
//
//  Created by Felipe Borges on 19/06/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class MenuScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
       // addAlertView(with: "New player", and: "Insert your name so we can register you")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setAlertControllerNotification"), object: nil)
    }
    
    func loadRegisterView() {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let listOfNodes = nodes(at: touch.location(in: self))
        
        for node in listOfNodes {
        
            if node.name == "battleButton" {
                if let scene = GKScene(fileNamed: "BattleScene") {
                    
                // Get the SKScene from the loaded GKScene
                    if let sceneNode = scene.rootNode as! BattleScene? {
                    
                    // Copy gameplay related content over to the scene
                    
                    // Set the scale mode to scale to fit the window
                        sceneNode.scaleMode = .aspectFill
                    // Present the scene
                        view?.presentScene(sceneNode)
                }
            }
        }
        }
    }
    
    
    
    func register(with name: String)  {
        
    }
    
}
