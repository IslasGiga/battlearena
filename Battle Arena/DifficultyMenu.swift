//
//  DifficultyMenu.swift
//  Battle Arena
//
//  Created by Marcus Reuber Almeida Moraes Silva on 06/09/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class DifficultyMenu: SKScene {
    
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
    }
    
    
    
    func loadRegisterView() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let listOfNodes = nodes(at: touch.location(in: self))
        
        
        
        for node in listOfNodes {
            
            if node.name == "easyButton" {
                if let scene = GKScene(fileNamed: "BattleScene") {
                    
                    // Get the SKScene from the loaded GKScene
                    if let sceneNode = scene.rootNode as! BattleScene? {
                        
                        // Copy gameplay related content over to the scene
                        sceneNode.enemy = AIEnemy(game: sceneNode, names: ["Wizard","Mummy","Elf","Satyr","Satyr","Mummy","Elf","Wizard"] , level: 0)
                        // Set the scale mode to scale to fit the window
                        sceneNode.scaleMode = .aspectFill
                        // Present the scene
                        view?.presentScene(sceneNode)
                    }
                }
            }
            
            if node.name == "hardButton" {
                if let scene = GKScene(fileNamed: "BattleScene") {
                    
                    // Get the SKScene from the loaded GKScene
                    if let sceneNode = scene.rootNode as! BattleScene? {
                        
                        // Copy gameplay related content over to the scene
                        sceneNode.enemy = AIEnemy(game: sceneNode, names: ["Wizard","Mummy","Elf","Satyr","Satyr","Mummy","Elf","Wizard"], level: 1)
                        // Set the scale mode to scale to fit the window
                        sceneNode.scaleMode = .aspectFill
                        // Present the scene
                        view?.presentScene(sceneNode)
                    }
                }
            }
            
            if node.name == "cancelButton" {
                if let scene = GKScene(fileNamed: "MenuuScene"){
                    if let sceneNode = scene.rootNode as! MenuScene? {
                        sceneNode.scaleMode = .aspectFill
                        //view?.presentScene(sceneNode)
                        view?.presentScene(sceneNode, transition: .flipVertical(withDuration: 0.4))
                        //view?.presentScene(sceneNode, transition: .moveIn(with: .down, duration: 0.4))
                    }
                }
            }
            
        }
    }
    
}
