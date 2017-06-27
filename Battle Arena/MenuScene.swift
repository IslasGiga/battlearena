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
        addAlertView(with: "New player", and: "Insert your name so we can register you")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setAlertControllerNotification"), object: nil)
    }
    
    func loadRegisterView() {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let listOfNodes = nodes(at: touch.location(in: self))
        
        for node in listOfNodes {
        
        if node.name == "playButton" {
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
    
    func addAlertView(with title: String, and message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let viewController = self.view?.window?.rootViewController
        
        let registerAction = UIAlertAction(title: "Register", style: .default) { (action) in
            
            let text = alertController.textFields?[0].text
            
            if (text?.characters.count)! > 0 {
                self.register(with: (text)!)
            } else {
                let alert = UIAlertController(title: "Invalid name", message: "The name field is empty", preferredStyle: .alert)
                
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addTextField { textField in
            textField.placeholder = "Name"
        }
        
        alertController.addAction(registerAction)
        alertController.addAction(cancelAction)
        
        viewController?.present(alertController, animated: true, completion: nil)
        
    }
    
    func register(with name: String)  {
        
    }
    
}
